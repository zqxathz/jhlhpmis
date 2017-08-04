unit Alidayu;

interface

uses System.Classes, System.SysUtils, System.Hash, System.JSON,
  System.Net.HttpClientComponent, System.inifiles;

type
  TAliDayu = class(TObject)
  private
    send_message: string;
    FCfgfilename: String;
  protected
    function MakeSign(const AParams: TStringList;
      const AppSecret: string): string;
    function SendSMS(const AppKey, AppSecret, ReceiveNumber, FreeSignName,
      TemplateCode, TemplateContent: string; var ResultMsg: string)
      : Boolean; overload;
    function LoadParams: TStringList;
  public
    property Cfgfilename: String read FCfgfilename write FCfgfilename;
    function SendSMS: Boolean; overload;
    constructor Create(const filename: string = ''); virtual;
    procedure Test;
  end;

implementation

{ TAliDayu }

constructor TAliDayu.Create(const filename: string = '');
begin
  if filename = '' then
    FCfgfilename := './alidayu.cfg'
  else
    FCfgfilename := filename;
end;

function TAliDayu.LoadParams: TStringList;
var
  inifile: Tinifile;
begin
  inifile := Tinifile.Create(FCfgfilename);
  inifile.ReadSectionValues('config', Result);
  inifile.Free;
end;

// 签名算法

function TAliDayu.MakeSign(const AParams: TStringList;
  const AppSecret: string): string;
var
  I: Integer;
  Data: string;
begin
  // 参数排序
  AParams.Sort;
  // 参数拼接
  Data := '';
  for I := 0 to AParams.Count - 1 do
    Data := Data + AParams[I].Replace('=', '');

  // HMAC 算法
  Result := THashMD5.GetHMAC(Data, AppSecret).ToUpper;
end;

function TAliDayu.SendSMS(const AppKey, AppSecret, ReceiveNumber, FreeSignName,
  TemplateCode, TemplateContent: string; var ResultMsg: string): Boolean;
var
  HTTP: TNetHTTPClient;
  JO: TJSONObject;
  Params: TStringList;
  Response: string;
begin
  Result := False;

  HTTP := TNetHTTPClient.Create(nil);
  Params := TStringList.Create();
  try
    Params.Values['app_key'] := AppKey;
    Params.Values['format'] := 'json';
    Params.Values['method'] := 'alibaba.aliqin.fc.sms.num.send';
    Params.Values['sign_method'] := 'hmac';
    Params.Values['timestamp'] := FormatDateTime('yyyy-MM-dd HH:mm:ss', Now);
    Params.Values['v'] := '2.0';
    Params.Values['sms_type'] := 'normal';
    Params.Values['sms_free_sign_name'] := FreeSignName;
    Params.Values['rec_num'] := ReceiveNumber;
    Params.Values['sms_template_code'] := TemplateCode;
    Params.Values['sms_param'] := TemplateContent;
    Params.Values['sign'] := MakeSign(Params, AppSecret);

    HTTP.ContentType := 'application/x-www-form-urlencoded';
    try
      Response := HTTP.Post('https://eco.taobao.com/router/rest', Params)
        .ContentAsString();
    except
      on E: Exception do
      begin
        ResultMsg := E.Message;
        Exit;
      end;
    end;

    JO := TJSONObject.ParseJSONValue(Response) as TJSONObject;
    try
      if JO <> nil then
      begin
        if JO.TryGetValue<string>
          ('alibaba_aliqin_fc_sms_num_send_response.result.success', ResultMsg)
        then
          Result := ResultMsg.ToUpper = 'TRUE'
        else if JO.TryGetValue<string>('error_response.msg', ResultMsg) then
          Result := False;
      end;
    finally
      JO.Free;
    end;
  finally
    HTTP.Free;
    Params.Free;
  end;
end;

function TAliDayu.SendSMS: Boolean;
var
  list: TStringList;
  app_key, app_secret, rec_num, sms_free_sign_name, sms_template_code,
    sms_param: string;
begin
  Result := False;
  list := TStringList.Create;
  list := LoadParams;
  try
    if list.Values['app_key'] = '' then
      app_key := '24537550'
    else
      app_key := list.Values['app_key'];

    if list.Values['app_secret'] = '' then
      app_secret := '249cc7372a19a8ea9e7694d04b677c5c'
    else
      app_secret := list.Values['app_secret'];

    if list.Values['rec_num'] = '' then
      rec_num := '18606829855'
    else
      rec_num := list.Values['rec_num'];

    if list.Values['sms_free_sign_name'] = '' then
      sms_free_sign_name := '青莲展览'
    else
      sms_free_sign_name := list.Values['sms_free_sign_name'];

    if list.Values['sms_template_code'] = '' then
      sms_template_code := 'SMS_76460043'
    else
      sms_template_code := list.Values['sms_template_code'];

    sms_param := list.Values['sms_param'];

    if list.Values['enable'] = '1' then
      Result := SendSMS(app_key, app_secret, rec_num, sms_free_sign_name,
        sms_template_code, sms_param, send_message);
    // Result:=SendSMS('24537550','249cc7372a19a8ea9e7694d04b677c5c','18606829855','青莲展览','SMS_76460043','',send_message);
  finally
    list.Free;
  end;
end;

// 用于测试读取配置文件的方法
procedure TAliDayu.Test;
var
  list: TStringList;
  I: Integer;
begin
  list := TStringList.Create;
  list := LoadParams;
  for I := 0 to list.Count - 1 do
  begin
    write(list.KeyNames[I]);
    Writeln(list.Values[list.KeyNames[I]]);
  end;
  list.Free;
end;

end.
