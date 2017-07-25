unit datamoudle;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, Data.DBXCommon, IPPeerClient, Data.DB,
  Data.SqlExpr,System.Json,Vcl.Dialogs;

type
  TupdateDataModule = class(TDataModule)
    SQLConnection1: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
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
  servermethods;

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
begin
  Result:=false;
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

end.
