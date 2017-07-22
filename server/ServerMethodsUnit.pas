unit ServerMethodsUnit;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Json,
  DataSnap.DSProviderDataModuleAdapter,
  DataSnap.DSServer,
  DataSnap.DSAuth,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.ConsoleUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Stan.StorageBin,
  FireDAC.Comp.DataSet,
  System.Generics.Collections,
  System.Variants,
  IdHashMessageDigest,
  IdGlobal,
  IdHash,
  System.IOUtils,
  System.Types;

type
  TServerLog = class(TFileStream)
  public
    procedure SaveLog(msg: string);
  end;

  TServerLogThread = class(TThread)
  private
    FLogList: TStringList;
  protected
    procedure Execute; override;
  public
    constructor Create; overload;
    destructor Destroy; override;
    procedure AddLog(msg: string);
  end;

  TServerMethods = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    expoFDQuery: TFDQuery;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    customertypeFDQuery: TFDQuery;
    paytypeFDQuery: TFDQuery;
    expotypeFDQuery: TFDQuery;
    shoppersourceFDQuery: TFDQuery;
    customerFDQuery: TFDQuery;
    shopperFDQuery: TFDQuery;
    ShopperRemoveFDCommand: TFDCommand;
    memberFDQuery: TFDQuery;
    CustomerRemoveFDCommand: TFDCommand;
    expireExpoFDQuery: TFDQuery;
    getcustomerFDQuery: TFDQuery;
    procedure customerFDQueryUpdateError(ASender: TDataSet; AException: EFDException; ARow: TFDDatSRow; ARequest: TFDUpdateRequest; var AAction: TFDErrorAction);
  private
      { Private declarations }
    FErrorsList: TJSONObject;
    function GenerateErrorMessage: string;
  public
      { Public declarations }
      // Delhpi自己生成的例子方法
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
      // 获取服务器数据的方法
    function ExpoData(username: string; password: string): TStream;
    function CustomertypeData(username: string; password: string): TStream;
    function PaytypeData(username: string; password: string): TStream;
    function ExpoTypeData(username: string; password: string): TStream;
    function ShopperSourceData(username: string; password: string): TStream;
    function MemberData: TStream;
    function CustomerData(memberid: integer = 0): TStream;
      // 上传数据到服务器的方法
    function CustomerDataPost(AStream: TStream): string;
    function ShopperDataPost(AStream: TStream): string;
    function UseExpoIds: string;
    function ExpireExpoIds: string;
    //软件更新用
    function GetUpdatefiles: string;
      //测试用的
    function test1: integer;
  end;

type
  TMD5 = class(TIdHashMessageDigest5);

const
  LogFilename = './server.log';

var
  One: Tobject;
  log: TServerLogThread;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

uses
  System.StrUtils,
  System.DateUtils,
  Alidayu;

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

// 复制流到内存流
function CopyStream(const AStream: TStream): TMemoryStream;
var
  LBuffer: TBytes;
  LCount: integer;
begin
  Result := TMemoryStream.Create;
  try
    SetLength(LBuffer, 1024 * 32);
    while True do
    begin
      LCount := AStream.Read(LBuffer, Length(LBuffer));
      Result.Write(LBuffer, LCount);
      if LCount < Length(LBuffer) then
        break;
    end;
  except
    Result.Free;
    writeln('copystream error');
    raise;
  end;
end;

// Shopper数据提交处理方法
function TServerMethods.ShopperDataPost(AStream: TStream): string;
var
  LMemStream: TMemoryStream;
  LErrors: integer;
  count: int64;
  starttime, endtime: TDateTime;
  Dayu: TAlidayu;
  send_message: string;
