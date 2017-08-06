unit clientsycdm;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DBXDataSnap,
  Data.DBXCommon,
  IPPeerClient,
  Data.DB,
  Data.SqlExpr,
  Data.DbxHTTPLayer,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin,
  Vcl.Dialogs,
  System.JSON,
  System.Variants,
  Datasnap.DBClient,
  Data.DBXTrace,
  setting;

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
    removecustomerFDCommand: TFDCommand;
    customerFDQuery: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure customerFDQueryUpdateError(ASender: TDataSet; AException: EFDException; ARow: TFDDatSRow; ARequest: TFDUpdateRequest; var AAction: TFDErrorAction);
    procedure SQLConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
    FCantConnection: boolean;
    FSyncError: boolean;   //当发生错误时,用于停止继续执行下面的远程方法
    FOnExec: TGetStrProc;
    FErrorJson: TJsonObject;
  public
    { Public declarations }
    ErrorMsg: string;
    function test: string;
    procedure openexpodata;
    procedure GetExpoData;
    procedure GetCustomertypeData;
    procedure GetPaytypeData;
    procedure GetExpotypeData;
    procedure GetShoppersourceData;
    procedure GetMemberData;
    procedure GetCustomerData;
    procedure RemoveCustomerData;
  published
    property CantConnection: boolean read FCantConnection;
    property SyncError: boolean read FSyncError;
    property OnExec: TGetStrProc read FOnExec write FOnExec;
  end;

var
  clientsycDataModule: TclientsycDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  servermethods,
  connectiondm;
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

procedure TclientsycDataModule.customerFDQueryUpdateError(ASender: TDataSet; AException: EFDException; ARow: TFDDatSRow; ARequest: TFDUpdateRequest; var AAction: TFDErrorAction);
begin
  if AException.FDCode <> 1600 then
  begin
    if not Assigned(FErrorJson) then
      FErrorJson := TJSONObject.Create;
    FErrorJson.AddPair(AException.Message + ',' + AException.FDCode.ToString, Vartostr(ARow.GetData('id')));
  end
  else
  begin
    AAction := eaSkip;
  end;
end;

procedure TclientsycDataModule.DataModuleCreate(Sender: TObject);
begin
  FOnExec := nil;
  FSyncError := false;
  FCantConnection := false;
  if not Assigned(clientuser) then
  begin
    SQLConnection1.Params.Values['DSAuthenticationPassword'] := 'guest';
    SQLConnection1.Params.Values['DSAuthenticationUser'] := 'guest';
  end
  else begin
    SQLConnection1.Params.Values['DSAuthenticationPassword'] := clientuser.Password;
    SQLConnection1.Params.Values['DSAuthenticationUser'] := clientuser.Username;
  end;
  try
    SQLConnection1.Connected:=true;
  except
    on E: Exception do
    begin
      FCantConnection := true;
      ErrorMsg := E.Message;
      //raise  Exception.Create(TDBXError(E).ErrorCode.ToString+','+ E.Message);
      exit;
    end;
  end;

  expotypeFDQuery.Connection := connectionDataModule.mainFDConnection;
  expoFDQuery.Connection := connectionDataModule.mainFDConnection;
  customertypeFDQuery.Connection := connectionDataModule.mainFDConnection;
  paytypeFDQuery.Connection := connectionDataModule.mainFDConnection;
  memberFDQuery.Connection := connectionDataModule.mainFDConnection;
  shoppersourceFDQuery.Connection := connectionDataModule.mainFDConnection;
  removecustomerFDCommand.Connection := connectionDataModule.mainFDConnection;
  customerFDQuery.Connection := connectionDataModule.mainFDConnection;
end;

procedure TclientsycDataModule.DataModuleDestroy(Sender: TObject);
begin
  SQLConnection1.Close;
end;

{
获取服务端客户数据
}
procedure TclientsycDataModule.GetCustomerData;
var
  server: TObject;
  stream: TStream;
  lstream: TMemoryStream;
  memtable: TFDMemTable;
  ierror: Integer;
