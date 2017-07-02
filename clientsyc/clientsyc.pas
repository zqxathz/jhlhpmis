unit clientsyc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,clientsycdm, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TclientsycFrame = class(TFrame)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TclientsycFrame.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Memo1.Repaint;
  Memo1.Lines.Add('开始同步本地数据');
  Memo1.Lines.Add('开始更新展会信息');
  clientsycDataModule.GetExpoData;
  Memo1.Lines.Add('展会信息更新完成');
  Memo1.Lines.Add('本地数据同步完成');
end;

constructor TclientsycFrame.Create(AOwner: TComponent);
begin
  inherited;

  if clientsycDataModule=nil then
      clientsycDataModule:=TclientsycDataModule.Create(nil);

    Button1.Enabled:=clientsycDataModule.SQLConnection1.Connected;
    //raise;

end;

destructor TclientsycFrame.Destroy;
begin
  FreeAndNil(clientsycDataModule);
  inherited;
end;

end.
