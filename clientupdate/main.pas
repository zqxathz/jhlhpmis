unit main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
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
  IdHash;

type
  TupdateForm = class(TForm)
    Memo1: TMemo;
    NetHTTPClient1: TNetHTTPClient;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    procedure NetHTTPClient1ReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var Abort: Boolean);
    procedure NetHTTPClient1RequestCompleted(const Sender: TObject; const AResponse: IHTTPResponse);
    procedure NetHTTPClient1RequestError(const Sender: TObject; const AError: string);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FCountsize, FCurrpos: int64;
    FIndex: integer;
    ms: TMemoryStream;
    procedure Getfile;
  public
    { Public declarations }
    updateJson: TJsonObject;
    function CanShow:boolean;
  end;

type
 TMD5 = class(TIdHashMessageDigest5);

var
  updateForm: TupdateForm;

const
  TempPath = 'updatetemp\';

implementation

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

function TupdateForm.CanShow:boolean;
var
  i: integer;
  fs:TFileStream;
  filename,jsonname:string;
  cpath,filemd5:string;
begin
  Result:=false;
  Fcountsize := 0;
  FCurrpos := 0;
  FIndex := 0;
  for i := updateJson.Count - 1 downto  0 do
  begin
    if updateJson.Pairs[i].JsonString.Value.ToLower <> 'result' then
    begin
      if TJsonArray(updateJson.Pairs[i].JsonValue).Items[1].Value<>'' then
           cpath:=TJsonArray(updateJson.Pairs[i].JsonValue).Items[1].Value+'/'
        else
           cpath:='';
        filename:= ExtractFilePath(Application.Exename) + cpath + TJsonArray(updateJson.Pairs[i].JsonValue).Items[0].Value;
        if FileExists(filename) then
        begin
          fs := TFileStream.Create(filename, fmopenread);
          filemd5:=StreamToMD5(fs);
          fs.Free;

          if TJsonArray(updateJson.Pairs[i].JsonValue).Items[3].Value = filemd5 then
          begin
            jsonname:=updateJson.Pairs[i].JsonString.Value;
            updateJson.RemovePair(jsonname);
          end
          else Fcountsize := Fcountsize + strtoint(TJsonArray(updateJson.Pairs[i].JsonValue).Items[2].Value);
        end
        else Fcountsize := Fcountsize + strtoint(TJsonArray(updateJson.Pairs[i].JsonValue).Items[2].Value);
    end;
  end;

  Result:= FCountsize>0;

  //ExtractFilePath(Application.Exename)+TempPath
end;

procedure TupdateForm.FormShow(Sender: TObject);
begin
  label1.Caption := (inttostr(Fcountsize));
   //ProgressBar1.Max:=FCountsize;
  Getfile;
end;

procedure TupdateForm.Getfile;
var
  path: string;
begin
  if updateJson.Pairs[FIndex].JsonString.Value.ToLower = 'result' then
  begin
    exit;
  end;
  if TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[1].Value <> '' then
    path := TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[1].Value + '/'
  else
    path := '';
  Memo1.Lines.Add('http://update.jhlotus.com/' + path + TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[0].Value);
  ms := TMemoryStream.Create;
  NetHTTPClient1.Get('http://update.jhlotus.com/' + path + TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[0].Value, ms);
end;

procedure TupdateForm.NetHTTPClient1ReceiveData(const Sender: TObject; AContentLength, AReadCount: Int64; var Abort: Boolean);
var
  count: int64;
begin
  count := FCurrpos + AReadCount;
  ProgressBar1.Position := round(count / Fcountsize * 100);
  Label2.Caption := count.ToString;
  if AContentLength = AReadCount then
    FCurrpos := FCurrpos + AReadCount;
end;

procedure TupdateForm.NetHTTPClient1RequestCompleted(const Sender: TObject; const AResponse: IHTTPResponse);
begin
  ms.SaveToFile(ExtractFilePath(Application.Exename) + TempPath + TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[1].Value + '\' + TJsonArray(updateJson.Pairs[FIndex].JsonValue).Items[0].Value);
  ms.Free;
  inc(FIndex);
  Getfile;
end;

procedure TupdateForm.NetHTTPClient1RequestError(const Sender: TObject; const AError: string);
begin
  Memo1.Lines.Add(AError);
end;

end.

