unit datamoudle;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, Data.DBXCommon, IPPeerClient, Data.DB,
  Data.SqlExpr,System.Json,Vcl.Dialogs, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent;

type
  TupdateDataModule = class(TDataModule)
    SQLConnection1: TSQLConnection;
    NetHTTPClient1: TNetHTTPClient;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure NetHTTPClient1AuthEvent(const Sender: TObject; AnAuthTarget: TAuthTargetType;
      const ARealm, AURL: string; var AUserName, APassword: string; var AbortAuth: Boolean;
      var Persistence: TAuthPersistenceType);
  private
    { Private declarations }
    FUpdateJson:TJsonObject;
  public
    { Public declarations }
    property UpdateJson:TJsonObject read FUpdateJson;
    function GetUpdateList:boolean;
  end;

var
  updateDataModule: TupdateDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  servermethods,common;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TupdateDataModule }

procedure TupdateDataModule.DataModuleCreate(Sender: TObject);
begin
 FUpdateJson:=TJSONObject.Create;
end;

procedure TupdateDataModule.DataModuleDestroy(Sender: TObject);
begin
 if Assigned(FUpdateJson) then FreeAndNil(FUpdateJson);
end;

function TupdateDataModule.GetUpdateList: boolean;
var
  server:TServerMethodsClient;
  str:string;
  response:IHTTPResponse;
begin
  Result:=false;
  response:=NetHTTPClient1.Get(UpdateUrl+'update.json');
  if response.StatusCode=200 then
  begin
     FUpdateJson.Parse(TEncoding.UTF8.GetBytes(response.ContentAsString),0);
     Result:=FUpdateJson.GetValue('result').Value.ToLower='success';
  end
  else
  begin
    try
      try
        SQLConnection1.Open;
      except
        exit;
      end;
      server:=TServerMethodsClient.Create(SQLConnection1.DBXConnection);
      str:=server.GetUpdatefiles;
      FUpdateJson.Parse(TEncoding.UTF8.GetBytes(str), 0);
      Result:=FUpdateJson.GetValue('result').Value.ToLower='success';
    finally
      SQLConnection1.Close;
      server.Free;
    end;
  end;

end;

procedure TupdateDataModule.NetHTTPClient1AuthEvent(const Sender: TObject;
  AnAuthTarget: TAuthTargetType; const ARealm, AURL: string; var AUserName, APassword: string;
  var AbortAuth: Boolean; var Persistence: TAuthPersistenceType);
begin
  AUserName:='updateuser';
  APassword:='update'
end;

end.
