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
    DataSource1: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    function test:string;
    procedure openexpodata;
    procedure GetExpoData;
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
 SQLConnection1.Open;
 expoFDQuery.Connection:=connectionDataModule.mainFDConnection;
end;

procedure TclientsycDataModule.DataModuleDestroy(Sender: TObject);
begin
 SQLConnection1.Close;
end;

procedure TclientsycDataModule.GetExpoData;
var
 server:tobject;
 stream:Tstream;
 memtable:TFDMemTable;
  i,ierror: Integer;
  fieldname:string;
begin
  if not SQLConnection1.Connected then exit;

  memtable:=TFDMemTable.Create(nil);
  server:=TServerMethodsClient.Create(SQLConnection1.DBXConnection);
  stream:=TServerMethodsClient(Server).ExpoData('','');
  stream.Position:=0;
  expoFDQuery.Close;
  expoFDQuery.UpdateOptions.UpdateTableName:='jhlh_pmis_expo';
  expoFDQuery.Open;


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

  //expoFDQuery.CopyDataSet(memtable);

  expoFDQuery.Connection.ExecSQL('delete FROM jhlh_pmis_expo');
  expoFDQuery.Connection.StartTransaction;
  ierror := expoFDQuery.ApplyUpdates;
   expoFDQuery.Connection.Commit;
  //ShowMessage(ierror.ToString);
  expoFDQuery.CommitUpdates;
  expoFDQuery.Close;
  //expoFDQuery.Refresh;
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
