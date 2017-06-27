unit login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, logindm;

type
  Tloginframe = class(TFrame)
    GroupBox1: TGroupBox;
    usernameedit: TEdit;
    passwordedit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    loginbutton: TButton;
    procedure loginbuttonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses connectiondm;

procedure Tloginframe.loginbuttonClick(Sender: TObject);
begin
  logindatamod.Username:=usernameedit.Text;
  logindatamod.Password:=passwordedit.Text;
  try
    try
      logindatamod.loginfdquery.Connection:=connectionDataModule.mainFDConnection;
      logindatamod.login;
    except
       on E:Exception do raise Exception.Create(E.Message);
    end;
  finally
    logindatamod.loginfdquery.Connection.Close;
  end;
end;

end.
