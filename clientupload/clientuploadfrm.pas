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
    FUploading: Boolean;
    procedure Dataupload;
    procedure clientuploadDataModuleOnExce(const s: string);
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property IsUploading: Boolean read FUploading;
  end;

implementation

{$R *.dfm}

uses clientuploaddm;

procedure TbplclientuploadFrame.Dataupload;
var
  eshopperupload:boolean;
  ecustomerupload:boolean;
begin
  eshopperupload:=false;
  ecustomerupload:=false;
  clientuploadDataModule.OnExec:=clientuploadDataModuleOnExce;
  try
    try
     // clientuploadDataModule.ShopperDataUpload;
    except
      on E: Exception do
      begin
        eshopperupload:=true;
        Memo1.Lines.Add('顾客数据上传失败');
        Memo1.Lines.Add(E.Message);
      end;
    end;

    try
      clientuploadDataModule.CustomerDataUpload;
    except
      on E: Exception do
      begin
        Memo1.Lines.Add('客户数据上传失败');
        Memo1.Lines.Add(E.Message);
      end;
    end;
  finally
    FUploading:=false;
    Button1.Enabled:=true;
    clientuploadDataModule.OnExec:=nil;
  end;
end;

procedure TbplclientuploadFrame.Button1Click(Sender: TObject);
begin
  if not FUploading then
  begin
    FUploading:=true;
    Button1.Enabled:=false;
    TThread.CreateAnonymousThread(DataUpload).Start;
  end;

end;

procedure TbplclientuploadFrame.clientuploadDataModuleOnExce(const s: string);
begin
  if Assigned(Memo1) then
  begin
    memo1.Lines.add(s);
  end;
end;

constructor TbplclientuploadFrame.Create(AOwner: TComponent);
begin
  inherited;
  clientuploadDataModule:=TclientuploadDataModule.Create(self);
  FUploading:=false;
end;

destructor TbplclientuploadFrame.Destroy;
begin
  FreeAndNil(clientuploadDataModule);
  inherited;
end;

end.
