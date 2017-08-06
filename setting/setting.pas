unit setting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, bplframe,Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTreeView, Vcl.StdCtrls, System.Actions, Vcl.ActnList, dxNavBarCollns,
  cxClasses, dxNavBarBase, dxNavBar, Vcl.ExtCtrls,System.Inifiles;

const
  SettingFile = 'setting.ini';
  Server = 'www.jhlotus.com';
  ServerPort = '211';
  UploadServer = 'http://update.jhlotus.com/';

type
  TSetting = record
  public
    class function GetValue(sec,name,default:string):string;overload;static;
    class procedure SetValue(sec,name,value:string);overload;static;
  end;

  TbplsettingFrame = class(TFrame)
    dxNavBar1: TdxNavBar;
    dxNavBar1Group1: TdxNavBarGroup;
    dxNavBar1Item1: TdxNavBarItem;
    ActionList1: TActionList;
    GroupBox1: TGroupBox;
    NetSettingAction: TAction;
    NetScrollBox: TScrollBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ServerLabeledEdit: TLabeledEdit;
    PortLabeledEdit: TLabeledEdit;
    ApplyAction: TAction;
    CancelAction: TAction;
    OkAction: TAction;
    UpdateServerLabeledEdit: TLabeledEdit;
    dxNavBar1Item2: TdxNavBarItem;
    softwareAction: TAction;
    softwareScrollBox: TScrollBox;
    netresetButton: TButton;
    netresetAction: TAction;
    procedure NetSettingActionExecute(Sender: TObject);
    procedure CancelActionExecute(Sender: TObject);
    procedure OkActionExecute(Sender: TObject);
    procedure softwareActionExecute(Sender: TObject);
    procedure netresetActionExecute(Sender: TObject);
    procedure ApplyActionExecute(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  private
    { Private declarations }
    FOnClose: TNotifyEvent;
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
    property OnClose: TNotifyEvent read FOnClose write FOnClose;

  end;

implementation

{$R *.dfm}

procedure TbplsettingFrame.ApplyActionExecute(Sender: TObject);
begin
 TSetting.SetValue('Net','server',ServerLabeledEdit.Text);
 TSetting.SetValue('Net','port',PortLabeledEdit.Text);
 TSetting.SetValue('Net','updateserver',UpdateServerLabeledEdit.Text);
end;

procedure TbplsettingFrame.CancelActionExecute(Sender: TObject);
begin
  if Assigned(FOnClose) then PostMessage(Handle,WM_USER + 100,0,0);
    //FOnClose(nil);
end;

constructor TbplsettingFrame.Create(AOwner: TComponent);
begin
  inherited;
  NetScrollBox.BringToFront;
  ServerLabeledEdit.Text:=TSetting.GetValue('Net','server',Server);
  PortLabeledEdit.Text:= TSetting.GetValue('Net','port',ServerPort);
  UpdateServerLabeledEdit.Text:= TSetting.GetValue('Net','updateserver',UploadServer);
end;

procedure TbplsettingFrame.FrameResize(Sender: TObject);
begin
  //GroupBox1.Refresh;
end;

procedure TbplsettingFrame.netresetActionExecute(Sender: TObject);
begin
   if Application.MessageBox('是否要恢复默认值?', '询问', MB_YESNO + MB_ICONQUESTION +
    MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
     begin
       ServerLabeledEdit.Text:=Server;
       PortLabeledEdit.Text:=ServerPort;
       UpdateServerLabeledEdit.Text:=UploadServer;
     end;
end;

procedure TbplsettingFrame.NetSettingActionExecute(Sender: TObject);
begin
  GroupBox1.Caption:=TAction(Sender).Caption;
  NetScrollBox.BringToFront;
end;

procedure TbplsettingFrame.OkActionExecute(Sender: TObject);
begin
  ApplyActionExecute(nil);
  if Assigned(FOnClose) then PostMessage(Handle,WM_USER + 100,0,0);
end;

procedure TbplsettingFrame.softwareActionExecute(Sender: TObject);
begin
  GroupBox1.Caption:=TAction(Sender).Caption;
  softwareScrollBox.BringToFront;
end;

{ TSetting }

class function TSetting.GetValue(sec, name, default: string): string;
var
  inifile:TIniFile;
begin
  inifile:=TIniFile.Create(ExtractFilePath(Application.ExeName)+SettingFile);
  try
    Result:=inifile.ReadString(sec,name,default);
  finally
    inifile.Free;
  end;
end;

class procedure TSetting.SetValue(sec, name, value: string);
var
  inifile:TIniFile;
begin
  inifile:=TIniFile.Create(ExtractFilePath(Application.ExeName)+SettingFile);
  try
    inifile.WriteString(sec,name,value);
  finally
    inifile.Free;
  end;
end;

end.
