unit main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShellAPI,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.IOUtils,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  System.Json,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  Vcl.ComCtrls,
  IdHashMessageDigest,
  IdGlobal,
  IdHash,
  Vcl.ExtCtrls,
  setting;

type
  TupdateForm = class(TForm)
    Memo1: TMemo;
    NetHTTPClient1: TNetHTTPClient;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Timer1: TTimer;
    Label2: TLabel;
    procedure NetHTTPClient1ReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var Abort: Boolean);
    procedure NetHTTPClient1RequestCompleted(const Sender: TObject; const AResponse: IHTTPResponse);
    procedure NetHTTPClient1RequestError(const Sender: TObject; const AError: string);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure NetHTTPClient1AuthEvent(const Sender: TObject; AnAuthTarget: TAuthTargetType;
      const ARealm, AURL: string; var AUserName, APassword: string; var AbortAuth: Boolean;
      var Persistence: TAuthPersistenceType);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FCountsize, FCurrpos, FPrvpos: int64;
    FIndex: integer;
    ms: TMemoryStream;
    count: int64;
    thread:TThread;
    running:boolean;
    procedure Getfile;
    procedure copyFiles;
    procedure threadOnTerminate(Sender: TObject);
  public
    { Public declarations }
    updateJson: TJsonObject;
    function CanShow: boolean;
  end;

type
  TMD5 = class(TIdHashMessageDigest5);

var
  updateForm: TupdateForm;


implementation

uses common;

{$R *.dfm}

function StreamToMD5(s: TFileStream): string;
var
  MD5Encode: TMD5;
  long: TIdBytes;
begin
  MD5Encode := TMD5.Create;
  try
    long := MD5Encode.NativeGetHashBytes(s, s.Size);
    result := MD5Encode.HashToHex(long);
  finally
    MD5Encode.Free;
  end;
end;


function TupdateForm.CanShow: boolean;
var
  i: integer;
  fs: TFileStream;
  filename, jsonname: string;
  cpath, filemd5: string;
begin
  Result := false;
  Fcountsize := 0;
  FCurrpos := 0;
  FIndex := 0;
  for i := updateJson.Count - 1 downto 0 do
  begin
    if updateJson.Pairs[i].JsonString.Value.ToLower <> 'result' then
    begin
      cpath := TJsonArray(updateJson.Pairs[i].JsonValue).Items[1].Value;
      filename := ExtractFilePath(Application.Exename) + cpath + TJsonArray(updateJson.Pairs[i].JsonValue).Items[0].Value;
      if FileExists(filename) then
      begin
        fs := TFileStream.Create(filename, fmopenread);
        filemd5 := StreamToMD5(fs);
        fs.Free;
        if TJsonArray(updateJson.Pairs[i].JsonValue).Items[3].Value = filemd5 then
        begin
          jsonname := updateJson.Pairs[i].JsonString.Value;
          updateJson.RemovePair(jsonname);
        end
        else
          Fcountsize := Fcountsize + strtoint(TJsonArray(updateJson.Pairs[i].JsonValue).Items[2].Value);
      end
      else
        Fcountsize := Fcountsize + strtoint(TJsonArray(updateJson.Pairs[i].JsonValue).Items[2].Value);
    end;
  end;
  Result := FCountsize > 0;
end;

