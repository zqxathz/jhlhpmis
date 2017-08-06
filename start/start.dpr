program start;



uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  Vcl.Dialogs,
  Winapi.Windows,
  Winapi.Messages,
  System.SyncObjs,
  main in 'main.pas' {mainform},
  login in 'login.pas' {loginframe: TFrame},
  logindm in 'logindm.pas' {logindatamod: TDataModule},
  staticstr in '..\common\staticstr.pas',
  connectiondm in '..\connection\connectiondm.pas' {connectionDataModule: TDataModule};

{$R *.res}

var
  hAppMutex: TMutex; //声明互斥变量
  RvHandle :hWnd;

begin

{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := true;//DebugHook>0;
{$ENDIF}
  hAppMutex := TMutex.Create(nil,false,'{FF3C45DC-0348-4E16-A861-F1AD8E693075}');
  //if  hAppMutex.WaitFor(1)=wrTimeout then exit;
  if GetLastError<>183 then
  begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.Title := '京湖青莲展览';
    TStyleManager.TrySetStyle('Metropolis UI Blue');
    Application.CreateForm(Tmainform, mainform);
  Application.CreateForm(TconnectionDataModule, connectionDataModule);
  Application.CreateForm(Tlogindatamod, logindatamod);
  Application.Run;
  end
  else
  begin
    RvHandle:= FindWindow('Tmainform','京湖青莲展览');
    if RvHandle<>0 then
    begin
      SendMessage(RvHandle, WM_SYSCOMMAND, SC_RESTORE, 0);
      SetWindowPos(RvHandle,HWND_TOPMOST,0,0,0,0,SWP_NOSIZE OR SWP_NOMOVE);
      SetWindowPos(RvHandle,HWND_NOTOPMOST,0,0,0,0,SWP_NOSIZE OR SWP_NOMOVE);
      SetForegroundWindow(RvHandle);
     // SetActiveWindow(RvHandle);
//      SendMessage(RvHandle, WM_LBUTTONDOWN, 0, MAKELPARAM(0, 0));
//      SendMessage(RvHandle, WM_LBUTTONUP, 0, MAKELPARAM(0, 0));
    end;

  end;
  hAppMutex.Free;
end.
