unit Serverdm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,System.Json,System.Variants;

type
  TServerDataModule = class(TDataModule)
    FDConnection1: TFDConnection;
    memberFDQuery: TFDQuery;
    methodFDQuery: TFDQuery;
    groupFDQuery: TFDQuery;
    addmethodFDQuery: TFDQuery;
    FDManager1: TFDManager;
  private
    { Private declarations }
  public
    { Public declarations }
    function verifyMember(const username, password: string): string;
    function getMethodauthids(const method: string; list: TStrings): boolean;
    procedure AddMethods(list:TJSONArray);
  end;

var
  ServerDataModule: TServerDataModule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}
{ TServerDataModule }

procedure TServerDataModule.AddMethods(list: TJSONArray);
var
  value:TJSONValue;
  maxid:integer;
  hasmethod:Boolean;
begin
  addmethodFDQuery.Open;

  //addmethodFDQuery.ServerDeleteAll();
  try
    try
      addmethodFDQuery.Last;
      while not addmethodFDQuery.Bof do
      begin
        hasmethod:=false;
        for value in list do
          if addmethodFDQuery.FieldByName('methodalias').AsString=value.Value then
          begin
            hasmethod:=true;
            break;
          end;
        if not hasmethod then addmethodFDQuery.Delete;
        addmethodFDQuery.Prior;
      end;
      addmethodFDQuery.AggregatesActive:=true;
      if Varisnull(addmethodFDQuery.Aggregates.Items[0].Value) then
        maxid:=0
      else
        maxid:=addmethodFDQuery.Aggregates.Items[0].Value;
      addmethodFDQuery.Connection.StartTransaction;
      for value in list do
      begin
        addmethodFDQuery.First;
        if addmethodFDQuery.Locate('methodalias',value.Value) then
           Continue;
        inc(maxid);
        addmethodFDQuery.Append;
        addmethodFDQuery.FieldByName('id').Value:=maxid;
        addmethodFDQuery.FieldByName('methodalias').Value:=value.Value;
        addmethodFDQuery.FieldByName('methodtitle').Value:=value.Value;
        addmethodFDQuery.Post;
      end;
      addmethodFDQuery.Connection.Commit;
    except
      addmethodFDQuery.Connection.Rollback;
      raise ;
    end;
  finally
    addmethodFDQuery.AggregatesActive:=false;
    addmethodFDQuery.Close;
  end;
end;

function TServerDataModule.getMethodauthids(const method: string;
  list: TStrings): boolean;
var
  ids: TArray<string>;
  methodid: integer;
  methodids: string;
  i, j: integer;
begin
  Result := false;
  if not FDConnection1.Connected then
    try
      FDConnection1.Open;
    except
      exit;
    end;

  try
    methodFDQuery.Close;
    methodFDQuery.ParamByName('methodalias').AsString := method;
    methodFDQuery.Open;

    if methodFDQuery.RecordCount = 0 then
      exit;

    methodid := methodFDQuery.FieldByName('id').AsInteger;
    methodFDQuery.Close;

    groupFDQuery.Open;
    for i := 0 to list.Count - 1 do
    begin
      if not groupFDQuery.Locate('name',list.Strings[i]) then Continue;
      Result := groupFDQuery.FieldByName('authmethod').AsString.Contains(method);
      if Result then
        break;
    end;
  finally
    groupFDQuery.Close;
    methodFDQuery.Close;
    FDConnection1.Close;
  end;
end;

function TServerDataModule.verifyMember(const username,
  password: string): string;
begin
  Result := '';
  memberFDQuery.Close;
  memberFDQuery.Params.Items[0].Value := username;
  memberFDQuery.Params.Items[1].Value := password;
  try
    memberFDQuery.Open();
    if memberFDQuery.RecordCount > 0 then
      Result := memberFDQuery.FieldByName('name').AsString;
  finally
    memberFDQuery.Close;
    FDConnection1.Close;
  end;
end;

end.
