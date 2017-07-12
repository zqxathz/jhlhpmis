unit connectiondm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB;

type
  TClientUser = class
  private
    FUsername:string;
    FPassword:string;
    FUserid:string;
  public
    property Username: string read FUsername write FUsername;
    property Password: string read FPassword write FPassword;
    property Userid:string read FUserid write FUserid;
    constructor Create;
  end;

  TconnectionDataModule = class(TDataModule)
    mainFDConnection: TFDConnection;
    mainFDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  connectionDataModule: TconnectionDataModule;
  clientuser:TClientUser;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses connectionconfig,VCL.Forms;

{$R *.dfm}

procedure TconnectionDataModule.DataModuleCreate(Sender: TObject);
var
 apppath:string;
begin
  apppath:=ExtractFilePath(Application.Exename);
  if not FileExists(apppath+sqlite3DLL) then
    sqlite3DLL:=debug_path+sqlite3DLL;
  if not FileExists(apppath+databasename) then
    databasename:=debug_path+databasename;


  mainFDConnection.Params.Clear;
  mainFDConnection.Params.DriverID:='jhqlSQLite';
  mainFDConnection.Params.Add('Password='+sqlite3password);
  mainFDConnection.Params.Add('Database='+apppath+databasename);
  mainFDConnection.Params.Add('LockingMode=Normal');
  mainFDConnection.Params.Add('Synchronous=Full');
  mainFDPhysSQLiteDriverLink.VendorLib:=apppath+sqlite3DLL;
  mainFDConnection.Connected:=true;
end;

procedure TconnectionDataModule.DataModuleDestroy(Sender: TObject);
begin
  mainFDConnection.Close;
end;

{ TClientUser }

constructor TClientUser.Create;
begin
  inherited;
  FUsername:='';
  FPassword:='';
  FUserid:='';
end;

end.
