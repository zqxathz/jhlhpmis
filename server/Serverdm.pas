unit Serverdm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TServerDataModule = class(TDataModule)
    FDConnection1: TFDConnection;
    memberFDQuery: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function verifyMember(const username,password:string):boolean;
  end;

var
  ServerDataModule: TServerDataModule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServerDataModule }

function TServerDataModule.verifyMember(const username, password: string): boolean;
begin
  result:=false;
  memberFDQuery.Close;
  memberFDQuery.Params.Items[0].Value:=username;
  memberFDQuery.Params.Items[1].Value:=password;
  try
    memberFDQuery.Open();
    result:= memberFDQuery.FieldByName('count').AsInteger>0;
  finally
    FDConnection1.Close;
  end;
end;

end.
