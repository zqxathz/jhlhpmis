unit setting;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, bplframe,Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTreeView;

type
  TbplsettingFrame = class(TFrame)
    cxTreeView1: TcxTreeView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
