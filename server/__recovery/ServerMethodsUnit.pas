unit ServerMethodsUnit;

interface

uses System.SysUtils, System.Classes, System.Json,
  DataSnap.DSProviderDataModuleAdapter,
  DataSnap.DSServer, DataSnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet,System.Generics.Collections,System.Variants;

type
  TErrorRecordIDs = array of integer;

  TServerMethods = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    expoFDQuery: TFDQuery;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    customertypeFDQuery: TFDQuery;
    paytypeFDQuery: TFDQuery;
    expotypeFDQuery: TFDQuery;
    shoppersourceFDQuery: TFDQuery;
    customerFDQuery: TFDQuery;
    shopperFDQuery: TFDQuery;
    procedure customerFDQueryUpdateError(ASender: TDataSet; AException: EFDException;
      ARow: TFDDatSRow; ARequest: TFDUpdateRequest; var AAction: TFDErrorAction);
    private
      { Private declarations }
      FUpdateErrorRecords:TErrorRecordIDs;
      FErrorsList: TJSONObject;
      function GenerateErrorMessage: string;
    public
      { Public declarations }
      function EchoString(Value: string): string;
      function ReverseString(Value: string): string;
      function ExpoData(username: string; password: string): TStream;
      function CustomertypeData(username: string; password: string): TStream;
      function PaytypeData(username: string; password: string): TStream;
      function ExpoTypeData(username: string; password: string): TStream;
      function ShopperSourceData(username: string; password: string): TStream;
      function CustomerDataPost(AStream: TStream):string;
      function ShopperDataPost(AStream:TStream):string;
    end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

uses System.StrUtils,System.DateUtils;

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
    writeln('copystream error');
    raise;
  end;
end;

function TServerMethods.ShopperDataPost(AStream: TStream): string;
var
  LMemStream: TMemoryStream;
  LErrors: Integer;
  count:int64;
  starttime,endtime:TDateTime;
begin
  if AStream.Size= 0  then exit;

  FErrorsList := TJSONObject.Create;
  LMemStream:=CopyStream(AStream);
  LMemStream.Position:=0;
  try
    shopperFDQuery.Close;
    shopperFDQuery.LoadFromStream(LMemStream,TFDStorageFormat.sfBinary);
    Writeln('start');
    starttime:=now();
    FDConnection1.StartTransaction;

    LErrors:=shopperFDQuery.ApplyUpdates;
    FDConnection1.Commit;
    {
    if LErrors<>0 then
      FDConnection1.Rollback
    else
      FDConnection1.Commit;
     }
    endtime:=now();
    count:=MilliSecondsBetween(endtime,starttime);
    Writeln(inttostr(count));
  finally
    customerFDQuery.Close;
    LMemStream.Free;
    FDConnection1.Close;
    Writeln('ok');
    if LErrors>0 then
    begin
      //Result := Format(sErrorsOnApplyUpdates, [GenerateErrorMessage]);
      //Writeln(Result);
      Result:=FErrorsList.ToJSON;
    end;
    FErrorsList.Free;
  end;

end;

function TServerMethods.CustomerDataPost(AStream: TStream):string;
var
  LMemStream: TMemoryStream;
  LErrors: Integer;
  count:int64;
  starttime,endtime:TDateTime;
