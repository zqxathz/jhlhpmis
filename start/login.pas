unit login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, logindm, Vcl.ExtCtrls,clientsycdm;

type
  Tloginframe = class(TFrame)
    GroupBox1: TGroupBox;
    usernameedit: TEdit;
    passwordedit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    loginbutton: TButton;
    syncmemberButton: TButton;
    procedure loginbuttonClick(Sender: TObject);
    procedure syncmemberButtonClick(Sender: TObject);
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
  clientuser:=TClientUser.create;
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

procedure Tloginframe.syncmemberButtonClick(Sender: TObject);
begin
  clientsycDataModule:=TclientsycDataModule.Create(self);
  try
    clientsycDataModule.GetMemberData;
    if clientsycDataModule.SyncError then
    begin
      Beep;
      ShowMessage('同步失败,请检查网络');
    end
    else
    begin
      Showmessage('同步成功!')
    end;
  finally
    clientsycDataModule.Free;
    clientsycDataModule:=nil;
  end;
end;

end.
