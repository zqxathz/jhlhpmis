program start;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  System.SyncObjs,
  main in 'main.pas' {mainform},
  login in 'login.pas' {loginframe: TFrame},
  logindm in 'logindm.pas' {logindatamod: TDataModule},
  staticstr in '..\common\staticstr.pas',
  connectiondm in '..\connection\connectiondm.pas' {connectionDataModule: TDataModule};

{$R *.res}

var
  hAppMutex: TMutex; //声明互斥变量

begin
  //hAppMutex:=TMutex.Create();
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := '京湖青莲展览';
  TStyleManager.TrySetStyle('Metropolis UI Blue');
  Application.CreateForm(Tmainform, mainform);
  Application.CreateForm(TconnectionDataModule, connectionDataModule);
  Application.CreateForm(Tlogindatamod, logindatamod);

  Application.Run;
end.
