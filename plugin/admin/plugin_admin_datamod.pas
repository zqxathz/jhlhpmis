unit plugin_admin_datamod;

interface

uses
  System.SysUtils,
  System.Classes,
  setting,
  Data.DBXDataSnap,
  Data.DBXCommon,
  IPPeerClient,
  Data.DB,
  Data.SqlExpr,
  connectiondm,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.Stan.Async,
  FireDAC.Stan.StorageBin,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  VCL.Dialogs,
  Data.DBXTrace,
  System.DateUtils;

type
  Tpluginadmindm = class(TDataModule)
    SQLConnection1: TSQLConnection;
    FDSchemaAdapter1: TFDSchemaAdapter;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    methodFDMemTable: TFDMemTable;
    groupFDMemTable: TFDMemTable;
    memberFDMemTable: TFDMemTable;
    customertypeFDMemTable: TFDMemTable;
    expotypeFDMemTable: TFDMemTable;
    expoFDMemTable: TFDMemTable;
    paytypeFDMemTable: TFDMemTable;
    shoppersourceFDMemTable: TFDMemTable;
    methodFDTableAdapter: TFDTableAdapter;
    groupFDTableAdapter: TFDTableAdapter;
    memberFDTableAdapter: TFDTableAdapter;
    expoFDTableAdapter: TFDTableAdapter;
    customertypeFDTableAdapter: TFDTableAdapter;
    expotypeFDTableAdapter: TFDTableAdapter;
    shoppersourceFDTableAdapter: TFDTableAdapter;
    paytypeFDTableAdapter: TFDTableAdapter;
    methodFDMemTablemethodclass: TStringField;
    procedure SQLConnection1BeforeConnect(Sender: TObject);
    procedure methodFDMemTableCalcFields(DataSet: TDataSet);
    procedure expoFDMemTableBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SelectMethodwithClass(select:boolean);
    function test: string;
    procedure GetData;
    procedure PostData;
  end;

var
  pluginadmindm: Tpluginadmindm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  plugin_admin_servermethods;

{$R *.dfm}

//时间戳转日期类型
function UnixDateToDateTime(const USec: Longint): TDateTime;
const
 cUnixStartDate: TDateTime = 25569.0; // 1970/01/01
begin
 Result := (USec / 86400) + cUnixStartDate;
end;

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

procedure Tpluginadmindm.expoFDMemTableBeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('startdate').AsInteger:= DateTimeToUnix(IncHour(DataSet.FieldByName('calstartdate').AsDateTime,0));
  DataSet.FieldByName('enddate').AsInteger:= DateTimeToUnix(IncHour(DataSet.FieldByName('calenddate').AsDateTime,0));
  DataSet.FieldByName('beforedate').AsInteger:= DateTimeToUnix(IncHour(DataSet.FieldByName('calbeforedate').AsDateTime,0));
  DataSet.FieldByName('afterdate').AsInteger:= DateTimeToUnix(IncHour(DataSet.FieldByName('calbeforedate').AsDateTime,0));
end;

procedure Tpluginadmindm.GetData;
var
  server: TServerAdminMethodsClient;
  lstream: TMemoryStream;
begin
  SQLConnection1.Open;
  server := TServerAdminMethodsClient.Create(SQLConnection1.DBXConnection);
  lstream:=nil;
  try
    lstream := CopyStream(server.GetData);
    if lstream <> nil then
    begin
      //showmessage(lstream.Size.ToString);
      lstream.Position := 0;
      FDSchemaAdapter1.LoadFromStream(lstream, TFDStorageFormat.sfBinary);
    end;

  finally
    if Assigned(lstream) then lstream.Free;
    server.Free;
    SQLConnection1.Close;
  end;
end;

procedure Tpluginadmindm.methodFDMemTableCalcFields(DataSet: TDataSet);
begin
  Dataset.FieldByName('methodclass').Value:=copy(DataSet.FieldByName('methodalias').AsString,1,
  DataSet.FieldByName('methodalias').AsString.IndexOf('.'));
end;

procedure Tpluginadmindm.PostData;
var
  lstream: TMemoryStream;
  server: TServerAdminMethodsClient;
  i:integer;
  LDataSet:TDataset;
begin
  for I := 0 to FDSchemaAdapter1.Count - 1 do
  begin
    LDataSet := FDSchemaAdapter1.DataSets[I];
    if LDataSet <> nil then
      if LDataSet.State in dsEditModes then
        LDataSet.Post;
  end;
  lstream := TMemoryStream.Create;
  try
    SQLConnection1.Open;
    server := TServerAdminMethodsClient.Create(SQLConnection1.DBXConnection);
    FDSchemaAdapter1.SaveToStream(lstream, TFDStorageFormat.sfBinary);
    lstream.Position := 0;
    server.PostData(lstream);
  finally
    //lstream.Free;
    server.Free;
    SQLConnection1.Close;
  end;

end;

procedure Tpluginadmindm.SelectMethodwithClass(select: boolean);
var
  str:string;
  p:integer;
  status:integer;
  Bookmark: TBookmark;
begin
  if select then
    status:=1
  else
    status:=0;
  methodFDMemTable.DisableControls;
  Bookmark:= methodFDMemTable.GetBookmark;
  str:=methodFDMemTable.FieldByName('methodclass').AsString;
  //p:=methodFDMemTable.SavePoint;
  try
    methodFDMemTable.First;
    //showmessage(methodFDMemTable.FieldByName('status').Value);
    while not methodFDMemTable.Eof do
    begin
      if methodFDMemTable.FieldByName('methodclass').AsString=str then
      begin
        methodFDMemTable.Edit;
        methodFDMemTable.FieldByName('status').Value:=status;
        methodFDMemTable.Post;
      end;
      methodFDMemTable.Next;
    end;
  finally
    methodFDMemTable.GotoBookmark(Bookmark);
    methodFDMemTable.EnableControls;
  end;
end;

procedure Tpluginadmindm.SQLConnection1BeforeConnect(Sender: TObject);
begin
  SQLConnection1.Params.Add('version=1');
  SQLConnection1.Params.Values['HostName'] := TSetting.GetValue('Net', 'server', setting.Server);
  SQLConnection1.Params.Values['Port'] := TSetting.GetValue('Net', 'port', setting.ServerPort);
  SQLConnection1.Params.Values['DSAuthenticationPassword'] := clientuser.Password;
  SQLConnection1.Params.Values['DSAuthenticationUser'] := clientuser.Username;
end;

function Tpluginadmindm.test: string;
var
  server: TServerAdminMethodsClient;
begin
  SQLConnection1.Open;
  server := TServerAdminMethodsClient.Create(SQLConnection1.DBXConnection);
  Result := server.EchoString('abc');
  server.Free;
  SQLConnection1.CloseDataSets;
  SQLConnection1.Close;
end;

end.

