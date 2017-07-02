unit ServerMethodsUnit;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet;

type
  TServerMethods = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    expoFDQuery: TFDQuery;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    customertypeFDQuery: TFDQuery;
    paytypeFDQuery: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function ExpoData(username:string;password:string):TStream;
    function CustomertypeData(username:string;password:string):TStream;
    function PaytypeData(username:string;password:string):TStream;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}


{$R *.dfm}


uses System.StrUtils;

function TServerMethods.CustomertypeData(username, password: string): TStream;
begin
  Result:=TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      customertypeFDQuery.Close;
      customertypeFDQuery.Open;
      customertypeFDQuery.SaveToStream(Result,TFDStorageFormat.sfBinary);
      Result.Position:=0;
    except
      on E: Exception do
      begin
        Writeln(E.Message);
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
  Result:=TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      expoFDQuery.Close;
      expoFDQuery.Open;
      expoFDQuery.SaveToStream(Result,TFDStorageFormat.sfBinary);
      Result.Position:=0;
    except
      on E: Exception do
      begin
        Writeln(E.Message);
      end;
    end;
  finally
    expoFDQuery.Close;
    FDConnection1.Close;
  end;

end;

function TServerMethods.PaytypeData(username, password: string): TStream;
begin
  Result:=TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      paytypeFDQuery.Close;
      paytypeFDQuery.Open;
      paytypeFDQuery.SaveToStream(Result,TFDStorageFormat.sfBinary);
      Result.Position:=0;
    except
      on E: Exception do
      begin
        Writeln(E.Message);
      end;
    end;
  finally
    paytypeFDQuery.Close;
    FDConnection1.Close;
  end;
end;

function TServerMethods.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

