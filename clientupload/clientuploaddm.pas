unit clientuploaddm;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, Data.DBXCommon,
  IPPeerClient, Data.DB, Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, VCL.Dialogs, FireDAC.Stan.StorageBin,setting;

type
  TclientuploadDataModule = class(TDataModule)
    SQLConnection1: TSQLConnection;
    customerFDQuery: TFDQuery;
    shopperFDQuery: TFDQuery;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDTransaction1: TFDTransaction;
    setshopperautoincFDCommand: TFDCommand;
    procedure DataModuleCreate(Sender: TObject);
    procedure SQLConnection1BeforeConnect(Sender: TObject);
    private
      { Private declarations }
      FOnExec: TGetStrProc; // 事件:用来输出相关执行信息到主界面
    public
      { Public declarations }
      ServerError:boolean;
      ServerErrorMsg:string;
      property OnExec: TGetStrProc read FOnExec write FOnExec; // 事件属性
      procedure CustomerDataUpload;
      procedure ShopperDataUpload;
      function test: boolean;
  end;

var
  clientuploadDataModule: TclientuploadDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses servermethodsupload, connectiondm;

{$R *.dfm}

procedure TclientuploadDataModule.CustomerDataUpload;
var
  server: TObject;
  stream: TMemoryStream;
  memtable: TFDMemTable;

  I: integer;
  LResponseMessage: string;
  ids: string;
begin

  SQLConnection1.Open;
  server := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
  ids := TServerMethodsClient(server).UseExpoIds;
  if customerFDQuery <> nil then
  begin
    if ids <> '' then
    begin
      customerFDQuery.Macros.Items[0].AsRaw:=' and eid in ('+ids+')';
    end;

    customerFDQuery.Open;
    if customerFDQuery.State in dsEditModes then
      customerFDQuery.Post;
  end
  else  exit;
  if customerFDQuery.RecordCount = 0 then
  begin
    if Assigned(FOnExec) then
      FOnExec('目前没有客户数据');
    exit;
  end;

  if Assigned(FOnExec) then
    FOnExec('开始上传客户数据');

  memtable := TFDMemTable.Create(self);
  memtable.CachedUpdates := true;
  memtable.UpdateOptions.AutoIncFields := 'id';
  memtable.UpdateOptions.AutoCommitUpdates := true;
  memtable.UpdateOptions.CheckRequired := false;

  memtable.CopyDataSet(customerFDQuery, [coStructure, coRestart, coAppend]);
  memtable.FieldByName('id').ProviderFlags := memtable.FieldByName('id').ProviderFlags -
    [pfInupdate];
  // exit;
  stream := TMemoryStream.Create;
  memtable.ResourceOptions.StoreItems := [siDelta, siMeta];
  memtable.SaveToStream(stream, TFDStorageFormat.sfBinary);
  stream.Position := 0;

  try
    // FDTransaction1.StartTransaction; //本地事务开启
    try
      // customerFDQuery.ServerDeleteAll;
      LResponseMessage := TServerMethodsClient(server).CustomerDataPost(stream);
      if LResponseMessage = '' then
      begin
        // FDTransaction1.Commit;  //本地事务提交,删除本地数据
        // if Assigned(FOnExec) then
        // FOnExec('本地客户数据已经删除');
      end
    except
      On E: Exception do
      begin
        // FDTransaction1.Rollback;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    server.Free;
    memtable.Free;
    customerFDQuery.Close;
    SQLConnection1.Close;
    if LResponseMessage <> '' then
      raise Exception.Create(LResponseMessage);
  end;
  if Assigned(FOnExec) then
    FOnExec('客户数据上传成功');
end;

procedure TclientuploadDataModule.ShopperDataUpload;
var
  server: TObject;
  stream: TMemoryStream;
  memtable: TFDMemTable;
  I: integer;
  LResponseMessage: string;
