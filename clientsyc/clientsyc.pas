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
    procedure clientsycDataModuleOnExce(const s: string);
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TclientsycFrame.clientsycDataModuleOnExce(const s:string);
begin
  if Assigned(Memo1) then
  begin
    memo1.Lines.add(s);
    //Memo1.Repaint;
  end;
end;

procedure TclientsycFrame.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;    //清空
  Memo1.Repaint;  //重画


  clientsycDataModule.OnExec:=clientsycDataModuleOnExce;    //关联事件

  clientsycDataModule.GetExpotypeData;       //展会类型

  if not clientsycDataModule.SyncError then
    clientsycDataModule.GetExpoData;          //可用展会

  if not clientsycDataModule.SyncError then
    clientsycDataModule.GetCustomertypeData;  //客户类型

  if not clientsycDataModule.SyncError then
    clientsycDataModule.GetPaytypeData;       //支付类型

  if not clientsycDataModule.SyncError then
    clientsycDataModule.GetShoppersourceData;  //顾客来源

  if not clientsycDataModule.SyncError then
    clientsycDataModule.GetMemberData;        //系统成员


  if not clientsycDataModule.SyncError then
    Memo1.Lines.Add('同步数据完成')
  else
    Memo1.Lines.Add('同步数据时发生错误,有可能导致数据不完整,建议稍后再次同步')
end;

constructor TclientsycFrame.Create(AOwner: TComponent);
begin
  inherited;
  if clientsycDataModule=nil then
        clientsycDataModule:=TclientsycDataModule.Create(self);

  Button1.Enabled:=clientsycDataModule.SQLConnection1.Connected;
  if clientsycDataModule.CantConnection then
      raise Exception.Create('无法连接到服务器,请稍后再试!');

end;

destructor TclientsycFrame.Destroy;
begin
  FreeAndNil(clientsycDataModule);
  inherited;
end;

end.
