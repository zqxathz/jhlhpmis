unit confirmappend;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TconfirmappendForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    private
      { Private declarations }
    public
      { Public declarations }
  end;

var
  confirmappendForm: TconfirmappendForm;

implementation

{$R *.dfm}

procedure TconfirmappendForm.CheckBox1Click(Sender: TObject);
begin
  Button1.Enabled := CheckBox1.Checked;
end;

procedure TconfirmappendForm.FormShow(Sender: TObject);
begin
  Button2.SetFocus;
end;

end.
