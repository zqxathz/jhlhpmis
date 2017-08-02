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
    methodFDQuery: TFDQuery;
    groupFDQuery: TFDQuery;
    FDQuery: TFDQuery;
    FDManager1: TFDManager;
  private
    { Private declarations }
  public
    { Public declarations }
    function verifyMember(const username,password:string):string;
    function getMethodauthids(const method:string;list:TStrings):boolean;
  end;

var
  ServerDataModule: TServerDataModule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServerDataModule }

function TServerDataModule.getMethodauthids(const method: string; list: TStrings): boolean;
var
  ids:TArray<string>;
  methodid:integer;
  methodids:string;
  i,j:integer;
begin
  Result:=false;
  if not FDConnection1.Connected then
  try
    FDConnection1.Open;
  except
    exit;
  end;

  try
    methodFDQuery.Close;
    methodFDQuery.ParamByName('methodalias').AsString:=method;
    methodFDQuery.Open;

    if methodFDQuery.RecordCount=0 then exit;

    methodid:=methodFDQuery.FieldByName('id').AsInteger;
    methodFDQuery.Close;

    for i := 0 to list.Count-1 do
    begin
      groupFDQuery.Close;
      groupFDQuery.ParamByName('name').AsString:=list.Strings[i];
      groupFDQuery.Open;
      //groupFDQuery.FieldByName('authmethod').AsString
      methodids:= groupFDQuery.FieldByName('authmethod').AsString;
      ids:=methodids.Split([',']);
      for j := 0 to length(ids)-1 do
      begin
        if methodid.ToString=ids[j] then
        begin
          Result:=true;
          break;
        end;
      end;
      if Result then break;
    end;
  finally
    groupFDQuery.Close;
    methodFDQuery.Close;
    FDConnection1.Close;
  end;
end;

function TServerDataModule.verifyMember(const username, password: string): string;
begin
  result:='';
  memberFDQuery.Close;
  memberFDQuery.Params.Items[0].Value:=username;
  memberFDQuery.Params.Items[1].Value:=password;
  try
    memberFDQuery.Open();
    if memberFDQuery.RecordCount>0 then
      result:= memberFDQuery.FieldByName('name').AsString;
  finally
    memberFDQuery.Close;
    FDConnection1.Close;
  end;
end;

end.
