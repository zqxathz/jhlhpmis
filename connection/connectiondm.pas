unit connectiondm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Phys.DS, FireDAC.Phys.DSDef, Data.DB;

type
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

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses connectionconfig,VCL.Forms;

{$R *.dfm}

procedure TconnectionDataModule.DataModuleCreate(Sender: TObject);
var
 apppath:string;
begin
  apppath:=ExtractFilePath(Application.Exename);
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

end.
