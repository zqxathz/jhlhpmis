unit setting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, bplframe,Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTreeView, Vcl.StdCtrls, System.Actions, Vcl.ActnList, dxNavBarCollns,
  cxClasses, dxNavBarBase, dxNavBar, Vcl.ExtCtrls,System.Inifiles;

type
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

procedure TbplsettingFrame.CancelActionExecute(Sender: TObject);
begin
  if Assigned(FOnClose) then PostMessage(Handle,WM_USER + 100,0,0);
    //FOnClose(nil);
end;

constructor TbplsettingFrame.Create(AOwner: TComponent);
begin
  inherited;
  NetScrollBox.BringToFront;
end;

procedure TbplsettingFrame.netresetActionExecute(Sender: TObject);
begin
   if Application.MessageBox('是否要恢复默认值?', '询问', MB_YESNO + MB_ICONQUESTION +
    MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
     begin
       ServerLabeledEdit.Text:='www.jhlotus.com';
       PortLabeledEdit.Text:='211';
       UpdateServerLabeledEdit.Text:='update.jhlotus.com';
     end;
end;

procedure TbplsettingFrame.NetSettingActionExecute(Sender: TObject);
begin
  GroupBox1.Caption:=TAction(Sender).Caption;
  NetScrollBox.BringToFront;
end;

procedure TbplsettingFrame.OkActionExecute(Sender: TObject);
begin
  if Assigned(FOnClose) then PostMessage(Handle,WM_USER + 100,0,0);
end;

procedure TbplsettingFrame.softwareActionExecute(Sender: TObject);
begin
  GroupBox1.Caption:=TAction(Sender).Caption;
  softwareScrollBox.BringToFront;
end;

end.
