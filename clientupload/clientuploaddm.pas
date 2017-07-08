unit clientuploaddm;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, Data.DBXCommon,
  IPPeerClient, Data.DB, Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,VCL.Dialogs, FireDAC.Stan.StorageBin;

type
  TclientuploadDataModule = class(TDataModule)
    SQLConnection1: TSQLConnection;
    customerFDQuery: TFDQuery;
    shopperFDQuery: TFDQuery;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FOnExec:TGetStrProc; //事件:用来输出相关执行信息到主界面
  public
    { Public declarations }
    property OnExec:TGetStrProc read FOnExec write FOnExec; //事件属性
    procedure CustomerDataUpload;
    procedure ShopperDataUpload;
  end;

var
  clientuploadDataModule: TclientuploadDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses servermethodsupload,connectiondm;

{$R *.dfm}

procedure TclientuploadDataModule.CustomerDataUpload;
var
  server:tobject;
  stream:TMemoryStream;
  memtable:TFDMemTable;

  I: integer;
  LResponseMessage: string;
begin

  if customerFDQuery <> nil then
  begin
    customerFDQuery.Open;
    if customerFDQuery.State in dsEditModes then
      customerFDQuery.Post;
  end;

  if customerFDQuery.RecordCount=0 then exit;


  if Assigned(FOnExec) then
       FOnExec('开始上传客户数据');

  memtable:=TFDMemTable.Create(self);
  memtable.CachedUpdates:=true;
  memtable.UpdateOptions.AutoIncFields:='id';
  memtable.UpdateOptions.AutoCommitUpdates:=true;
  memtable.UpdateOptions.CheckRequired:=false;

  memtable.CopyDataSet(customerFDQuery,[coStructure, coRestart, coAppend]);
  memtable.FieldByName('id').ProviderFlags:= memtable.FieldByName('id').ProviderFlags-[pfInupdate];
  //exit;
  stream := TMemoryStream.Create;

  SQLConnection1.Open;
  server:=TServerMethodsClient.Create(SQLConnection1.DBXConnection);
  try
    memtable.ResourceOptions.StoreItems := [siDelta, siMeta];
    memtable.SaveToStream(stream, TFDStorageFormat.sfBinary);
    stream.Position := 0;
    try
      LResponseMessage := TServerMethodsClient(Server).CustomerDataPost(stream);
    except
      On E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    if LResponseMessage <> '' then
      raise Exception.Create(LResponseMessage);
    Server.Free;
    memtable.Free;
    customerFDQuery.Close;
    SQLConnection1.Close;
  end;
  if Assigned(FOnExec) then
      FOnExec('客户数据上传成功');
end;

procedure TclientuploadDataModule.ShopperDataUpload;
var
  server:tobject;
  stream:TMemoryStream;
  memtable:TFDMemTable;

  I: integer;
  LResponseMessage: string;
begin
  if shopperFDQuery <> nil then
  begin
    shopperFDQuery.Open;
    if shopperFDQuery.State in dsEditModes then
      shopperFDQuery.Post;
  end;

  if shopperFDQuery.RecordCount=0 then exit;

   if Assigned(FOnExec) then
       FOnExec('开始上传顾客数据');

  memtable:=TFDMemTable.Create(self);
  memtable.CachedUpdates:=true;
  memtable.UpdateOptions.AutoIncFields:='id';
  memtable.UpdateOptions.AutoCommitUpdates:=true;
  memtable.UpdateOptions.CheckRequired:=false;

  memtable.CopyDataSet(shopperFDQuery,[coStructure, coRestart, coAppend]);
  memtable.FieldByName('id').ProviderFlags:= memtable.FieldByName('id').ProviderFlags-[pfInupdate];
  //exit;
  stream := TMemoryStream.Create;

  SQLConnection1.Open;
  server:=TServerMethodsClient.Create(SQLConnection1.DBXConnection);
  try
    memtable.ResourceOptions.StoreItems := [siDelta, siMeta];
    memtable.SaveToStream(stream, TFDStorageFormat.sfBinary);
    stream.Position := 0;
    try
      LResponseMessage := TServerMethodsClient(Server).ShopperDataPost(stream);
    except
      On E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    Server.Free;
    memtable.Free;
    shopperFDQuery.Close;
    SQLConnection1.Close;
    if LResponseMessage <> '' then
      raise Exception.Create(LResponseMessage);
  end;
  if Assigned(FOnExec) then
       FOnExec('顾客数据上传成功');

end;

procedure TclientuploadDataModule.DataModuleCreate(Sender: TObject);
begin
  customerFDQuery.Connection:=connectionDataModule.mainFDConnection;
  shopperFDQuery.Connection:=connectionDataModule.mainFDConnection;
end;



end.
