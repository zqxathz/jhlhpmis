program server;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes,
  IPPeerAPI,
  Datasnap.DSHTTP,
  Datasnap.DSTransport,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSServer,
  ServerConst in 'ServerConst.pas',
  ServerMethodsUnit in 'ServerMethodsUnit.pas' {ServerMethods: TDSServerModule},
  ServerContainerUnit in 'ServerContainerUnit.pas' {ServerContainer1: TDataModule},
  Alidayu in 'Alidayu.pas',
  Serverdm in 'Serverdm.pas' {ServerDataModule: TDataModule},
  Data.DBXClientResStrs in 'Data.DBXClientResStrs.pas',
  ServerAdminUnit in 'ServerAdminUnit.pas' {ServerAdminMethods: TDataModule};

begin
  // ReportMemoryLeaksOnShutdown := true;
  try
    RunDSServer;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end

end.