procedure TupdateForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=false;
  if running then
  begin
    if Application.MessageBox('更新正在进行中,是否要退出更新?', '询问', MB_OKCANCEL +
      MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDOK then CanClose:=True;
  end
  else
  begin
    CanClose:=True;
  end;
end;

procedure TupdateForm.FormShow(Sender: TObject);
begin
  Timer1.Enabled := true;
  Memo1.Lines.Text:='开始更新';
  running:=true;
  Getfile;
end;

procedure TupdateForm.threadOnTerminate(Sender: TObject);
begin
  Application.MessageBox('更新完成,点击确定重启软件.', '提示', MB_OK + MB_ICONINFORMATION +MB_TOPMOST);
  running:=false;
  shellexecute(Handle, 'open', PChar('start.exe'), nil, nil, SW_SHOW);
  Close;
end;

procedure TupdateForm.copyFiles;
var
  i: integer;
  sourcefilename, destfilename, destdirectory: string;
begin
  running:=true;
  for i := 0 to updateJson.Count - 1 do
  begin
    if updateJson.Pairs[i].JsonString.Value.ToLower = 'result' then
      Continue;

    ProgressBar1.Position := i + 1;
    Label2.Caption:= inttostr(i+1)+'/' + inttostr(updateJson.Count - 1);
    sourcefilename := ExtractFilePath(Application.ExeName) + TempPath + TJsonArray(updateJson.Pairs[i].JsonValue).Items[1].Value + TJsonArray(updateJson.Pairs[i].JsonValue).Items[0].Value;
    destfilename := ExtractFilePath(Application.ExeName) + TJsonArray(updateJson.Pairs[i].JsonValue).Items[1].Value + TJsonArray(updateJson.Pairs[i].JsonValue).Items[0].Value;
    if FileExists(sourcefilename) then
    begin
      destdirectory := ExtractFilePath(Application.ExeName) + TJsonArray(updateJson.Pairs[i].JsonValue).Items[1].Value;
      if not TDirectory.Exists(destdirectory) then
        TDirectory.CreateDirectory(destdirectory);
      try
        Tfile.Copy(sourcefilename, destfilename, true);
      except
        try
          if FileExists(destfilename+'.tmp') then
            if DeleteFile(destfilename+'.tmp') then
              RenameFile(destfilename,destfilename+'.tmp')
            else
              Memo1.Lines.Add('删除临时文件出错:'+destfilename+'.tmp')
          else
            RenameFile(destfilename,destfilename+'.tmp');
          Tfile.Copy(sourcefilename, destfilename, true);
        except
          Memo1.Lines.Add('复制文件出错:'+destfilename);
        end;
      end;
    end;
  end;
end;

procedure TupdateForm.Getfile;
var
  path, filename, filemd5: string;
  fs: TFilestream;
  url:string;
begin
  if updateJson.Pairs[FIndex].JsonString.Value.ToLower = 'result' then
  begin
    Timer1.Enabled:=false;
    Label1.Caption := '复制文件:';
    ProgressBar1.Max := updateJson.Count - 1;
    thread:=TThread.CreateAnonymousThread(copyFiles);
    thread.FreeOnTerminate:=true;
    thread.OnTerminate:=threadOnTerminate;
    thread.Start;
    exit;
  end;

  path := TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[1].Value;
  filename := ExtractFilePath(Application.Exename) + TempPath + path + TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[0].Value;
  if FileExists(filename) then
  begin
    fs := TFileStream.Create(filename, fmopenread);
    filemd5 := StreamToMD5(fs);
    fs.Free;
    if TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[3].Value = filemd5 then
    begin
      FCurrpos := FCurrpos + strtoint(TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[2].Value);
      ProgressBar1.Position := round(FCurrpos / Fcountsize * 100);
      Memo1.Lines.Add('下载文件'+inttostr(Findex+1)+'/'+inttostr(updateJson.Count-1)+':'
                   + TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[0].Value);
      inc(FIndex);
      Getfile;
      exit;
    end;
  end;
  path := path.Replace('\', '/');
  //Memo1.Lines.Add(UpdateUrl + path + TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[0].Value);
  Memo1.Lines.Add('下载文件'+inttostr(Findex+1)+'/'+inttostr(updateJson.Count-1)+':'
                   + TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[0].Value);
  SendMessage(memo1.Handle,WM_VSCROLL,SB_BOTTOM,0);;
  ms := TMemoryStream.Create;
  url:= TSetting.GetValue('Net','updateserver',UpdateUrl);
  if url.LastDelimiter('/')<>url.Length-1 then url:=url+'/';
  NetHTTPClient1.Get(url + path + TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[0].Value, ms);
end;

procedure TupdateForm.NetHTTPClient1AuthEvent(const Sender: TObject; AnAuthTarget: TAuthTargetType;
  const ARealm, AURL: string; var AUserName, APassword: string; var AbortAuth: Boolean;
  var Persistence: TAuthPersistenceType);
begin
  AUserName:='updateuser';
  APassword:='update';
end;

procedure TupdateForm.NetHTTPClient1ReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var Abort: Boolean);
begin
  count := FCurrpos + AReadCount;
  ProgressBar1.Position := round(count / Fcountsize * 100);
  //Label2.Caption := count.ToString;
  if AContentLength = AReadCount then
    FCurrpos := FCurrpos + AReadCount;
end;

procedure TupdateForm.NetHTTPClient1RequestCompleted(const Sender: TObject; const AResponse: IHTTPResponse);
var
  path: string;
begin
  if AResponse.StatusCode<>200 then
  begin
    Memo1.Lines.Add('无法下载文件.code:'+AResponse.StatusCode.ToString);
    running:=false;
    exit;
  end;
  path := ExtractFilePath(Application.Exename) + TempPath + TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[1].Value;
  if Assigned(ms) then
  begin
    if not TDirectory.Exists(path) then
      TDirectory.CreateDirectory(path);
    ms.SaveToFile(path + TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[0].Value);
    ms.Free;
  end;
  inc(FIndex);
  Getfile;
end;

procedure TupdateForm.NetHTTPClient1RequestError(const Sender: TObject; const AError: string);
begin
  running:=false;
  Memo1.Lines.Add(AError);
end;

procedure TupdateForm.Timer1Timer(Sender: TObject);
begin
  Label2.Caption := inttostr((count - FPrvpos) div 1024) + 'KB/s';
  FPrvpos := count;
end;

end.

