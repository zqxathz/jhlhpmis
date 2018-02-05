unit ServerAdminUnit;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Json,
  Datasnap.DSServer,
  Datasnap.DSAuth,
  DataSnap.DSProviderDataModuleAdapter, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Stan.Param, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.ConsoleUI.Wait, FireDAC.Stan.StorageBin;

type
  TServerAdminMethods = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDSchemaAdapter1: TFDSchemaAdapter;
    memberFDQuery: TFDQuery;
    groupFDQuery: TFDQuery;
    methodFDQuery: TFDQuery;
    customerstypeFDQuery: TFDQuery;
    expotypeFDQuery: TFDQuery;
    expoFDQuery: TFDQuery;
    shoppersourceFDQuery: TFDQuery;
    paytypeFDQuery: TFDQuery;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    methodDataSource: TDataSource;
    expoFDQuerycalstartdate: TDateField;
    expoFDQuerycalenddate: TDateField;
    expoFDQuerycalbeforedate: TDateField;
    expoFDQuerycalafterdate: TDateField;
    procedure expoFDQueryAfterGetRecord(DataSet: TFDDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function GetData:TStream;
    function PostData(stream:TStream):string;
  end;


implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}
//时间戳转日期类型
function UnixDateToDateTime(const USec: Longint): TDateTime;
const
 cUnixStartDate: TDateTime = 25569.0; // 1970/01/01
begin
 Result := (USec / 86400) + cUnixStartDate;
end;

 // 复制流到内存流
function CopyStream(const AStream: TStream): TMemoryStream;
var
 LBuffer: TBytes;
 LCount: integer;
begin
 result := TMemoryStream.Create;
 try
   SetLength(LBuffer, 1024 * 32);
   while True do
   begin
     LCount := AStream.Read(LBuffer, Length(LBuffer));
     result.Write(LBuffer, LCount);
     if LCount < Length(LBuffer) then
       break;
   end;
 except
   result.Free;
   writeln('copystream error');
   raise;
 end;
end;

{ TServerAdminMethods }

function TServerAdminMethods.EchoString(Value: string): string;
begin
  Result:=Value;
end;

procedure TServerAdminMethods.expoFDQueryAfterGetRecord(DataSet: TFDDataSet);
begin
  DataSet.FieldByName('calstartdate').AsDateTime:=UnixDateToDateTime(DataSet.FieldByName('startdate').AsInteger);
  DataSet.FieldByName('calenddate').AsDateTime:=UnixDateToDateTime(DataSet.FieldByName('enddate').AsInteger);
  DataSet.FieldByName('calbeforedate').AsDateTime:=UnixDateToDateTime(DataSet.FieldByName('beforedate').AsInteger);
  DataSet.FieldByName('calafterdate').AsDateTime:=UnixDateToDateTime(DataSet.FieldByName('afterdate').AsInteger);
end;

function TServerAdminMethods.GetData: TStream;
begin
   Result:=TMemoryStream.Create;
   try
     try
       methodFDQuery.Open;
       groupFDQuery.Open;
       memberFDQuery.Open;
       expotypeFDQuery.Open;
       expoFDQuery.Open;
       customerstypeFDQuery.Open;
       shoppersourceFDQuery.Open;
       paytypeFDQuery.Open;
       FDSchemaAdapter1.SaveToStream(Result,TFDStorageFormat.sfBinary);
       Result.Position:=0;
     except
       Result.Free;
       raise;
     end;
   finally
     methodFDQuery.Close;
     groupFDQuery.Close;
     memberFDQuery.Close;
     expotypeFDQuery.Close;
     expoFDQuery.Close;
     customerstypeFDQuery.Close;
     shoppersourceFDQuery.Close;
     paytypeFDQuery.Close;
     FDSchemaAdapter1.Close;
     FDConnection1.Close;
   end;
end;

function TServerAdminMethods.PostData(stream: TStream): string;
var
  lstream:TMemoryStream;
begin
  Result:='';
  lstream:=CopyStream(stream);
  lstream.Position:=0;
  try
    FDSchemaAdapter1.LoadFromStream(lstream,TFDStorageFormat.sfBinary);
    FDSchemaAdapter1.ApplyUpdates;
  finally
    lstream.Free;
  end;

end;

end.

