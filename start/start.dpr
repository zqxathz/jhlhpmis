program start;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  main in 'main.pas' {mainform},
  login in 'login.pas' {loginframe: TFrame},
  logindm in 'logindm.pas' {logindatamod: TDataModule},
  staticstr in '..\common\staticstr.pas',
  connectiondm in '..\connection\connectiondm.pas' {connectionDataModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := '¾©ºþÇàÁ«Õ¹ÀÀ';
  TStyleManager.TrySetStyle('Metropolis UI Blue');
  Application.CreateForm(Tmainform, mainform);
  Application.CreateForm(TconnectionDataModule, connectionDataModule);
  Application.CreateForm(Tlogindatamod, logindatamod);
  Application.Run;
end.
