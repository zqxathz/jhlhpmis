unit clientsycdm;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, Data.DBXCommon,
  IPPeerClient, Data.DB, Data.SqlExpr, Data.DbxHTTPLayer, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageBin,Vcl.Dialogs;

type
  TclientsycDataModule = class(TDataModule)
    SQLConnection1: TSQLConnection;
    expoFDQuery: TFDQuery;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    customertypeFDQuery: TFDQuery;
    paytypeFDQuery: TFDQuery;
    expotypeFDQuery: TFDQuery;
    shoppersourceFDQuery: TFDQuery;
    memberFDQuery: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FCantConnection:boolean;
    FSyncError:boolean;
    FOnExec:TGetStrProc;
  public
    { Public declarations }
    function test:string;
    procedure openexpodata;
    procedure GetExpoData;
    procedure GetCustomertypeData;
    procedure GetPaytypeData;
    procedure GetExpotypeData;
    procedure GetShoppersourceData;
    procedure GetMemberData;
  published
    property CantConnection:boolean read FCantConnection;
    property SyncError:boolean read FSyncError;
    property OnExec:TGetStrProc read FOnExec write FOnExec;
  end;

var
  clientsycDataModule: TclientsycDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses servermethods,connectiondm;
{$R *.dfm}

// Copy stream without using .Size or .Seek
function CopyStream(const AStream: TStream): TMemoryStream;
var
  LBuffer: TBytes;
  LCount: Integer;
begin
  Result := TMemoryStream.Create;
  try
    SetLength(LBuffer, 1024 * 32);
    while True do
    begin
      LCount := AStream.Read(LBuffer, Length(LBuffer));
      Result.Write(LBuffer, LCount);
      if LCount < Length(LBuffer) then
        break;
    end;
  except
    Result.Free;
    raise;
  end;
end;

function UnixDateToDateTime(const USec: Longint): TDateTime;
const
  cUnixStartDate: TDateTime = 25569.0; // 1970/01/01
begin
  Result := (USec / 86400) + cUnixStartDate;
end;

{ TclientsycDataModule }

procedure TclientsycDataModule.DataModuleCreate(Sender: TObject);
begin
 FOnExec:=nil;
 FSyncError:=false;
 FCantConnection:=false;
 try
   SQLConnection1.Open;
 except
   FCantConnection:=true;
   //raise Exception.Create('Error Message');
 end;
 expotypeFDQuery.Connection:=connectionDataModule.mainFDConnection;
 expoFDQuery.Connection:=connectionDataModule.mainFDConnection;
 customertypeFDQuery.Connection:= connectionDataModule.mainFDConnection;
 paytypeFDQuery.Connection:= connectionDataModule.mainFDConnection;
 memberFDQuery.Connection:=connectionDataModule.mainFDConnection;
 shoppersourceFDQuery.Connection:=connectionDataModule.mainFDConnection;
end;

procedure TclientsycDataModule.DataModuleDestroy(Sender: TObject);
begin
 SQLConnection1.Close;
end;

//获取客户类型数据
procedure TclientsycDataModule.GetCustomertypeData;
var
 server:TObject;
 stream:TStream;
 memtable:TFDMemTable;
 ierror:Integer;
