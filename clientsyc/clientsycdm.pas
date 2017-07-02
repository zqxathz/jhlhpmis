unit clientsycdm;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, Data.DBXCommon,
  IPPeerClient, Data.DB, Data.SqlExpr;

type
  TclientsycDataModule = class(TDataModule)
    SQLConnection1: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function test:string;
  end;

var
  clientsycDataModule: TclientsycDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses servermethods;

{$R *.dfm}

{ TclientsycDataModule }

procedure TclientsycDataModule.DataModuleCreate(Sender: TObject);
begin
 SQLConnection1.Open;
end;

procedure TclientsycDataModule.DataModuleDestroy(Sender: TObject);
begin
 SQLConnection1.Close;
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
