unit clientsyc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,clientsycdm, Vcl.StdCtrls;

type
  TclientsycFrame = class(TFrame)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TclientsycFrame.Button1Click(Sender: TObject);
begin
 if clientsycDataModule=nil then
   clientsycDataModule:=TclientsycDataModule.Create(nil);
 ShowMessage(clientsycDataModule.test);
end;

end.