begin
  if AStream.Size = 0 then
    exit;

  log := TServerLogThread.Create;

  Log.AddLog('Start append shopper data');

  FErrorsList := TJSONObject.Create;
  LMemStream := CopyStream(AStream);
  Log.AddLog('stream size:' + LMemStream.Size.ToString); // LOG 流的大小
  LMemStream.Position := 0;
  try
    shopperFDQuery.Close;
    shopperFDQuery.LoadFromStream(LMemStream, TFDStorageFormat.sfBinary);
    Log.AddLog('record count:' + shopperFDQuery.RecordCount.ToString);
    // LOG 本次更新的记录数

    starttime := now();
    FDConnection1.StartTransaction;
    LErrors := shopperFDQuery.ApplyUpdates;
    if LErrors <> 0 then // 一旦有出错就回滚
      FDConnection1.Rollback
    else
    begin
      try
        //ShopperRemoveFDCommand.Execute;
        FDConnection1.Commit;
      except
        FDConnection1.Rollback;
        raise;
      end;
    end;
    endtime := now();
    count := MilliSecondsBetween(endtime, starttime);

    Log.AddLog('time count:' + count.ToString); // LOG插入数据用时
  finally
    customerFDQuery.Close;
    LMemStream.Free;
    FDConnection1.Close;
    if LErrors <> 0 then
    begin
      Result := FErrorsList.ToJSON; // 返回出错数据
      Log.AddLog('error message:' + Result); // Log出错数据
    end;
    Log.AddLog('------------------------');
    FErrorsList.Free; // 释放Josn对象
    //FreeAndNil(Log); // 关闭Log文件
    log.Start;
  end;
  // 通过阿里大于发送短信给管理员
  Dayu := TAlidayu.Create;
  try
    Dayu.SendSMS;
  finally
    Dayu.Free;
  end;
end;

{ -------------------------------------------------------------------------------
  过程名:    TServerMethods.CustomerDataPost
  作者:      Vine
  日期:      2017.07.06
  参数:      AStream: TStream
  返回值:    string (JSON)
  ------------------------------------------------------------------------------- }
function TServerMethods.CustomerDataPost(AStream: TStream): string;
var
  LMemStream: TMemoryStream;
  LErrors: integer;
  count: int64;
  starttime, endtime: TDateTime;
  Dayu: TAlidayu;
  send_message: string;
begin
  if AStream.Size = 0 then
    exit;

  Result := '';

  log := TServerLogThread.Create;

  Log.AddLog('Start append customer data');
  FErrorsList := TJSONObject.Create; // 创建一个JsonObject用来更新出错记录的数据
  LMemStream := CopyStream(AStream); // 将Stream转换成内存流
  Log.AddLog('stream size:' + LMemStream.Size.ToString); // LOG 流的大小
  LMemStream.Position := 0;
  try
    customerFDQuery.Close;
    customerFDQuery.LoadFromStream(LMemStream, TFDStorageFormat.sfBinary);
    // Query组件加载流
    Log.AddLog('record count:' + customerFDQuery.RecordCount.ToString);
    // LOG 本次更新的记录数
    starttime := now(); // 当前时间
    FDConnection1.StartTransaction; // 开始事务
    LErrors := customerFDQuery.ApplyUpdates; // 提交数据
    if LErrors <> 0 then
      FDConnection1.Rollback // 出错就回滚
    else
    begin
      try
        CustomerRemoveFDCommand.Execute(); // 删除重复的老记录
        FDConnection1.Commit; // 无错提交事务
      except
        FDConnection1.Rollback;
        raise;
      end;
    end;
    endtime := now(); // 当前时间
    count := MilliSecondsBetween(endtime, starttime); // 计算插入数据耗时
    Log.AddLog('time count:' + count.ToString); // LOG插入数据用时
  finally
    customerFDQuery.Close; // 关闭Query组件
    LMemStream.Free; // 释放内存流
    FDConnection1.Close; // 关闭数据库连接
    if LErrors > 0 then // 出错返回错误数据
    begin
      Result := FErrorsList.ToJSON;
      Log.AddLog('error message:' + Result); // Log出错数据
    end;
    Log.AddLog('------------------------'); // Log文件分割线
    FErrorsList.Free; // 释放Josn对象
    //FreeAndNil(Log); // 关闭Log文件
    Log.Start;
  end;
  // 通过阿里大于发送短信给管理员
  Dayu := TAlidayu.Create;
  try
    Dayu.SendSMS;
  finally
    Dayu.Free;
  end;
end;

procedure TServerMethods.customerFDQueryUpdateError(ASender: TDataSet; AException: EFDException; ARow: TFDDatSRow; ARequest: TFDUpdateRequest; var AAction: TFDErrorAction);
var
  LDataStr: string;
begin
  if AException.FDCode <> 1100 then
  begin
    try
      try
        if not VarIsNull(ARow.GetData('id')) then
          LDataStr := ARow.GetData('id');
        FErrorsList.AddPair(AException.Message + ',' + AException.FDCode.ToString, LDataStr);
      except

      end;
    finally

    end;
  end
  else
  begin
    AAction := eaSkip;
  end;
