unit logindm;

interface

uses
  System.SysUtils, System.Classes,staticstr, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  Tlogindatamod = class(TDataModule)
    loginfdquery: TFDQuery;
  private
    { Private declarations }
    FUsername:string;
    FPassword:string;
    FUserid:integer;
  public
  { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property Username:string read FUsername write FUsername;
    property Password:string read FPassword write FPassword;
    property Userid:integer read FUserid;
    procedure login;
  end;

var
  logindatamod: Tlogindatamod;


implementation
uses connectiondm;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tlogindatamod }

constructor Tlogindatamod.Create(AOwner: TComponent);
begin
  inherited;
  FUsername:='';
  FPassword:='';
  FUserid:=0;
end;

procedure Tlogindatamod.login;
begin

  loginfdquery.SQL.Clear;
  loginfdquery.Open(format(LOGIN_SQL,[Username,Password]));
  if loginfdquery.RecordCount=0 then
    raise Exception.Create('用户名或密码错误 ')
  else
  begin
    clientuser.Username:=Username;
    clientuser.Password:=Password;
    clientuser.Userid:=loginfdquery.FieldValues['id'];
    FUserid:=loginfdquery.FieldValues['id'];
  end;
end;

end.
