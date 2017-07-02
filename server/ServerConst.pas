unit ServerConst;

interface

resourcestring
  sPortInUse = '- Error: Port %s already in use';
  sPortSet = '- Port set to %s';
  sPortNotSet = '- Port could not be set';
  sServerRunning = '- The Server is already running';
  sStartingServer = '- Starting Server';
  sServerIsRunning = '- Server Running';
  sStoppingServer = '- Stopping Server';
  sServerStopped = '- Server Stopped';
  sServerNotRunning = '- The Server is not running';
  sInvalidCommand = '- Error: Invalid Command';
  sIndyVersion = '- Indy Version: ';
  sActive = '- Active: ';
  sTCPIPPort = '- TCP/IP Port: ';
  sHTTPPort = '- HTTP Port: ';
  sHTTPSPort = '- HTTPS Port: ';
  sSessionID = '- Session ID CookieName: ';
  sCommands = 'Enter a Command: ' + slineBreak +
    '   - "start" to start the server'+ slineBreak +
    '   - "stop" to stop the server'+ slineBreak +
    '   - "set port -t" to change the TCP/IP default port'+ slineBreak +
    '   - "set port -h" to change the HTTP default port'+ slineBreak +
    '   - "set port -s" to change the HTTPS default port'+ slineBreak +
    '   - "status" for Server status'+ slineBreak +
    '   - "help" to show commands'+ slineBreak +
    '   - "exit" to close the application';

const
  cArrow = '->';
  cCommandStart = 'start';
  cCommandStop = 'stop';
  cCommandStatus = 'status';
  cCommandHelp = 'help';
  cCommandSetTCPIPPort = 'set port -t';
  cCommandSetHTTPPort = 'set port -h';
  cCommandSetHTTPSPort = 'set port -s';
  cCommandExit = 'exit';

{$SCOPEDENUMS ON}

type
  DSProtocol = (TCPIP, HTTP, HTTPS);

{$SCOPEDENUMS OFF}

implementation

end.