end;

function TServerMethods.GenerateErrorMessage: string;
begin
  //
end;

function TServerMethods.GetUpdatefiles: string;
var
  json:TJsonObject;
  function Getfiles(const path:string):TJsonObject;
  var
   s:TStringDynArray;
   i,j: Integer;
   jsonarray:TJsonArray;
   ext,version:string;
   jsonobject:TJsonObject;
   filesen: TFileStream;
   str: string;
  begin
    Result:=TJSONObject.Create;
    s:=TDirectory.GetFileSystemEntries(path);
    for i := 0 to length(s)-1 do
    begin
      if TFileAttribute.faDirectory in TPath.GetAttributes(s[i]) then
      begin
        jsonobject:=Getfiles(s[i]);
        for j := 0 to jsonobject.Count-1 do
        begin
          Result.AddPair(jsonobject.Pairs[j]);
          jsonobject.Free;
        end;
      end
      else
      begin
       ext:=TPath.GetExtension(s[i]);
       if (ext.ToLower ='.exe') or (ext.ToLower ='.dll') or (ext.ToLower ='.bpl') then
       begin
         jsonarray:=TJSONArray.Create;

         //filesen := TFileStream.Create(s[i], fmopenread or fmshareExclusive);
         filesen := TFileStream.Create(s[i], fmopenread);
         jsonarray.AddElement(TJSONString.Create(TPath.GetFileName(s[i])));
         jsonarray.AddElement(TJSONNumber.Create(filesen.Size));
         jsonarray.AddElement(TJSONString.Create(StreamToMD5(filesen)));
         Result.AddPair(s[i],jsonarray);
         jsonarray.Free;
       end;
      end;
    end;
  end;
begin
  json:=Getfiles('/www/wwwroot/update.jhlotus.com/');
  Result:=json.ToJSON;
  json.Free;
end;

function TServerMethods.CustomerData(memberid: integer = 0): TStream;
begin
  Result := TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      getcustomerFDQuery.Close;
      getcustomerFDQuery.Params.Items[0].AsInteger := memberid;
      getcustomerFDQuery.Open;
      getcustomerFDQuery.SaveToStream(Result, TFDStorageFormat.sfBinary);
      Result.Position := 0;
    except
      on E: Exception do
      begin
        writeln(E.Message);
        Result.Free;
      end;
    end;
  finally
    getcustomerFDQuery.Close;
    FDConnection1.Close;
  end;
end;

function TServerMethods.MemberData: TStream;
begin
  Result := TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      memberFDQuery.Close;
      memberFDQuery.Open;
      memberFDQuery.SaveToStream(Result, TFDStorageFormat.sfBinary);
      Result.Position := 0;
    except
      on E: Exception do
      begin
        writeln(E.Message);
        Result.Free;
      end;
    end;
  finally
    memberFDQuery.Close;
    FDConnection1.Close;
  end;
end;

function TServerMethods.CustomertypeData(username, password: string): TStream;
begin
  Result := TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      customertypeFDQuery.Close;
      customertypeFDQuery.Open;
      customertypeFDQuery.SaveToStream(Result, TFDStorageFormat.sfBinary);
      Result.Position := 0;
    except
      on E: Exception do
      begin
        writeln(E.Message);
        Result.Free;
      end;
    end;
  finally
    customertypeFDQuery.Close;
    FDConnection1.Close;
  end;
end;

function TServerMethods.EchoString(Value: string): string;
begin
  exit;
  Result := Value;
end;

function TServerMethods.ExpoData(username, password: string): TStream;
begin
  Result := TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      expoFDQuery.Close;
      expoFDQuery.Open;
      expoFDQuery.SaveToStream(Result, TFDStorageFormat.sfBinary);
      Result.Position := 0;
    except
      on E: Exception do
      begin
        writeln(E.Message);
        Result.Free;
      end;
    end;
  finally
    expoFDQuery.Close;
    FDConnection1.Close;
  end;
end;

function TServerMethods.ExpoTypeData(username, password: string): TStream;
begin
  Result := TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      expotypeFDQuery.Close;
      expotypeFDQuery.Open;
      expotypeFDQuery.SaveToStream(Result, TFDStorageFormat.sfBinary);
      Result.Position := 0;
    except
      on E: Exception do
      begin
        writeln(E.Message);
        Result.Free;
      end;
    end;
  finally
    expotypeFDQuery.Close;
    FDConnection1.Close;
  end;
