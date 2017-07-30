unit ServerContainerUnit;

interface

uses
  System.SysUtils,
  System.Classes,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSHTTPCommon,
  Datasnap.DSHTTP,
  Datasnap.DSServer,
  Datasnap.DSCommonServer,
  IPPeerServer,
  IPPeerAPI,
  Datasnap.DSAuth,
  DbxCompressionFilter;

type
  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSHTTPService1: TDSHTTPService;
    DSAuthenticationManager1: TDSAuthenticationManager;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure DSAuthenticationManager1UserAuthorize(Sender: TObject; EventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject; const Protocol, Context, User, Password: string; var valid: Boolean; UserRoles: TStrings);
    procedure DSServer1Prepare(DSPrepareEventObject: TDSPrepareEventObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
  end;

procedure RunDSServer;

implementation

uses
  ServerMethodsUnit,
  ServerConst,
  Serverdm;

{%CLASSGROUP 'System.Classes.TPersistent'}


{$R *.dfm}

procedure TServerContainer1.DSServer1Prepare(DSPrepareEventObject: TDSPrepareEventObject);
begin
  Log := TServerLogThread.Create;
  Log.AddLog('username:' + DSPrepareEventObject.UserName);
  Log.AddLog('ip:' + DSPrepareEventObject.ServerConnectionHandler.Channel.ChannelInfo.ClientInfo.IpAddress);
  Log.AddLog('exect:' + DSPrepareEventObject.MethodAlias); //Log调用方法
  Log.start;
end;

procedure TServerContainer1.DSServerClass1GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsUnit.TServerMethods;
end;

procedure TServerContainer1.DataModuleCreate(Sender: TObject);
begin
  One := Tobject.create;
  ServerDataModule := TServerDataModule.Create(nil);
end;

procedure TServerContainer1.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(one) then
    one.Free;
  if Assigned(ServerDataModule) then
    ServerDataModule.free;
end;

procedure TServerContainer1.DSAuthenticationManager1UserAuthenticate(Sender: TObject; const Protocol, Context, User, Password: string; var valid: Boolean; UserRoles: TStrings);
begin
  { TODO : Validate the client user and password.
    If role-based authorization is needed, add role names to the UserRoles parameter  }
  if (User.ToLower = 'guest') and (Password.ToLower = 'guest') then
  begin
    valid := true;
    exit;
  end;
  if assigned(ServerDataModule) then
  begin
    valid := ServerDataModule.verifyMember(User, Password);
    Writeln(User+','+Password);
  end;
end;

procedure TServerContainer1.DSAuthenticationManager1UserAuthorize(Sender: TObject; EventObject: TDSAuthorizeEventObject; var valid: Boolean);
begin
  { TODO : Authorize a user to execute a method.
    Use values from EventObject such as UserName, UserRoles, AuthorizedRoles and DeniedRoles.
    Use DSAuthenticationManager1.Roles to define Authorized and Denied roles
    for particular server methods. }
  //valid:=true; exit;
  valid := false;
  if EventObject.UserName.ToLower = 'guest' then
    valid := EventObject.MethodAlias = 'TServerMethods.GetUpdatefiles'
  else
    valid := True;
end;

function BindPort(Aport: Integer): Boolean;
var
  LTestServer: IIPTestServer;
begin
  Result := True;
  try
    LTestServer := PeerFactory.CreatePeer('', IIPTestServer) as IIPTestServer;
    LTestServer.TestOpenPort(Aport, nil);
  except
    Result := False;
  end;
end;

function CheckPort(Aport: Integer): Integer;
begin
  if BindPort(Aport) then
    Result := Aport
  else
    Result := 0;
end;

procedure SetPort(const Aserver: TServerContainer1; const APort: string; AProtocol: DSProtocol);
var
  IsPortSet: Boolean;
begin
  IsPortSet := True;
  if not (Aserver.DSServer1.Started) then
  begin
    if CheckPort(APort.ToInteger) > 0 then
    begin
      case AProtocol of
        DSProtocol.TCPIP:
          Aserver.DSTCPServerTransport1.Port := APort.ToInteger;
        DSProtocol.HTTP:
          Aserver.DSHTTPService1.HttpPort := APort.ToInteger;

      else
        IsPortSet := False
      end;
      if IsPortSet then
        Writeln(Format(sPortSet, [APort]))
      else
        Writeln(Format(sPortNotSet, [APort]));
    end
    else
      Writeln(Format(sPortInUse, [APort]));
  end
  else
    Writeln(sServerRunning);
  Write(cArrow);
end;

procedure StartServer(const AServer: TServerContainer1);
var
  LStart: Boolean;
begin
  LStart := True;
  if not (AServer.DSServer1.Started) then
  begin
    if CheckPort(AServer.DSTCPServerTransport1.Port) <= 0 then
    begin
      Writeln(Format(sPortInUse, [AServer.DSTCPServerTransport1.Port.ToString]));
      LStart := False;
    end;
    if CheckPort(AServer.DSHTTPService1.HttpPort) <= 0 then
    begin
      Writeln(Format(sPortInUse, [AServer.DSHTTPService1.HttpPort.ToString]));
      LStart := False;
    end;
  end
  else
    Writeln(sServerRunning);

  if LStart then
  begin
    Writeln(sStartingServer);
    AServer.DSServer1.Start;
  end;
  Write(cArrow);
end;

procedure StopServer(const AServer: TServerContainer1);
begin
  if AServer.DSServer1.Started then
  begin
    Writeln(sStoppingServer);
    AServer.DSServer1.Stop;
    Writeln(sServerStopped);
  end
  else
    Writeln(sServerNotRunning);
  Write(cArrow);
end;

procedure WriteCommands;
begin
  Writeln(sCommands);
  Write(cArrow);
end;

procedure WriteStatus(const AServer: TServerContainer1);
begin
  Writeln(sActive + AServer.DSServer1.Started.ToString(TUseBoolStrs.True));
  Writeln(sTCPIPPort + AServer.DSTCPServerTransport1.Port.ToString);
  Writeln(sHTTPPort + AServer.DSHTTPService1.HttpPort.ToString);

  Write(cArrow);
end;

procedure Test;
begin
   //
end;

procedure RunDSServer;
var
  LModule: TServerContainer1;
  LResponse: string;
begin
  LModule := TServerContainer1.Create(nil);
  LModule.DSServer1.Start;
  try
    if LModule.DSServer1.Started then
    begin
      Writeln(sServerIsRunning);
      Writeln(TThread.Current.ThreadID.ToString);
    end;
    WriteCommands;
    while True do
    begin
      Readln(LResponse);
      LResponse := LowerCase(LResponse);
      if sametext(LResponse, cCommandStart) then
        StartServer(LModule)
      else if sametext(LResponse, cCommandStatus) then
        WriteStatus(LModule)
      else if sametext(LResponse, cCommandStop) then
        StopServer(LModule)
      else if LResponse.StartsWith(cCommandSetTCPIPPort) then
        SetPort(LModule, LResponse.Replace(cCommandSetTCPIPPort, '').Trim, DSProtocol.TCPIP)
      else if LResponse.StartsWith(cCommandSetHTTPPort) then
        SetPort(LModule, LResponse.Replace(cCommandSetHTTPPort, '').Trim, DSProtocol.HTTP)
      else if sametext(LResponse, cCommandHelp) then
        WriteCommands
      else if sametext(LResponse, 'test') then
        Test
      else if sametext(LResponse, cCommandExit) then
        if LModule.DSServer1.Started then
        begin
          StopServer(LModule);
          break
        end
        else
          break
      else
      begin
        Writeln(sInvalidCommand);
        Write(cArrow);
      end;
    end;
  finally
    LModule.Free;
  end;
end;

end.

