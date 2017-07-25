unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,System.Json;

type
  TupdateForm = class(TForm)
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    updateJson:TJsonObject;
  end;

var
  updateForm: TupdateForm;

implementation

{$R *.dfm}

procedure TupdateForm.FormShow(Sender: TObject);
begin
  Memo1.Lines.Text:=updateJson.ToJSON;
end;

end.
