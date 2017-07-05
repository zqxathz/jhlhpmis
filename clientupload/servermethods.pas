// 
// Created by the DataSnap proxy generator.
// 2017/7/5 23:04:50
// 

unit servermethods;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethodsClient = class(TDSAdminClient)
  private
    FEchoStringCommand: TDBXCommand;
    FReverseStringCommand: TDBXCommand;
    FExpoDataCommand: TDBXCommand;
    FCustomertypeDataCommand: TDBXCommand;
    FPaytypeDataCommand: TDBXCommand;
    FExpoTypeDataCommand: TDBXCommand;
    FShopperSourceDataCommand: TDBXCommand;
    FCustomerDataPostCommand: TDBXCommand;
    FShopperDataPostCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function ExpoData(username: string; password: string): TStream;
    function CustomertypeData(username: string; password: string): TStream;
    function PaytypeData(username: string; password: string): TStream;
    function ExpoTypeData(username: string; password: string): TStream;
    function ShopperSourceData(username: string; password: string): TStream;
    function CustomerDataPost(AStream: TStream): string;
    function ShopperDataPost(AStream: TStream): string;
  end;

implementation

function TServerMethodsClient.EchoString(Value: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FDBXConnection.CreateCommand;
    FEchoStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FEchoStringCommand.Text := 'TServerMethods.EchoString';
    FEchoStringCommand.Prepare;
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.ExecuteUpdate;
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethodsClient.ReverseString(Value: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FDBXConnection.CreateCommand;
    FReverseStringCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FReverseStringCommand.Text := 'TServerMethods.ReverseString';
    FReverseStringCommand.Prepare;
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.ExecuteUpdate;
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethodsClient.ExpoData(username: string; password: string): TStream;
begin
  if FExpoDataCommand = nil then
  begin
    FExpoDataCommand := FDBXConnection.CreateCommand;
    FExpoDataCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FExpoDataCommand.Text := 'TServerMethods.ExpoData';
    FExpoDataCommand.Prepare;
  end;
  FExpoDataCommand.Parameters[0].Value.SetWideString(username);
  FExpoDataCommand.Parameters[1].Value.SetWideString(password);
  FExpoDataCommand.ExecuteUpdate;
  Result := FExpoDataCommand.Parameters[2].Value.GetStream(FInstanceOwner);
end;

function TServerMethodsClient.CustomertypeData(username: string; password: string): TStream;
begin
  if FCustomertypeDataCommand = nil then
  begin
    FCustomertypeDataCommand := FDBXConnection.CreateCommand;
    FCustomertypeDataCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FCustomertypeDataCommand.Text := 'TServerMethods.CustomertypeData';
    FCustomertypeDataCommand.Prepare;
  end;
  FCustomertypeDataCommand.Parameters[0].Value.SetWideString(username);
  FCustomertypeDataCommand.Parameters[1].Value.SetWideString(password);
  FCustomertypeDataCommand.ExecuteUpdate;
  Result := FCustomertypeDataCommand.Parameters[2].Value.GetStream(FInstanceOwner);
end;

function TServerMethodsClient.PaytypeData(username: string; password: string): TStream;
begin
  if FPaytypeDataCommand = nil then
  begin
    FPaytypeDataCommand := FDBXConnection.CreateCommand;
    FPaytypeDataCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FPaytypeDataCommand.Text := 'TServerMethods.PaytypeData';
    FPaytypeDataCommand.Prepare;
  end;
  FPaytypeDataCommand.Parameters[0].Value.SetWideString(username);
  FPaytypeDataCommand.Parameters[1].Value.SetWideString(password);
  FPaytypeDataCommand.ExecuteUpdate;
  Result := FPaytypeDataCommand.Parameters[2].Value.GetStream(FInstanceOwner);
end;

function TServerMethodsClient.ExpoTypeData(username: string; password: string): TStream;
begin
  if FExpoTypeDataCommand = nil then
  begin
    FExpoTypeDataCommand := FDBXConnection.CreateCommand;
    FExpoTypeDataCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FExpoTypeDataCommand.Text := 'TServerMethods.ExpoTypeData';
    FExpoTypeDataCommand.Prepare;
  end;
  FExpoTypeDataCommand.Parameters[0].Value.SetWideString(username);
  FExpoTypeDataCommand.Parameters[1].Value.SetWideString(password);
  FExpoTypeDataCommand.ExecuteUpdate;
  Result := FExpoTypeDataCommand.Parameters[2].Value.GetStream(FInstanceOwner);
end;

function TServerMethodsClient.ShopperSourceData(username: string; password: string): TStream;
begin
  if FShopperSourceDataCommand = nil then
  begin
    FShopperSourceDataCommand := FDBXConnection.CreateCommand;
    FShopperSourceDataCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FShopperSourceDataCommand.Text := 'TServerMethods.ShopperSourceData';
    FShopperSourceDataCommand.Prepare;
  end;
  FShopperSourceDataCommand.Parameters[0].Value.SetWideString(username);
  FShopperSourceDataCommand.Parameters[1].Value.SetWideString(password);
  FShopperSourceDataCommand.ExecuteUpdate;
  Result := FShopperSourceDataCommand.Parameters[2].Value.GetStream(FInstanceOwner);
end;

function TServerMethodsClient.CustomerDataPost(AStream: TStream): string;
begin
  if FCustomerDataPostCommand = nil then
  begin
    FCustomerDataPostCommand := FDBXConnection.CreateCommand;
    FCustomerDataPostCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FCustomerDataPostCommand.Text := 'TServerMethods.CustomerDataPost';
    FCustomerDataPostCommand.Prepare;
  end;
  FCustomerDataPostCommand.Parameters[0].Value.SetStream(AStream, FInstanceOwner);
  FCustomerDataPostCommand.ExecuteUpdate;
  Result := FCustomerDataPostCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethodsClient.ShopperDataPost(AStream: TStream): string;
begin
  if FShopperDataPostCommand = nil then
  begin
    FShopperDataPostCommand := FDBXConnection.CreateCommand;
    FShopperDataPostCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FShopperDataPostCommand.Text := 'TServerMethods.ShopperDataPost';
    FShopperDataPostCommand.Prepare;
  end;
  FShopperDataPostCommand.Parameters[0].Value.SetStream(AStream, FInstanceOwner);
  FShopperDataPostCommand.ExecuteUpdate;
  Result := FShopperDataPostCommand.Parameters[1].Value.GetWideString;
end;


constructor TServerMethodsClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TServerMethodsClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TServerMethodsClient.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FExpoDataCommand.DisposeOf;
  FCustomertypeDataCommand.DisposeOf;
  FPaytypeDataCommand.DisposeOf;
  FExpoTypeDataCommand.DisposeOf;
  FShopperSourceDataCommand.DisposeOf;
  FCustomerDataPostCommand.DisposeOf;
  FShopperDataPostCommand.DisposeOf;
  inherited;
end;

end.
