unit clientuploadfrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TbplclientuploadFrame = class(TFrame)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

uses clientuploaddm;

procedure TbplclientuploadFrame.Button1Click(Sender: TObject);
begin
{
  try
    clientuploadDataModule.CustomerDataUpload;
  except on E: Exception do
    Memo1.Lines.Add(E.Message);
  end;
 }
  try
    clientuploadDataModule.ShopperDataUpload;
  except on E: Exception do
    Memo1.Lines.Add(E.Message);
  end;
end;

constructor TbplclientuploadFrame.Create(AOwner: TComponent);
begin
  inherited;
  clientuploadDataModule:=TclientuploadDataModule.Create(self);
end;

destructor TbplclientuploadFrame.Destroy;
begin
  FreeAndNil(clientuploadDataModule);
  inherited;
end;

end.