begin
 server:=nil;
 stream:=nil;
 if not SQLConnection1.Connected then
   try
     SQLConnection1.Open;
   except on E: Exception do
     begin
       FSyncError:=true;
       if Assigned(FOnExec) then
         FOnExec('错误:远程连接发生异常,同步中止!'+#13#10+E.Message);
       exit;
     end;
   end;

  try
    server:=TServerMethodsClient.Create(SQLConnection1.DBXConnection);
    stream:=TServerMethodsClient(Server).CustomertypeData('','');
  except
    SQLConnection1.Close;
    server.free;
    stream.Free;
    FSyncError:=true;
    if Assigned(FOnExec) then
       FOnExec('错误:获取远程数据发生异常,同步中止!');
    exit;
  end;
  stream.Position:=0;

  if Assigned(FOnExec) then
       FOnExec('开始更新客户类型');

  memtable:=TFDMemTable.Create(nil);
  memtable.LoadFromStream(stream,TFDStorageFormat.sfBinary);
  memtable.First;
  customertypeFDQuery.Open;
  customertypeFDQuery.UpdateOptions.UpdateTableName:='jhlh_crm_customerstype';
  customertypeFDQuery.CopyDataSet(memtable);

  customertypeFDQuery.Connection.StartTransaction;
  customertypeFDQuery.Connection.ExecSQL('delete FROM jhlh_crm_customerstype');
  ierror:=customertypeFDQuery.ApplyUpdates;
  if ierror>0 then
  begin
    customertypeFDQuery.Connection.Rollback;
    FSyncError:=true;
    if Assigned(FOnExec) then
         FOnExec('错误:客户类型更新到本地时出现异常');
  end
  else
  begin
    customertypeFDQuery.Connection.Commit;
    customertypeFDQuery.Close;
    if Assigned(FOnExec) then
       FOnExec('客户类型更新完成');
  end;

  server.Free;
  memtable.Free;
end;

//获取展会数据
procedure TclientsycDataModule.GetExpoData;
var
 server:tobject;
 stream:Tstream;
 memtable:TFDMemTable;
 i,ierror: Integer;
 fieldname:string;
begin
   server:=nil;
   stream:=nil;

   if not SQLConnection1.Connected then
   try
     SQLConnection1.Open;
   except on E: Exception do
     begin
       FSyncError:=true;
       if Assigned(FOnExec) then
         FOnExec('错误:远程连接发生异常,同步中止!'+#13#10+E.Message);
       exit;
     end;
   end;

  try
    server:=TServerMethodsClient.Create(SQLConnection1.DBXConnection);
    stream:=TServerMethodsClient(Server).ExpoData('','');
  except
    SQLConnection1.Close;
    server.free;
    stream.Free;
    FSyncError:=true;
    if Assigned(FOnExec) then
       FOnExec('错误:获取远程数据发生异常,同步中止!');
    exit;
  end;
  stream.Position:=0;
  expoFDQuery.Close;
  expoFDQuery.UpdateOptions.UpdateTableName:='jhlh_pmis_expo';
  expoFDQuery.Open;

  if Assigned(FOnExec) then
       FOnExec('开始更新展会信息');

  memtable:=TFDMemTable.Create(nil);
  memtable.LoadFromStream(stream,TFDStorageFormat.sfBinary);
  memtable.First;
  while not memtable.Eof do
  begin
    expoFDQuery.Append;
    for i := 0 to memtable.FieldCount-1 do
    begin
      fieldname:= memtable.FieldDefs.Items[i].Name;
      if fieldname='clientvisable' then continue;
      if (fieldname='startdate') or (fieldname='enddate') or (fieldname='beforedate') or (fieldname='afterdate')  then
        expoFDQuery.FieldValues[fieldname] := FormatDateTime('yyyy-mm-dd',
                 UnixDateToDateTime(memtable.FieldByName(fieldname).AsInteger))
      else
        expoFDQuery.FieldValues[fieldname]:=memtable.FieldValues[fieldname];
    end;
    memtable.Next;
  end;
  expoFDQuery.Connection.StartTransaction;
  expoFDQuery.Connection.ExecSQL('delete FROM jhlh_pmis_expo');
  ierror := expoFDQuery.ApplyUpdates;
  if ierror>0 then
  begin
    expoFDQuery.Connection.Rollback;
    FSyncError:=true;
    if Assigned(FOnExec) then
         FOnExec('错误:展会信息更新到本地时出现异常');
  end
  else
  begin
    expoFDQuery.Connection.Commit;
    expoFDQuery.CommitUpdates;
    expoFDQuery.Close;
    FSyncError:=false;
    if Assigned(FOnExec) then
         FOnExec('展会信息更新完成');
  end;
  server.Free;
  memtable.Free;
end;

//获取支付类型数据
procedure TclientsycDataModule.GetPaytypeData;
var
 server:TObject;
 stream:TStream;
 memtable:TFDMemTable;
 ierror:Integer;
begin
 server:=nil;
 stream:=nil;
 if not SQLConnection1.Connected then
   try
     SQLConnection1.Open;
   except on E: Exception do
     begin
       FSyncError:=true;
       if Assigned(FOnExec) then
         FOnExec('错误:远程连接发生异常,同步中止!'+#13#10+E.Message);
       exit;
     end;
   end;

  try
    server:=TServerMethodsClient.Create(SQLConnection1.DBXConnection);
    stream:=TServerMethodsClient(Server).PaytypeData('','');
  except
    SQLConnection1.Close;
    server.free;
    stream.Free;
    FSyncError:=true;
    if Assigned(FOnExec) then
       FOnExec('错误:获取远程数据发生异常,同步中止!');
    exit;
  end;
  stream.Position:=0;

  if Assigned(FOnExec) then
       FOnExec('开始更新支付方式');

  memtable:=TFDMemTable.Create(nil);
  memtable.LoadFromStream(stream,TFDStorageFormat.sfBinary);
  memtable.First;
  paytypeFDQuery.Open;
  paytypeFDQuery.UpdateOptions.UpdateTableName:='jhlh_pmis_paytype';
  paytypeFDQuery.CopyDataSet(memtable);

  paytypeFDQuery.Connection.StartTransaction;
  paytypeFDQuery.Connection.ExecSQL('delete FROM jhlh_pmis_paytype');
  ierror:=paytypeFDQuery.ApplyUpdates;
  if ierror>0 then
  begin
    paytypeFDQuery.Connection.Rollback;
    FSyncError:=true;
    if Assigned(FOnExec) then
         FOnExec('错误:支付方式更新到本地时出现异常');
  end
  else
  begin
    paytypeFDQuery.Connection.Commit;
    paytypeFDQuery.Close;
    if Assigned(FOnExec) then
       FOnExec('支付方式更新完成');
  end;

  server.Free;
  memtable.Free;
end;

//获取展会类型数据
procedure TclientsycDataModule.GetExpotypeData;
var
 server:TObject;
 stream:TStream;
 memtable:TFDMemTable;
 ierror:Integer;
begin
 server:=nil;
 stream:=nil;
 if not SQLConnection1.Connected then
   try
     SQLConnection1.Open;
   except on E: Exception do
     begin
       FSyncError:=true;
       if Assigned(FOnExec) then
         FOnExec('错误:远程连接发生异常,同步中止!'+#13#10+E.Message);
       exit;
     end;
   end;

  if Assigned(FOnExec) then
    FOnExec('开始同步数据');

  try
    server:=TServerMethodsClient.Create(SQLConnection1.DBXConnection);
    stream:=TServerMethodsClient(Server).ExpoTypeData('','');
  except
    SQLConnection1.Close;
    server.free;
    stream.Free;
    FSyncError:=true;
    if Assigned(FOnExec) then
       FOnExec('错误:获取远程数据发生异常,同步中止!');
    exit;
  end;
  stream.Position:=0;

  if Assigned(FOnExec) then
       FOnExec('开始更新展会类型');

  memtable:=TFDMemTable.Create(nil);
  memtable.LoadFromStream(stream,TFDStorageFormat.sfBinary);
  memtable.First;
  expotypeFDQuery.Open;
  expotypeFDQuery.UpdateOptions.UpdateTableName:='jhlh_pmis_expotype';
  expotypeFDQuery.CopyDataSet(memtable);

  expotypeFDQuery.Connection.StartTransaction;
  expotypeFDQuery.Connection.ExecSQL('delete FROM jhlh_pmis_expotype');
  ierror:=expotypeFDQuery.ApplyUpdates;
  if ierror>0 then
  begin
    expotypeFDQuery.Connection.Rollback;
    FSyncError:=true;
    if Assigned(FOnExec) then
         FOnExec('错误:展会类型更新到本地时出现异常');
  end
  else
  begin
    expotypeFDQuery.Connection.Commit;
    expotypeFDQuery.Close;
    if Assigned(FOnExec) then
       FOnExec('展会类型更新完成');
  end;

  server.Free;
  memtable.Free;
end;

//获取系统用户数据
procedure TclientsycDataModule.GetMemberData;
var
 server:TObject;
 stream:TStream;
 memtable:TFDMemTable;
 ierror:Integer;
begin
 server:=nil;
 stream:=nil;
 if not SQLConnection1.Connected then
   try
     SQLConnection1.Open;
   except on E: Exception do
     begin
       FSyncError:=true;
       if Assigned(FOnExec) then
         FOnExec('错误:远程连接发生异常,同步中止!'+#13#10+E.Message);
       exit;
     end;
   end;

  try
    server:=TServerMethodsClient.Create(SQLConnection1.DBXConnection);
    stream:=TServerMethodsClient(Server).MemberData;
  except
    SQLConnection1.Close;
    server.free;
    stream.Free;
    FSyncError:=true;
    if Assigned(FOnExec) then
       FOnExec('错误:获取远程数据发生异常,同步中止!');
    exit;
  end;
  stream.Position:=0;

  if Assigned(FOnExec) then
       FOnExec('开始更新系统用户');

  memtable:=TFDMemTable.Create(nil);
  memtable.LoadFromStream(stream,TFDStorageFormat.sfBinary);
  memtable.First;
  memberFDQuery.Open;
  memberFDQuery.UpdateOptions.UpdateTableName:='jhlh_admin_member';
  memberFDQuery.CopyDataSet(memtable);

  memberFDQuery.Connection.StartTransaction;
  memberFDQuery.Connection.ExecSQL('delete FROM jhlh_admin_member');
  ierror:=memberFDQuery.ApplyUpdates;
  if ierror>0 then
  begin
    memberFDQuery.Connection.Rollback;
    FSyncError:=true;
    if Assigned(FOnExec) then
         FOnExec('错误系统用户更新到本地时出现异常');
  end
  else
  begin
    memberFDQuery.Connection.Commit;
    memberFDQuery.Close;
    if Assigned(FOnExec) then
       FOnExec('系统用户更新完成');
  end;

  server.Free;
  memtable.Free;

end;

//获取顾客来源数据
procedure TclientsycDataModule.GetShoppersourceData;
var
 server:TObject;
 stream:TStream;
 memtable:TFDMemTable;
 ierror:Integer;
begin
 server:=nil;
 stream:=nil;
 if not SQLConnection1.Connected then
   try
     SQLConnection1.Open;
   except on E: Exception do
     begin
       FSyncError:=true;
       if Assigned(FOnExec) then
         FOnExec('错误:远程连接发生异常,同步中止!'+#13#10+E.Message);
       exit;
     end;
   end;

  try
    server:=TServerMethodsClient.Create(SQLConnection1.DBXConnection);
    stream:=TServerMethodsClient(Server).ShopperSourceData('','');
  except
    SQLConnection1.Close;
    server.free;
    stream.Free;
    FSyncError:=true;
    if Assigned(FOnExec) then
       FOnExec('错误:获取远程数据发生异常,同步中止!');
    exit;
  end;
  stream.Position:=0;

  if Assigned(FOnExec) then
       FOnExec('开始更新顾客来源');

  memtable:=TFDMemTable.Create(nil);
  memtable.LoadFromStream(stream,TFDStorageFormat.sfBinary);
  memtable.First;
  shoppersourceFDQuery.Open;
  shoppersourceFDQuery.UpdateOptions.UpdateTableName:='jhlh_pmis_shopper_sourcetype';
  shoppersourceFDQuery.CopyDataSet(memtable);

  shoppersourceFDQuery.Connection.StartTransaction;
  shoppersourceFDQuery.Connection.ExecSQL('delete FROM jhlh_pmis_shopper_sourcetype');
  ierror:=shoppersourceFDQuery.ApplyUpdates;
  if ierror>0 then
  begin
    shoppersourceFDQuery.Connection.Rollback;
    FSyncError:=true;
    if Assigned(FOnExec) then
         FOnExec('错误:顾客来源更新到本地时出现异常');
  end
  else
  begin
    shoppersourceFDQuery.Connection.Commit;
    shoppersourceFDQuery.Close;
    if Assigned(FOnExec) then
       FOnExec('顾客来源更新完成');
  end;

  server.Free;
  memtable.Free;
end;


procedure TclientsycDataModule.openexpodata;
begin
  GetExpoData;
end;

function TclientsycDataModule.test: string;
var
 server:Tobject;
 s:string;
begin
 s:='abc';
 server:=TServerMethodsClient.Create(SQLConnection1.DBXConnection);
 s:=TServerMethodsClient(server).ReverseString('abcdef');
 TServerMethodsClient(Server).Destroy;
 Result:=s;
end;

end.