begin
  Result:='';
  if AStream.Size= 0  then exit;

  FErrorsList := TJSONObject.Create;
  LMemStream:=CopyStream(AStream);

  writeln('stream size:'+LMemStream.Size.ToString);
  LMemStream.Position:=0;
  try
    customerFDQuery.close;
    customerFDQuery.LoadFromStream(LMemStream,TFDStorageFormat.sfBinary);
    writeln('record count:'+customerFDQuery.RecordCount.ToString);
    Writeln('start');
    starttime:=now();
    FDConnection1.StartTransaction;

    LErrors:=customerFDQuery.ApplyUpdates;
    FDConnection1.Commit;
    writeln('error'+LErrors.ToString);
    {
    if LErrors<>0 then
      FDConnection1.Rollback
    else
      FDConnection1.Commit;
     }
    endtime:=now();
    count:=MilliSecondsBetween(endtime,starttime);
    Writeln(inttostr(count));
  finally
    customerFDQuery.Close;
    LMemStream.Free;
    FDConnection1.Close;

    if LErrors>0 then
    begin
      //Result := Format(sErrorsOnApplyUpdates, [GenerateErrorMessage]);
      //Writeln(Result);
      Result:=FErrorsList.ToJSON;
    end;
    Writeln('ok'+Result);
    FErrorsList.Free;
  end;
end;

procedure TServerMethods.customerFDQueryUpdateError(ASender: TDataSet; AException: EFDException;
  ARow: TFDDatSRow; ARequest: TFDUpdateRequest; var AAction: TFDErrorAction);
var
  LDataStr: string;
begin
  try
    try

      if not VarIsNull(ARow.GetData('id')) then LDataStr := ARow.GetData('id');

      FErrorsList.AddPair('Errorid:'+AException.Message, LDataStr);
    except

    end;
  finally

  end;
end;

function TServerMethods.GenerateErrorMessage: string;
var
  I: Integer;
  LJSONObject: TJSONObject;
  LJSONArray: TJSONArray;
begin
  //
end;

function TServerMethods.CustomertypeData(username, password: string): TStream;
begin
  Result := TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      customertypeFDQuery.Close;
      customertypeFDQuery.Open;
      customertypeFDQuery.SaveToStream(Result, TFDStorageFormat.sfBinary);
      Result.Position := 0;
    except
      on E: Exception do
      begin
        Writeln(E.Message);
        Result.Free;
      end;
    end;
  finally
    customertypeFDQuery.Close;
    FDConnection1.Close;
  end;
end;

function TServerMethods.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods.ExpoData(username, password: string): TStream;
begin
  Result := TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      expoFDQuery.Close;
      expoFDQuery.Open;
      expoFDQuery.SaveToStream(Result, TFDStorageFormat.sfBinary);
      Result.Position := 0;
    except
      on E: Exception do
      begin
        Writeln(E.Message);
        Result.Free;
      end;
    end;
  finally
    expoFDQuery.Close;
    FDConnection1.Close;
  end;

end;

function TServerMethods.ExpoTypeData(username, password: string): TStream;
begin
  Result := TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      expotypeFDQuery.Close;
      expotypeFDQuery.Open;
      expotypeFDQuery.SaveToStream(Result, TFDStorageFormat.sfBinary);
      Result.Position := 0;
    except
      on E: Exception do
      begin
        Writeln(E.Message);
        Result.Free;
      end;
    end;
  finally
    expotypeFDQuery.Close;
    FDConnection1.Close;
  end;
end;

function TServerMethods.PaytypeData(username, password: string): TStream;
begin
  Result := TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      paytypeFDQuery.Close;
      paytypeFDQuery.Open;
      paytypeFDQuery.SaveToStream(Result, TFDStorageFormat.sfBinary);
      Result.Position := 0;
    except
      on E: Exception do
      begin
        Writeln(E.Message);
        Result.Free;
      end;
    end;
  finally
    paytypeFDQuery.Close;
    FDConnection1.Close;
  end;
end;



function TServerMethods.ShopperSourceData(username, password: string): TStream;
begin
  Result := TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      shoppersourceFDQuery.Close;
      shoppersourceFDQuery.Open;
      shoppersourceFDQuery.SaveToStream(Result, TFDStorageFormat.sfBinary);
      Result.Position := 0;
    except
      on E: Exception do
      begin
        Writeln(E.Message);
        Result.Free;
      end;
    end;
  finally
    shoppersourceFDQuery.Close;
    FDConnection1.Close;
  end;

end;

function TServerMethods.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.
