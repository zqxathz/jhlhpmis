unit ServerContainerUnit;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSTCPServerTransport,
  Datasnap.DSHTTPCommon, Datasnap.DSHTTP, Datasnap.DSServer,
  Datasnap.DSCommonServer, IPPeerServer, IPPeerAPI, Datasnap.DSAuth,
  DbxCompressionFilter, System.JSON;

type
  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSHTTPService1: TDSHTTPService;
    DSAuthenticationManager1: TDSAuthenticationManager;
    DSServerClass1: TDSServerClass;
    DSServerClass2: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSAuthenticationManager1UserAuthorize(Sender: TObject;
      EventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DSServer1Prepare(DSPrepareEventObject: TDSPrepareEventObject);
    procedure DSServer1Connect(DSConnectEventObject: TDSConnectEventObject);
    procedure DSServerClass2GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
  end;

procedure RunDSServer;

implementation

uses
  ServerConst, Serverdm, ServerMethodsUnit, ServerAdminUnit;

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

procedure TServerContainer1.DSServer1Connect(DSConnectEventObject
  : TDSConnectEventObject);
var
  version, errormsg: string;
  n: integer;
begin
  errormsg := '';
  version := DSConnectEventObject.ConnectProperties.Values['version'];
  if version<>'update' then
  begin
    if (version = '') or (not trystrtoint(version, n)) then
      errormsg := '客户端版本不兼容,请检查程序'
    else if strtoint(version) < 1 then
      errormsg := '客户端版本太低,请更新程序';
    if not errormsg.IsEmpty then
      raise Exception.Create(errormsg);
  end;
end;

procedure TServerContainer1.DSServer1Prepare(DSPrepareEventObject
  : TDSPrepareEventObject);
begin
  if DSPrepareEventObject.MethodAlias.Contains('TServerMethods') then
  begin
    Log := TServerLogThread.Create;
    Log.AddLog('username:' + DSPrepareEventObject.UserName);
    Log.AddLog('ip:' + DSPrepareEventObject.ServerConnectionHandler.Channel.
      ChannelInfo.ClientInfo.IpAddress);
    Log.AddLog('exect:' + DSPrepareEventObject.MethodAlias); // Log调用方法
    Log.start;
  end;
  DSPrepareEventObject.ServerClass:=DSServerClass2;
end;

procedure TServerContainer1.DSServerClass1GetClass(DSServerClass
  : TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsUnit.TServerMethods;
end;

procedure TServerContainer1.DSServerClass2GetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerAdminUnit.TServerAdminMethods;
end;

procedure TServerContainer1.DataModuleCreate(Sender: TObject);
var
  list: TJSONArray;
begin
  One := TObject.Create;
  ServerDataModule := TServerDataModule.Create(nil);

  list := TJSONArray.Create;
  try
    DSServer1.GetServerMethods('', list);
    ServerDataModule.AddMethods(list);
  finally
    list.free;
  end;
end;

procedure TServerContainer1.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(One) then
    One.free;
  if Assigned(ServerDataModule) then
    ServerDataModule.free;
end;

procedure TServerContainer1.DSAuthenticationManager1UserAuthenticate
  (Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean; UserRoles: TStrings);
var
  group_asname: string;
begin
  { TODO : Validate the client user and password.
    If role-based authorization is needed, add role names to the UserRoles parameter }
  valid := false;
  if (User.ToLower = 'guest') and (Password.ToLower = 'guest') then
  begin
    valid := true;
    exit;
  end;
  if Assigned(ServerDataModule) then
  begin
    group_asname := ServerDataModule.verifyMember(User, Password);
    if group_asname <> '' then
    begin
      UserRoles.Add(group_asname);
      valid := true;
    end
    else
      valid := false;
  end;
end;

procedure TServerContainer1.DSAuthenticationManager1UserAuthorize
  (Sender: TObject; EventObject: TDSAuthorizeEventObject; var valid: Boolean);
begin
  { TODO : Authorize a user to execute a method.
    Use values from EventObject such as UserName, UserRoles, AuthorizedRoles and DeniedRoles.
    Use DSAuthenticationManager1.Roles to define Authorized and Denied roles
    for particular server methods. }
  // valid:=true; exit;
  valid := false;
  if EventObject.UserName.ToLower = 'guest' then
    valid := EventObject.MethodAlias = 'TServerMethods.GetUpdatefiles'
  else if EventObject.UserName.ToLower = 'admin' then
    valid := true
  else
    valid := ServerDataModule.getMethodauthids(EventObject.MethodAlias,
      EventObject.UserRoles);
end;

function BindPort(Aport: integer): Boolean;
var
  LTestServer: IIPTestServer;
begin
  Result := true;
  try
    LTestServer := PeerFactory.CreatePeer('', IIPTestServer) as IIPTestServer;
    LTestServer.TestOpenPort(Aport, nil);
  except
    Result := false;
  end;
end;

function CheckPort(Aport: integer): integer;
begin
  if BindPort(Aport) then
    Result := Aport
  else
    Result := 0;
end;

procedure SetPort(const Aserver: TServerContainer1; const Aport: string;
  AProtocol: DSProtocol);
var
  IsPortSet: Boolean;
begin
  IsPortSet := true;
  if not(Aserver.DSServer1.Started) then
  begin
    if CheckPort(Aport.ToInteger) > 0 then
    begin
      case AProtocol of
        DSProtocol.TCPIP:
          Aserver.DSTCPServerTransport1.Port := Aport.ToInteger;
        DSProtocol.HTTP:
          Aserver.DSHTTPService1.HttpPort := Aport.ToInteger;

      else
        IsPortSet := false
      end;
      if IsPortSet then
        Writeln(Format(sPortSet, [Aport]))
      else
        Writeln(Format(sPortNotSet, [Aport]));
    end
    else
      Writeln(Format(sPortInUse, [Aport]));
  end
  else
    Writeln(sServerRunning);
  Write(cArrow);
end;

procedure StartServer(const Aserver: TServerContainer1);
var
  LStart: Boolean;
begin
  LStart := true;
  if not(Aserver.DSServer1.Started) then
  begin
    if CheckPort(Aserver.DSTCPServerTransport1.Port) <= 0 then
    begin
      Writeln(Format(sPortInUse,
        [Aserver.DSTCPServerTransport1.Port.ToString]));
      LStart := false;
    end;
    if CheckPort(Aserver.DSHTTPService1.HttpPort) <= 0 then
    begin
      Writeln(Format(sPortInUse, [Aserver.DSHTTPService1.HttpPort.ToString]));
      LStart := false;
    end;
  end
  else
    Writeln(sServerRunning);

  if LStart then
  begin
    Writeln(sStartingServer);
    Aserver.DSServer1.start;
  end;
  Write(cArrow);
end;

procedure StopServer(const Aserver: TServerContainer1);
begin
  if Aserver.DSServer1.Started then
  begin
    Writeln(sStoppingServer);
    Aserver.DSServer1.Stop;
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

procedure WriteStatus(const Aserver: TServerContainer1);
begin
  Writeln(sActive + Aserver.DSServer1.Started.ToString(TUseBoolStrs.True));
  Writeln(sTCPIPPort + Aserver.DSTCPServerTransport1.Port.ToString);
  Writeln(sHTTPPort + Aserver.DSHTTPService1.HttpPort.ToString);

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
  // LModule.DSServer1.Start;
  try
    if LModule.DSServer1.Started then
    begin
      Writeln(sServerIsRunning);
      Writeln(TThread.Current.ThreadID.ToString);
    end;
    WriteCommands;
    while true do
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
        SetPort(LModule, LResponse.Replace(cCommandSetTCPIPPort, '').Trim,
          DSProtocol.TCPIP)
      else if LResponse.StartsWith(cCommandSetHTTPPort) then
        SetPort(LModule, LResponse.Replace(cCommandSetHTTPPort, '').Trim,
          DSProtocol.HTTP)
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
    LModule.free;
  end;
end;

end.