end;

function TServerMethods.PaytypeData(username, password: string): TStream;
begin
  Result := TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      paytypeFDQuery.Close;
      paytypeFDQuery.Open;
      paytypeFDQuery.SaveToStream(Result, TFDStorageFormat.sfBinary);
      Result.Position := 0;
    except
      on E: Exception do
      begin
        writeln(E.Message);
        Result.Free;
      end;
    end;
  finally
    paytypeFDQuery.Close;
    FDConnection1.Close;
  end;
end;

function TServerMethods.ShopperSourceData(username, password: string): TStream;
begin
  Result := TMemoryStream.Create;
  try
    try
      FDConnection1.Open;
      shoppersourceFDQuery.Close;
      shoppersourceFDQuery.Open;
      shoppersourceFDQuery.SaveToStream(Result, TFDStorageFormat.sfBinary);
      Result.Position := 0;
    except
      on E: Exception do
      begin
        writeln(E.Message);
        Result.Free;
      end;
    end;
  finally
    shoppersourceFDQuery.Close;
    FDConnection1.Close;
  end;

end;

function TServerMethods.test1: integer;
begin
  {$IFDEF DEBUG}
  {$ENDIF}
end;

function TServerMethods.UseExpoIds: string;
begin
  Result := '';
  FDConnection1.Open;
  expoFDQuery.Open;
  try
    if expoFDQuery.RecordCount > 0 then
    begin
      expoFDQuery.First;
      while not expoFDQuery.Eof do
      begin
        Result := Result + ',' + expoFDQuery.FieldByName('id').AsString;
        expoFDQuery.Next;
      end;
      delete(result, 1, 1);
    end
  finally
    expoFDQuery.Close;
    FDConnection1.Close;
  end;
end;

function TServerMethods.ExpireExpoIds: string;
begin
  Result := '';
  FDConnection1.Open;
  expireExpoFDQuery.Open;
  try
    if expireExpoFDQuery.RecordCount > 0 then
    begin
      expireExpoFDQuery.First;
      while not expireExpoFDQuery.Eof do
      begin
        Result := Result + ',' + expireExpoFDQuery.FieldByName('id').AsString;
        expireExpoFDQuery.Next;
      end;
      delete(result, 1, 1);
    end
  finally
    expireExpoFDQuery.Close;
    FDConnection1.Close;
  end;
end;

function TServerMethods.ReverseString(Value: string): string;
begin
  exit;
  Result := System.StrUtils.ReverseString(Value);
end;

{ TServerLog }

procedure TServerLog.SaveLog(msg: string);
var
  len: cardinal;
  time: TDateTime;
  timestr: string;
  oString: UTF8String;
begin
  timestr := '';
  Seek(0, soEnd);
  if msg[1] <> '-' then
  begin
    time := now();
    timestr := FormatDateTime('--yyyy-mm-dd hh:nn:ss--', time);
  end;
  oString := UTF8String(timestr + msg + #13#10);
  len := Length(oString);
  if len > 0 then
    self.WriteBuffer(oString[1], len);
end;

{ TServerLogThread }

procedure TServerLogThread.AddLog(msg: string);
begin
  if Assigned(FLogList) then
  begin
    FLogList.Add(msg);
  end;
end;

constructor TServerLogThread.Create;
begin
  FLogList := TStringList.Create;
  Create(True);
end;

destructor TServerLogThread.Destroy;
begin
  if Assigned(FLogList) then
    FLogList.Free;
  inherited;
end;

procedure TServerLogThread.Execute;
var
  Log: TServerLog;
  I: Integer;
begin
  //inherited;
  FreeOnTerminate := true;
  system.TMonitor.Enter(One);
  try
    if FLogList.Count = 0 then
      exit;
    if not FileExists(LogFilename) then // 创建或者打开LOG文件
      Log := TServerLog.Create(LogFilename, fmCreate)
    else
      Log := TServerLog.Create(LogFilename, fmOpenWrite);

    for I := 0 to FLogList.Count - 1 do
    begin
      Log.SaveLog(FLogList.Strings[I]);
    end;
  finally
    FLogList.Clear;
    FreeAndNil(Log);
    system.TMonitor.Exit(One);
  end;
end;

end.