begin
  server := nil;
  stream := nil;

  if Assigned(FOnExec) then
   FOnExec('开始更新客户数据');

  if not SQLConnection1.Connected then
  try
    SQLConnection1.Open;
  except
    on E: Exception do
    begin
      FSyncError := true;
      if Assigned(FOnExec) then
        FOnExec('错误:远程连接发生异常,同步中止!' + #13#10 + E.Message);
      exit;
    end;
  end;

  try
    server := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
    stream := TServerMethodsClient(server).CustomerData;
  except
    on E: Exception do
    begin
      SQLConnection1.Close;
      server.free;
      stream.Free;
      FSyncError := true;
      errormsg:='错误:获取远程数据发生异常,同步中止!';
      if E is TDBXError then
      begin
        if (E as TDBXError).ErrorCode=113 then
        begin
          FSyncError:=false;
          errormsg:='错误:当前用户未被授权调用该数据';
        end;
      end;
      if Assigned(FOnExec) then
        FOnExec(errormsg);
      exit;
    end;
  end;



  if (stream=nil) or (stream.Size=0) then
  begin
    SQLConnection1.Close;
    server.Free;
    if Assigned(FOnExec) then
      FOnExec('提示:没有获取到任何客户数据');
    exit;
  end;

  stream.Position := 0;

  lstream := TMemoryStream.Create;
  try
    lstream := CopyStream(stream);
    lstream.Position := 0;


    memtable := TFDMemTable.Create(nil);
    memtable.LoadFromStream(lstream, TFDStorageFormat.sfBinary);
    memtable.First;
    customerFDQuery.Open;
    customerFDQuery.UpdateOptions.UpdateTableName := 'jhlh_pmis_customers';
    customerFDQuery.CopyDataSet(memtable);
    customertypeFDQuery.UpdateOptions.AutoIncFields := 'id';
    customerFDQuery.FieldByName('id').ProviderFlags := customerFDQuery.FieldByName('id').ProviderFlags - [pfInUpdate];
    customerFDQuery.IndexFieldNames := 'id;update_microsecond';
    customertypeFDQuery.UpdateOptions.KeyFields := 'update_microsecond';
    customerFDQuery.Connection.StartTransaction;
    ierror := customerFDQuery.ApplyUpdates;
    removecustomerFDCommand.Execute;
    removecustomerFDCommand.NextRecordSet;
    removecustomerFDCommand.Execute;
    if ierror > 0 then
    begin
      customerFDQuery.Connection.Rollback;
      FSyncError := true;
      if Assigned(FOnExec) then
      begin
        FOnExec('错误:客户数据更新到本地时出现异常');
        if Assigned(FErrorJson) then
          FOnExec(FErrorJson.ToJSON);
      end;
      if Assigned(FErrorJson) then
        FreeAndNil(FErrorJson);
    end
    else
    begin
      customerFDQuery.Connection.Commit;
      customerFDQuery.Close;
      if Assigned(FOnExec) then
        FOnExec('客户数据更新完成');
    end;
  finally
    lstream.Free;
    server.Free;
    memtable.Free;
  end;
end;

procedure TclientsycDataModule.GetCustomertypeData;
//获取客户类型数据
var
  server: TObject;
  stream:TStream;
  lstream: TMemoryStream;
  memtable: TFDMemTable;
  ierror: Integer;
  errormsg:string;
begin
  server := nil;
  stream := nil;
  lstream:=nil;

  if Assigned(FOnExec) then
      FOnExec('开始更新客户类型');

  if not SQLConnection1.Connected then
  try
    SQLConnection1.Open;
  except
    on E: Exception do
    begin
      FSyncError := true;
      if Assigned(FOnExec) then
        FOnExec('错误:远程连接发生异常,同步中止!' + #13#10 + E.Message);
      exit;
    end;
  end;

  try
    server := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
    stream := TServerMethodsClient(server).CustomertypeData('', '');
  except
    on E: Exception do
    begin
      SQLConnection1.Close;
      server.free;
      stream.Free;
      FSyncError := true;
      errormsg:='错误:获取远程数据发生异常,同步中止!';
      if E is TDBXError then
      begin
        if (E as TDBXError).ErrorCode=113 then
        begin
          FSyncError:=false;
          errormsg:='错误:当前用户未被授权调用该数据';
        end;
      end;
      if Assigned(FOnExec) then
        FOnExec(errormsg);
      exit;
    end;
  end;

  stream.Position := 0;
  lstream:=TMemoryStream.Create;
  try
    lstream:=CopyStream(stream);
    lstream.Position:=0;

    memtable := TFDMemTable.Create(nil);
    memtable.LoadFromStream(lstream, TFDStorageFormat.sfBinary);
    memtable.First;
    customertypeFDQuery.Open;
    customertypeFDQuery.UpdateOptions.UpdateTableName := 'jhlh_crm_customerstype';
    customertypeFDQuery.CopyDataSet(memtable);

    customertypeFDQuery.Connection.StartTransaction;
    customertypeFDQuery.Connection.ExecSQL('delete FROM jhlh_crm_customerstype');
    ierror := customertypeFDQuery.ApplyUpdates;
    if ierror > 0 then
    begin
      customertypeFDQuery.Connection.Rollback;
      FSyncError := true;
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
  finally
    lstream.Free;
    server.Free;
    memtable.Free;
  end;

end;

//获取展会数据
procedure TclientsycDataModule.GetExpoData;
var
  server: tobject;
  stream: Tstream;
  lstream:TMemoryStream;
  memtable: TFDMemTable;
  i, ierror: Integer;
  fieldname: string;
  errormsg:string;
begin
  server := nil;
  stream := nil;
  lstream:=nil;

  if Assigned(FOnExec) then
    FOnExec('开始更新展会信息');

  if not SQLConnection1.Connected then
  try
    SQLConnection1.Open;
  except
    on E: Exception do
    begin
      FSyncError := true;
      if Assigned(FOnExec) then
        FOnExec('错误:远程连接发生异常,同步中止!' + #13#10 + E.Message);
      exit;
    end;
  end;

  try
    server := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
    stream := TServerMethodsClient(server).ExpoData('', '');
  except
    on E: Exception do
    begin
      SQLConnection1.Close;
      server.free;
      stream.Free;
      FSyncError := true;
      errormsg:='错误:获取远程数据发生异常,同步中止!';
      if E is TDBXError then
      begin
        if (E as TDBXError).ErrorCode=113 then
        begin
          FSyncError:=false;
          errormsg:='错误:当前用户未被授权调用该数据';
        end;
      end;
      if Assigned(FOnExec) then
        FOnExec(errormsg);
      exit;
    end;
  end;

  stream.Position := 0;
  expoFDQuery.Close;
  expoFDQuery.UpdateOptions.UpdateTableName := 'jhlh_pmis_expo';
  expoFDQuery.Open;


  lstream:=TMemoryStream.Create;
  try
    lstream:=CopyStream(stream);
    lstream.Position:=0;

    memtable := TFDMemTable.Create(nil);
    memtable.LoadFromStream(lstream, TFDStorageFormat.sfBinary);
    memtable.First;
    while not memtable.Eof do
    begin
      expoFDQuery.Append;
      for i := 0 to memtable.FieldCount - 1 do
      begin
        fieldname := memtable.FieldDefs.Items[i].Name;
        if fieldname = 'clientvisable' then
          continue;
        if (fieldname = 'startdate') or (fieldname = 'enddate') or (fieldname = 'beforedate') or (fieldname = 'afterdate') then
          expoFDQuery.FieldValues[fieldname] := FormatDateTime('yyyy-mm-dd', UnixDateToDateTime(memtable.FieldByName(fieldname).AsInteger))
        else
          expoFDQuery.FieldValues[fieldname] := memtable.FieldValues[fieldname];
      end;
      memtable.Next;
    end;
    expoFDQuery.Connection.StartTransaction;
    expoFDQuery.Connection.ExecSQL('delete FROM jhlh_pmis_expo');
    ierror := expoFDQuery.ApplyUpdates;
    if ierror > 0 then
    begin
      expoFDQuery.Connection.Rollback;
      FSyncError := true;
      if Assigned(FOnExec) then
        FOnExec('错误:展会信息更新到本地时出现异常');
    end
    else
    begin
      expoFDQuery.Connection.Commit;
      expoFDQuery.CommitUpdates;
      expoFDQuery.Close;
      FSyncError := false;
      if Assigned(FOnExec) then
        FOnExec('展会信息更新完成');
    end;
  finally
    lstream.Free;
    server.Free;
    memtable.Free;
  end;

end;

//获取支付类型数据
procedure TclientsycDataModule.GetPaytypeData;
var
  server: TObject;
  stream: TStream;
  lstream:TMemoryStream;
  memtable: TFDMemTable;
  ierror: Integer;
  errormsg:string;
begin
  server := nil;
  stream := nil;
  lstream:=nil;

  if Assigned(FOnExec) then
    FOnExec('开始更新支付方式');

  if not SQLConnection1.Connected then
  try
    SQLConnection1.Open;
  except
    on E: Exception do
    begin
      FSyncError := true;
      if Assigned(FOnExec) then
        FOnExec('错误:远程连接发生异常,同步中止!' + #13#10 + E.Message);
      exit;
    end;
  end;

  try
    server := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
    stream := TServerMethodsClient(server).PaytypeData('', '');
  except
     on E: Exception do
    begin
      SQLConnection1.Close;
      server.free;
      stream.Free;
      FSyncError := true;
      errormsg:='错误:获取远程数据发生异常,同步中止!';
      if E is TDBXError then
      begin
        if (E as TDBXError).ErrorCode=113 then
        begin
          FSyncError:=false;
          errormsg:='错误:当前用户未被授权调用该数据';
        end;
      end;
      if Assigned(FOnExec) then
        FOnExec(errormsg);
      exit;
    end;
  end;
  stream.Position := 0;

  lstream:=TMemoryStream.Create;
  try
    lstream:=CopyStream(stream);
    lstream.Position:=0;

    memtable := TFDMemTable.Create(nil);
    memtable.LoadFromStream(lstream, TFDStorageFormat.sfBinary);
    memtable.First;
    paytypeFDQuery.Open;
    paytypeFDQuery.UpdateOptions.UpdateTableName := 'jhlh_pmis_paytype';
    paytypeFDQuery.CopyDataSet(memtable);

    paytypeFDQuery.Connection.StartTransaction;
    paytypeFDQuery.Connection.ExecSQL('delete FROM jhlh_pmis_paytype');
    ierror := paytypeFDQuery.ApplyUpdates;
    if ierror > 0 then
    begin
      paytypeFDQuery.Connection.Rollback;
      FSyncError := true;
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
  finally
    lstream.Free;
    server.Free;
    memtable.Free;
  end;

end;

//获取展会类型数据
procedure TclientsycDataModule.GetExpotypeData;
var
  server: TObject;
  stream: TStream;
  lstream:TMemoryStream;
  memtable: TFDMemTable;
  ierror: Integer;
  errormsg:string;
begin
  server := nil;
  stream := nil;
  lstream:=nil;

  if Assigned(FOnExec) then
    FOnExec('开始同步数据');

  if not SQLConnection1.Connected then
  try
    SQLConnection1.Open;
  except
    on E: Exception do
    begin
      FSyncError := true;
      if Assigned(FOnExec) then
        FOnExec('错误:远程连接发生异常,同步中止!' + #13#10 + E.Message);
      exit;
    end;
  end;

  if Assigned(FOnExec) then
    FOnExec('开始更新展会类型');

  try
    server := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
    stream := TServerMethodsClient(server).ExpoTypeData('', '');
  except
    on E: Exception do
    begin
      SQLConnection1.Close;
      server.free;
      stream.Free;
      FSyncError := true;
      errormsg:='错误:获取远程数据发生异常,同步中止!';
      if E is TDBXError then
      begin
        if (E as TDBXError).ErrorCode=113 then
        begin
          FSyncError:=false;
          errormsg:='错误:当前用户未被授权调用该数据';
        end;
      end;
      if Assigned(FOnExec) then
        FOnExec(errormsg);
      exit;
    end;
  end;
  stream.Position := 0;


  lstream:=TMemoryStream.Create;
  try
    lstream:=CopyStream(stream);
    lstream.Position:=0;
    memtable := TFDMemTable.Create(nil);
    memtable.LoadFromStream(lstream, TFDStorageFormat.sfBinary);
    memtable.First;
    expotypeFDQuery.Open;
    expotypeFDQuery.UpdateOptions.UpdateTableName := 'jhlh_pmis_expotype';
    expotypeFDQuery.CopyDataSet(memtable);

    expotypeFDQuery.Connection.StartTransaction;
    expotypeFDQuery.Connection.ExecSQL('delete FROM jhlh_pmis_expotype');
    ierror := expotypeFDQuery.ApplyUpdates;
    if ierror > 0 then
    begin
      expotypeFDQuery.Connection.Rollback;
      FSyncError := true;
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
  finally
    lstream.Free;
    server.Free;
    memtable.Free;
  end;


end;

//获取系统用户数据
procedure TclientsycDataModule.GetMemberData;
var
  server: TServerMethodsClient;
  stream: TStream;
  lstream:TMemoryStream;
  memtable: TFDMemTable;
  ierror: Integer;
  errormsg:string;
begin
  server := nil;
  stream := nil;
  lstream:=nil;

  if Assigned(FOnExec) then
    FOnExec('开始更新系统用户');

  if not SQLConnection1.Connected then
  try
    SQLConnection1.Open;
  except
    on E: Exception do
    begin
      FSyncError := true;
      if Assigned(FOnExec) then
        FOnExec('错误:远程连接发生异常,同步中止!' + #13#10 + E.Message)
      else
       raise Exception.Create(E.Message);
      exit;
    end;
  end;

  try
    server := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
    server.ClearResources;
    stream := server.MemberData;
  except
    on E: Exception do
    begin
      SQLConnection1.Close;
      server.free;
      stream.Free;
      FSyncError := true;
      errormsg:='错误:获取远程数据发生异常,同步中止!';
      if E is TDBXError then
      begin
        if (E as TDBXError).ErrorCode=113 then
        begin
          FSyncError:=false;
          errormsg:='错误:当前用户未被授权调用该数据';
        end;
      end;
      if Assigned(FOnExec) then
        FOnExec(errormsg)
      else
      begin
        FSyncError:=true;
      end;
      exit;
    end;
  end;
  stream.Position := 0;

  lstream:=TMemoryStream.Create;
  try
    lstream:=CopyStream(stream);
    lstream.Position:=0;

    memtable := TFDMemTable.Create(nil);
    memtable.LoadFromStream(lstream, TFDStorageFormat.sfBinary);
    memtable.First;
    memberFDQuery.Open;
    memberFDQuery.UpdateOptions.UpdateTableName := 'jhlh_admin_member';
    memberFDQuery.CopyDataSet(memtable);

    memberFDQuery.Connection.StartTransaction;
    memberFDQuery.Connection.ExecSQL('delete FROM jhlh_admin_member');
    ierror := memberFDQuery.ApplyUpdates;
    if ierror > 0 then
    begin
      memberFDQuery.Connection.Rollback;
      FSyncError := true;
      if Assigned(FOnExec) then
        FOnExec('错误:系统用户更新到本地时出现异常');
    end
    else
    begin
      memberFDQuery.Connection.Commit;
      memberFDQuery.Close;
      if Assigned(FOnExec) then
        FOnExec('系统用户更新完成');
    end;
  finally
    lstream.Free;
    server.Free;
    memtable.Free;
  end;
end;

//获取顾客来源数据
procedure TclientsycDataModule.GetShoppersourceData;
var
  server: TObject;
  stream: TStream;
  lstream:TMemoryStream;
  memtable: TFDMemTable;
  ierror: Integer;
  errormsg:string;
begin
  server := nil;
  stream := nil;

  if Assigned(FOnExec) then
    FOnExec('开始更新顾客来源');

  if not SQLConnection1.Connected then
  try
    SQLConnection1.Open;
  except
    on E: Exception do
    begin
      FSyncError := true;
      if Assigned(FOnExec) then
        FOnExec('错误:远程连接发生异常,同步中止!' + #13#10 + E.Message);
      exit;
    end;
  end;

  try
    server := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
    stream := TServerMethodsClient(server).ShopperSourceData('', '');
  except
    on E: Exception do
    begin
      SQLConnection1.Close;
      server.free;
      stream.Free;
      FSyncError := true;
      errormsg:='错误:获取远程数据发生异常,同步中止!';
      if E is TDBXError then
      begin
        if (E as TDBXError).ErrorCode=113 then
        begin
          FSyncError:=false;
          errormsg:='错误:当前用户未被授权调用该数据';
        end;
      end;
      if Assigned(FOnExec) then
        FOnExec(errormsg);
      exit;
    end;
  end;

  stream.Position := 0;

  lstream:=TMemoryStream.Create;
  try
    lstream:=CopyStream(stream);
    lstream.Position:=0;

    memtable := TFDMemTable.Create(nil);
    memtable.LoadFromStream(lstream, TFDStorageFormat.sfBinary);
    memtable.First;
    shoppersourceFDQuery.Open;
    shoppersourceFDQuery.UpdateOptions.UpdateTableName := 'jhlh_pmis_shopper_sourcetype';
    shoppersourceFDQuery.CopyDataSet(memtable);

    shoppersourceFDQuery.Connection.StartTransaction;
    shoppersourceFDQuery.Connection.ExecSQL('delete FROM jhlh_pmis_shopper_sourcetype');
    ierror := shoppersourceFDQuery.ApplyUpdates;
    if ierror > 0 then
    begin
      shoppersourceFDQuery.Connection.Rollback;
      FSyncError := true;
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
  finally
    lstream.Free;
    server.Free;
    memtable.Free;
  end;

end;

procedure TclientsycDataModule.openexpodata;
begin
  GetExpoData;
end;

procedure TclientsycDataModule.RemoveCustomerData;
begin
  if Assigned(FOnExec) then
    FOnExec('开始清理本地客户数据');
  removecustomerFDCommand.Execute();
  removecustomerFDCommand.NextRecordSet;
  removecustomerFDCommand.Execute();
  removecustomerFDCommand.NextRecordSet;
  removecustomerFDCommand.Execute();
  if Assigned(FOnExec) then
    FOnExec('本地客户数据清理完成');
end;

procedure TclientsycDataModule.SQLConnection1BeforeConnect(Sender: TObject);
begin
  SQLConnection1.Params.Add('version=1');
  SQLConnection1.Params.Values['HostName']:= TSetting.GetValue('Net','server',setting.Server);
  SQLConnection1.Params.Values['Port']:= TSetting.GetValue('Net','port',setting.ServerPort);
end;

function TclientsycDataModule.test: string;
var
  server: Tobject;
  s: string;
begin
  s := 'abc';
  server := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
  s := TServerMethodsClient(server).ReverseString('abcdef');
  TServerMethodsClient(server).Destroy;
  Result := s;
end;

end.

