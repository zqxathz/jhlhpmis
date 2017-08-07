unit plugin_admin_frame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxNavBarCollns, cxClasses, dxNavBarBase, dxNavBar, Vcl.StdCtrls;

type
  TpluginadminFrame = class(TFrame)
    dxNavBar1: TdxNavBar;
    dxNavBar1Group1: TdxNavBarGroup;
    dxNavBar1Item1: TdxNavBarItem;
    dxNavBar1Item2: TdxNavBarItem;
    dxNavBar1Item3: TdxNavBarItem;
    dxNavBar1Group2: TdxNavBarGroup;
    dxNavBar1Item4: TdxNavBarItem;
    dxNavBar1Item5: TdxNavBarItem;
    dxNavBar1Item6: TdxNavBarItem;
    dxNavBar1Item7: TdxNavBarItem;
    dxNavBar1Item8: TdxNavBarItem;
    GroupBox1: TGroupBox;
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }

  end;

implementation

{$R *.dfm}

uses plugin_admin_datamod;

{ TpluginadminFrame }

constructor TpluginadminFrame.Create(AOwner: TComponent);
begin
  inherited;
  pluginadmindm:=Tpluginadmindm.Create(Self);
end;

destructor TpluginadminFrame.Destroy;
begin
  pluginadmindm.Free;
  inherited;
end;

end.
