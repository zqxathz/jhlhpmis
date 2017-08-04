program server;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  ServerConst in 'ServerConst.pas',
  ServerMethodsUnit
  in 'ServerMethodsUnit.pas' {ServerMethods: TDSServerModule} ,
  ServerContainerUnit
    in 'ServerContainerUnit.pas' {ServerContainer1: TDataModule} ,
  Alidayu in 'Alidayu.pas',
  Serverdm in 'Serverdm.pas' {ServerDataModule: TDataModule} ,
  Data.DBXClientResStrs in 'Data.DBXClientResStrs.pas';

begin
  // ReportMemoryLeaksOnShutdown := true;
  try
    RunDSServer;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end

end.