begin
  // 打开数据集,并处于浏览模式下
  if shopperFDQuery <> nil then
  begin
    shopperFDQuery.Open;
    if shopperFDQuery.State in dsEditModes then
      shopperFDQuery.Post;
  end
  else exit;

  // 记录数为0就退出
  if shopperFDQuery.RecordCount = 0 then
  begin
    if Assigned(FOnExec) then
      FOnExec('目前没有顾客数据');
    exit;
  end;

  if Assigned(FOnExec) then
    FOnExec('开始上传顾客数据');

  // 建立内存表
  memtable := TFDMemTable.Create(self);
  memtable.CachedUpdates := true;
  memtable.UpdateOptions.AutoIncFields := 'id';
  memtable.UpdateOptions.AutoCommitUpdates := true;
  memtable.UpdateOptions.CheckRequired := false;

  // 将记录复制到内存表,并设置字段ID为不更新字段
  memtable.CopyDataSet(shopperFDQuery, [coStructure, coRestart, coAppend]);
  memtable.FieldByName('id').ProviderFlags := memtable.FieldByName('id').ProviderFlags -[pfInupdate];

  // 建立内存流,并将内存表保存到流
  stream := TMemoryStream.Create;
  memtable.ResourceOptions.StoreItems := [siDelta, siMeta];
  memtable.SaveToStream(stream, TFDStorageFormat.sfBinary);
  stream.Position := 0;

  try
    try
      SQLConnection1.Open;
      server := TServerMethodsClient.Create(SQLConnection1.DBXConnection);
      FDTransaction1.StartTransaction; // 本地事务开启,用于删除本地已经提交完成的记录
      shopperFDQuery.ServerDeleteAll;    //删除本地表中数据
      setshopperautoincFDCommand.Execute; //重置自增字段
      LResponseMessage := TServerMethodsClient(server).ShopperDataPost(stream); // 上传本地数据到服务器

      if LResponseMessage = '' then //判断服务器是否返回出错信息
      begin
        FDTransaction1.Commit; // 本地事务提交,删除本地数据
        if Assigned(FOnExec) then
          FOnExec('本地顾客数据已经删除');
      end
      else
        FDTransaction1.Rollback;    //服务器如果发生异常,本地事务回滚
    except
      On E: Exception do
      begin
        FDTransaction1.Rollback;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    server.Free;
    memtable.Free;
    shopperFDQuery.Close;
    SQLConnection1.Close;
    if LResponseMessage <> '' then
      raise Exception.Create(LResponseMessage);
  end;
  if Assigned(FOnExec) then
    FOnExec('顾客数据上传成功');
end;

procedure TclientuploadDataModule.SQLConnection1BeforeConnect(Sender: TObject);
begin
  SQLConnection1.Params.Add('version=1');
  SQLConnection1.Params.Values['HostName']:= TSetting.GetValue('Net','server',setting.Server);
  SQLConnection1.Params.Values['Port']:= TSetting.GetValue('Net','port',setting.ServerPort);
end;

function TclientuploadDataModule.test: boolean;
begin

end;

procedure TclientuploadDataModule.DataModuleCreate(Sender: TObject);
begin
  ServerError:=false;

  SQLConnection1.Params.Values['DSAuthenticationPassword']:=clientuser.Password;
  SQLConnection1.Params.Values['DSAuthenticationUser']:=clientuser.Username;
  try
    try
      SQLConnection1.Open;
    except
      on E:Exception do
      begin
        ServerError:=true;
        ServerErrorMsg:=E.Message;
        exit;
      end;
    end;
  finally
    SQLConnection1.Close;
  end;

  customerFDQuery.Connection := connectionDataModule.mainFDConnection;
  shopperFDQuery.Connection := connectionDataModule.mainFDConnection;
  setshopperautoincFDCommand.Connection:=connectionDataModule.mainFDConnection;
  FDTransaction1.Connection := connectionDataModule.mainFDConnection;
end;

end.
