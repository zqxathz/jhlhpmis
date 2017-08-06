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
    destructor Destroy; override;
    { Public declarations }

  end;

implementation

{$R *.dfm}

uses connectiondm;

destructor Tloginframe.Destroy;
begin
  if Assigned(clientuser) then FreeAndNil(clientuser);
  inherited;
end;

procedure Tloginframe.loginbuttonClick(Sender: TObject);
begin
  logindatamod.Username:=usernameedit.Text;
  logindatamod.Password:=passwordedit.Text;
  if Assigned(clientuser) then FreeAndNil(clientuser);
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
  if Assigned(clientuser) then FreeAndNil(clientuser);
  clientuser:=TClientUser.create;
  clientuser.Username:=usernameedit.Text;
  clientuser.Password:=passwordedit.Text;

  clientsycDataModule:=TclientsycDataModule.Create(self);
  try
    if clientsycDataModule.CantConnection then
    begin
      Beep;
      ShowMessage(clientsycDataModule.ErrorMsg);
      exit;
    end;
    clientsycDataModule.GetMemberData;
    if clientsycDataModule.SyncError then
    begin
      Beep;
      if clientsycDataModule.ErrorMsg.Contains('拒绝') then
        ShowMessage('用户名或者密码错误')
      else
        ShowMessage('同步失败,请检查网络,错误原因:'+clientsycDataModule.ErrorMsg);
    end
    else
    begin
      Showmessage('同步成功!')
    end;
  finally
    clientsycDataModule.Free;
    clientsycDataModule:=nil;
    FreeAndNil(clientuser);
  end;
end;

end.
