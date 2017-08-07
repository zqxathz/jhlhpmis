unit plugin_admin_datamod;

interface

uses
  System.SysUtils, System.Classes;

type
  Tpluginadmindm = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pluginadmindm: Tpluginadmindm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
