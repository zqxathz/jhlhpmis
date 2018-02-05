unit plugin_admin_roleselectfrom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxCustomData,
  cxStyles, cxTL, cxTextEdit, cxCheckBox, cxTLdxBarBuiltInMenu, cxInplaceContainer, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TroleselectForm = class(TForm)
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    cxTreeList1: TcxTreeList;
    cxTreeList1Column1: TcxTreeListColumn;
    cxTreeList1Column2: TcxTreeListColumn;
    cxTreeList1Column3: TcxTreeListColumn;
    Panel1: TPanel;
    Button3: TButton;
    Button4: TButton;
    procedure cxTreeList1Column2PropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  roleselectForm: TroleselectForm;

implementation

{$R *.dfm}

procedure TroleselectForm.cxTreeList1Column2PropertiesChange(Sender: TObject);
var
  i:integer;
begin
  if cxTreeList1.FocusedNode.Level=0 then
  begin
    for  i:=0 to cxTreeList1.FocusedNode.ChildVisibleCount-1 do
    begin
      cxTreeList1.FocusedNode.Items[i].Values[2]:=cxTreeList1.FocusedNode.Values[2];
    end;
  end;
end;

end.
