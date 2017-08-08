unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.ShellApi, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, login, Vcl.ComCtrls,
  Vcl.Menus, RzTabs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxCustomTileControl, cxClasses, dxTileControl, shopper,
  Vcl.StdCtrls, customer, clientsyc, clientuploadfrm, Vcl.ExtCtrls,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, IdSNTP,common,cxGrid, cxContainer, cxEdit, cxLabel,setting,
  Vcl.AppEvnts,plugin, System.IOUtils, System.Types, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  Tmainform = class(TForm)
    loginframe1: Tloginframe;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    dxTileControl1: TdxTileControl;
    dxTileControl1Group1: TdxTileControlGroup;
    dxTileControl1Item1: TdxTileControlItem;
    dxTileControl1Item2: TdxTileControlItem;
    dxTileControl1Item3: TdxTileControlItem;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    dxTileControl1Group2: TdxTileControlGroup;
    dxTileControl1Item4: TdxTileControlItem;
    dxTileControl1Item5: TdxTileControlItem;
    dxTileControl1Item6: TdxTileControlItem;
    updateTimer: TTimer;
    timesyncTimer: TTimer;
    IdSNTP1: TIdSNTP;
    StaticText1: TStaticText;
    ApplicationEvents1: TApplicationEvents;
    LoadPluginTimer: TTimer;
    FDMemTable1: TFDMemTable;
    FDMemTable1file: TStringField;
    FDMemTable1handle: TIntegerField;
    FDMemTable1name: TStringField;
    FDMemTable1verstion: TStringField;
    FDMemTable1title: TStringField;
    FDMemTable1auther: TStringField;
    FDMemTable1type: TIntegerField;
    FDMemTable1uid: TStringField;
    FDMemTable1classname: TStringField;
    FDMemTable1commit: TStringField;
    FDMemTable1id: TFDAutoIncField;
    procedure loginframe1loginbuttonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dxTileControl1Item1Click(Sender: TdxTileControlItem);
    procedure RzPageControl1Close(Sender: TObject; var AllowClose: Boolean);
    procedure RzPageControl1Change(Sender: TObject);
    procedure RzPageControl1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    procedure dxTileControl1Item2Click(Sender: TdxTileControlItem);
    procedure dxTileControl1Item3Click(Sender: TdxTileControlItem);
    procedure dxTileControl1Item4Click(Sender: TdxTileControlItem);
    procedure dxTileControl1Item5Click(Sender: TdxTileControlItem);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dxTileControl1Item6Click(Sender: TdxTileControlItem);
    procedure updateTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure timesyncTimerTimer(Sender: TObject);
    procedure loginframe1syncmemberButtonClick(Sender: TObject);
    procedure RzPageControl1Changing(Sender: TObject; NewIndex: Integer; var AllowChange: Boolean);
    procedure StaticText1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure LoadPluginTimerTimer(Sender: TObject);
    procedure dxTileControl1ItemDragBegin(Sender: TdxCustomTileControl; AInfo: TdxTileControlDragItemInfo;
      var AAllow: Boolean);
  private
    { Private declarations }
    bplshopperframe: Tbplshopperframe;
    bplshopperframe1: Tbplshopperframe;
    bplcustomerframe: TbplCustomerFrame;
    bplclientsycframe: TclientsycFrame;
    bplclientuploadframe: TbplclientuploadFrame;
    bplsettingframe:Tbplsettingframe;
    tabX, tabY: Integer;
    timesyncrunning:boolean;
    procedure timesync;
    procedure FrameClose(Sender: TObject);
    procedure CreatePage(id:integer);
    procedure PluginItemClick(Sender: TdxTileControlItem);
  public
    { Public declarations }
  end;

var
  mainform: Tmainform;
  firstshow:boolean = true;

implementation

{$R *.dfm}
function GetBuildInfo: string; //获取版本号
var
  verinfosize: DWORD;
  verinfo: pointer;
  vervaluesize: dword;
  vervalue: pvsfixedfileinfo;
  dummy: dword;
  v1, v2, v3, v4: word;
begin

  verinfosize := getfileversioninfosize(pchar(Paramstr(0)), dummy);
  if verinfosize = 0 then
  begin
    dummy := getlasterror;
    result := '0.0.0.0';
  end;
  getmem(verinfo, verinfosize);
  //getfileversioninfo(pchar(paramstr(0)), 0, verinfosize, verinfo);
  getfileversioninfo(pchar('C:\Users\Public\Documents\Embarcadero\Studio\19.0\Bpl\Win64\customer.bpl'), 0, verinfosize, verinfo);
  verqueryvalue(verinfo, '\', pointer(vervalue), vervaluesize);
  with vervalue^ do
  begin
    v1 := dwfileversionms shr 16;
    v2 := dwfileversionms and $ffff;
    v3 := dwfileversionls shr 16;
    v4 := dwfileversionls and $ffff;
  end;
  result := inttostr(v1) + '.' + inttostr(v2) + '.' + inttostr(v3) + '.' + inttostr(v4);
  freemem(verinfo, verinfosize);
end;


procedure Tmainform.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
begin
  if (Msg.message=WM_USER + 100) then
    RzPageControl1.CloseActiveTab;
end;

procedure Tmainform.CreatePage(id:integer);
var
  i: Integer;
  name,uid,classname,title:string;
  menutabsheet: TRzTabSheet;
begin
  if not FDMemTable1.Locate('id',id) then exit;

  name:= FDMemTable1.FieldByName('name').AsString;
  uid:= FDMemTable1.FieldByName('uid').AsString;
  title:= FDMemTable1.FieldByName('title').AsString;
  classname:= FDMemTable1.FieldByName('classname').AsString;

  for i := 0 to RzPageControl1.PageCount - 1 do
  begin
    if RzPageControl1.Pages[i].Name = name+uid then
    begin
      RzPageControl1.ActivePageIndex := i;
      exit;
    end;
  end;

   menutabsheet := TRzTabSheet.Create(RzPageControl1);
   menutabsheet.Caption := title;
   menutabsheet.name:=name+uid;
   menutabsheet.PageControl := RzPageControl1;
   RzPageControl1.ActivePageIndex := menutabsheet.PageIndex;

   with TCustomFrameClass(FindClass(classname)).Create(Self) do
   begin
       Align := alClient;
       Parent := RzPageControl1.ActivePage;
   end;


     // bplshopperframe.Parent := nil;
     //bplshopperframe.List;
end;

procedure Tmainform.PluginItemClick(Sender: TdxTileControlItem);
begin
  CreatePage(Sender.Tag);
end;

procedure Tmainform.dxTileControl1Item1Click(Sender: TdxTileControlItem);
var
  i: Integer;
  menutabsheet: TRzTabSheet;
begin
  for i := 0 to RzPageControl1.PageCount - 1 do
  begin
    if RzPageControl1.Pages[i].Tag = 1 then
    begin
      RzPageControl1.ActivePageIndex := i;
      exit;
    end;
  end;

  menutabsheet := TRzTabSheet.Create(RzPageControl1);
  menutabsheet.Caption := ' '+ dxTileControl1Item1.Text1.Value.Replace(#13,'') +' ';
  menutabsheet.Tag := 1;
  menutabsheet.PageControl := RzPageControl1;
  // if bplshopperframe = nil then
  begin
    bplshopperframe := Tbplshopperframe.Create(menutabsheet);
    bplshopperframe.Name := 'shopperinputer';
    bplshopperframe.inputtype := itnormal;
    bplshopperframe.Align := alClient;
  end;

  RzPageControl1.ActivePageIndex := menutabsheet.PageIndex;
  // bplshopperframe.Parent := nil;
  bplshopperframe.List;
  bplshopperframe.Parent := RzPageControl1.ActivePage;
end;

procedure Tmainform.dxTileControl1Item2Click(Sender: TdxTileControlItem);
var
  i: Integer;
  menutabsheet: TRzTabSheet;
begin
  for i := 0 to RzPageControl1.PageCount - 1 do
  begin
    if RzPageControl1.Pages[i].Tag = 2 then
    begin
      RzPageControl1.ActivePageIndex := i;
      exit;
    end;
  end;
  menutabsheet := TRzTabSheet.Create(RzPageControl1);
   menutabsheet.Caption := ' '+ dxTileControl1Item2.Text1.Value.Replace(#13,'') +' ';
  menutabsheet.Tag := 2;
  menutabsheet.PageControl := RzPageControl1;
  // if bplshopperframe = nil then
  begin
    bplshopperframe1 := Tbplshopperframe.Create(menutabsheet);
    bplshopperframe1.Name := 'shopperinputer1';
    bplshopperframe1.inputtype := itgife;
    bplshopperframe1.Align := alClient;
  end;

  RzPageControl1.ActivePageIndex := menutabsheet.PageIndex;
  // bplshopperframe.Parent := nil;
  bplshopperframe1.Parent := RzPageControl1.ActivePage;
  bplshopperframe1.List;

end;

procedure Tmainform.dxTileControl1Item3Click(Sender: TdxTileControlItem);
var
  i: Integer;
  menutabsheet: TRzTabSheet;
begin
  for i := 0 to RzPageControl1.PageCount - 1 do
  begin
    if RzPageControl1.Pages[i].Tag = 3 then
    begin
      RzPageControl1.ActivePageIndex := i;
      exit;
    end;
  end;

  menutabsheet := TRzTabSheet.Create(RzPageControl1);
  menutabsheet.Caption := ' '+ dxTileControl1Item3.Text1.Value.Replace(#13,'') +' ';
  menutabsheet.Tag := 3;
  menutabsheet.PageControl := RzPageControl1;
  // if bplshopperframe = nil then
  begin
    bplcustomerframe := Tbplcustomerframe.Create(menutabsheet);
    bplcustomerframe.Name := 'customerinputer';
    bplcustomerframe.Align := alClient;
  end;

  RzPageControl1.ActivePageIndex := menutabsheet.PageIndex;
  bplcustomerframe.Parent := RzPageControl1.ActivePage;
  bplcustomerframe.customertypecxComboBox.SetFocus;

end;

procedure Tmainform.dxTileControl1Item4Click(Sender: TdxTileControlItem);
var
  i: Integer;
  menutabsheet: TRzTabSheet;
begin
  for i := 0 to RzPageControl1.PageCount - 1 do
  begin
    if RzPageControl1.Pages[i].Tag = 4 then
    begin
      RzPageControl1.ActivePageIndex := i;
      exit;
    end;
  end;

  menutabsheet := TRzTabSheet.Create(RzPageControl1);
  menutabsheet.Caption := ' 数据同步 ';
  menutabsheet.Tag := 4;
  menutabsheet.PageControl := RzPageControl1;
  // if bplshopperframe = nil then
  begin
    try
      bplclientsycFrame := TclientsycFrame.Create(menutabsheet);
      bplclientsycFrame.Name := 'clientsyc';
      bplclientsycFrame.Align := alClient;

      RzPageControl1.ActivePageIndex := menutabsheet.PageIndex;
      bplclientsycFrame.Parent := RzPageControl1.ActivePage;
    except
      FreeAndNil(menutabsheet);
      if Assigned(bplshopperframe) then
        FreeAndNil(bplclientsycframe);
      raise;
    end;
  end;
end;

procedure Tmainform.dxTileControl1Item5Click(Sender: TdxTileControlItem);
var
  i: Integer;
  menutabsheet: TRzTabSheet;
begin
  for i := 0 to RzPageControl1.PageCount - 1 do
  begin
    if RzPageControl1.Pages[i].Tag = 5 then
    begin
      RzPageControl1.ActivePageIndex := i;
      exit;
    end;
  end;

  menutabsheet := TRzTabSheet.Create(RzPageControl1);
  menutabsheet.Caption := ' 数据上传 ';
  menutabsheet.Tag := 5;
  menutabsheet.PageControl := RzPageControl1;
  // if bplshopperframe = nil then
  begin
    try
      bplclientuploadFrame := TbplclientuploadFrame.Create(menutabsheet);
      bplclientuploadFrame.Name := 'clientupload';
      bplclientuploadFrame.Align := alClient;

      RzPageControl1.ActivePageIndex := menutabsheet.PageIndex;
      bplclientuploadFrame.Parent := RzPageControl1.ActivePage;
    except
      FreeAndNil(menutabsheet);
      if Assigned(bplclientuploadFrame) then
        FreeAndNil(bplclientuploadFrame);
      raise;
    end;
  end;
end;

procedure Tmainform.dxTileControl1Item6Click(Sender: TdxTileControlItem);
var
  i: Integer;
  menutabsheet: TRzTabSheet;
begin
  for i := 0 to RzPageControl1.PageCount - 1 do
  begin
    if RzPageControl1.Pages[i].Tag = 6 then
    begin
      RzPageControl1.ActivePageIndex := i;
      exit;
    end;
  end;

  menutabsheet := TRzTabSheet.Create(RzPageControl1);
  menutabsheet.Caption := ' 软件设置 ';
  menutabsheet.Tag := 6;
  menutabsheet.PageControl := RzPageControl1;
  // if bplshopperframe = nil then
  begin
    try
      bplsettingFrame := Tbplsettingframe.Create(menutabsheet);
      bplsettingFrame.Name := 'setting';
      bplsettingFrame.Align := alClient;

      RzPageControl1.ActivePageIndex := menutabsheet.PageIndex;
      bplsettingFrame.Parent := RzPageControl1.ActivePage;
      bplsettingframe.OnClose:=FrameClose;
    except
      FreeAndNil(menutabsheet);
      if Assigned(bplsettingFrame) then
        FreeAndNil(bplsettingFrame);
      raise;
    end;
  end;
end;

procedure Tmainform.dxTileControl1ItemDragBegin(Sender: TdxCustomTileControl; AInfo: TdxTileControlDragItemInfo;
  var AAllow: Boolean);
begin
  if AInfo.SourceGroup.Index=0 then AAllow:=false;

end;

procedure Tmainform.FrameClose(Sender: TObject);
begin
  RzPageControl1.CloseActiveTab;
end;

procedure Tmainform.LoadPluginTimerTimer(Sender: TObject);
var
 files:TStringDynArray;
 i:integer;
 handle:THandle;
 GetPluginInfo:TGetPluginInfo;
 PluginInfo:TPluginInfo;
begin
  LoadPluginTimer.Enabled:=false;
  //files:=TDirectory.GetFiles(ExtractFilePath(Application.ExeName),'plugin_*.bpl');
 //showmessage( Length(files).ToString);
  files:=['plugin_admin.bpl'];
  if Length(files)>0 then
  begin
    for i:=0 to Length(files)-1 do
    begin
      handle:=LoadPackage(files[i]);
      try
        if handle>0 then
        begin

          @GetPluginInfo := Winapi.Windows.GetProcAddress(handle,PChar('GetPluginInfo'));
          if assigned(GetPluginInfo) then
          begin
             PluginInfo:=GetPluginInfo;
             if PluginInfo.plugtype>0 then
             begin
                FDMemTable1.Append;
                FDMemTable1.FieldByName('file').Value:=files[i];
                FDMemTable1.FieldByName('handle').AsInteger:=handle;
                FDMemTable1.FieldByName('uid').AsString:=PluginInfo.plugguid;
                FDMemTable1.FieldByName('type').AsInteger:=PluginInfo.plugtype;
                FDMemTable1.FieldByName('name').AsString:=PluginInfo.plugname;
                FDMemTable1.FieldByName('title').AsString:=PluginInfo.plugtitle;
                FDMemTable1.FieldByName('version').AsString:=PluginInfo.plugversion;
                FDMemTable1.FieldByName('auther').AsString:=PluginInfo.plugauther;
                FDMemTable1.FieldByName('commit').AsString:=PluginInfo.plugcommit;
                FDMemTable1.FieldByName('classname').AsString:=PluginInfo.plugclassname;
                FDMemTable1.Post;

                with dxTileControl1.Items.Add do
                begin
                  GroupIndex:=dxTileControl1Group2.Index;
                  Text1.Align := oaMiddleCenter;
                  Text1.Value:=PluginInfo.plugtitle;
                  Text1.Font:=dxTileControl1Item1.Text1.Font;
                  Tag:= FDMemTable1.FieldByName('id').AsInteger;
                  OnClick:= PluginItemClick;
                end;
                dxTileControl1Group2.Visible:=(not dxTileControl1Group2.Visible) and (dxTileControl1Group2.ItemCount>0);
             end;

             //CreatePage(PluginInfo.plugguid,PluginInfo.plugname,TCustomFrameClass(FindClass(PluginInfo.plugclassname)).Create(Self));
          end;
        end;
      finally
        //UnloadPackage(handle);
      end;
    end;
  end;
end;

procedure Tmainform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(shopperdatamod) then
  begin
    shopperdatamod.Free;
    shopperdatamod:=nil;
  end;

end;

procedure Tmainform.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(bplclientuploadFrame) and bplclientuploadframe.IsUploading then
  begin
    CanClose := false;
    showmessage('正在上传数据,请稍后关闭软件');
  end
  else if Application.MessageBox('是否确定要退出程序?', '提示', MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    CanClose := true;
  end
  else
    CanClose := false;
end;

procedure Tmainform.FormCreate(Sender: TObject);
begin
  timesyncrunning:=false;
  width := 500;
  height := 400;
  dxTileControl1Group2.Visible:= not dxTileControl1Group2.ItemCount=0
end;

procedure Tmainform.FormShow(Sender: TObject);
begin
  if firstshow then
  begin
    firstshow:=false;
    updateTimerTimer(nil);
    updateTimer.Enabled := true;
    TThread.CreateAnonymousThread(timesync).Start;
    timesyncTimer.Enabled:=true;
  end;

end;

procedure Tmainform.loginframe1loginbuttonClick(Sender: TObject);
begin
  try
    loginframe1.loginbuttonClick(Sender);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
  // windowstate:=wsMinimized;
  hide;
  loginframe1.hide;
  width := 1280;
  height := 750;
  Constraints.MinWidth:=800;
  Constraints.MinHeight:=600;
  self.Position := poDesktopCenter;
  show;
  LoadPluginTimer.Enabled:=true;
  RzPageControl1.show;
  // cxPageControl1.Show;
  // windowstate:=wsNormal;
  // self.BringToFront;
end;

procedure Tmainform.loginframe1syncmemberButtonClick(Sender: TObject);
begin
  loginframe1.syncmemberButtonClick(Sender);
end;

procedure Tmainform.N1Click(Sender: TObject);
var
  index: Integer;
begin
  index := RzPageControl1.TabAtPos(tabX, tabY);
  if (index > 0) and (index <> -1) then
  begin
    RzPageControl1.ActivePageIndex := index;
    RzPageControl1.CloseActiveTab;
  end;

end;



procedure Tmainform.RzPageControl1Change(Sender: TObject);
begin
  RzPageControl1.ShowCloseButton := RzPageControl1.ActivePageIndex > 0;
  RzPageControl1.ShowCloseButtonOnActiveTab := RzPageControl1.ActivePageIndex > 0;
end;

procedure Tmainform.RzPageControl1Changing(Sender: TObject; NewIndex: Integer; var AllowChange: Boolean);
var
  grid:TObject;
begin
  if RzPageControl1.ActivePageIndex>0 then
  begin

    grid:=RzPageControl1.ActivePage.Controls[0].FindComponent('cxGrid1');
    AllowChange:=true;
    if grid<>nil then
    begin
      if TCxgrid(grid).ActiveView.DataController.IsEditing then
        AllowChange:=false
      else
        AllowChange:=true;
    end;
  end;
end;

procedure Tmainform.RzPageControl1Close(Sender: TObject; var AllowClose: Boolean);
begin
  if RzPageControl1.ActivePageIndex > 0 then
  begin
    AllowClose := false;
    if Assigned(bplclientuploadframe) then
      if bplclientuploadframe.IsUploading then
      begin
        showmessage('正在上传中,目前不能关闭当前标签');
        exit;
      end;
    if MessageBox(self.Handle, '是否要关闭当前标签', '', MB_ICONQUESTION + MB_OkCancel) <> mrOk then
      exit;

    AllowClose := true;
    //RzPageControl1.ActivePage.FindChildControl('clientsyc').Free;
    // if RzPageControl1.ActivePage.Tag = 1 then
    // bplshopperframe.Parent := nil;

    //FreeAndNil(bplshopperframe);
    // RzPageControl1.ActivePage.Destroy;
  end;
end;

procedure Tmainform.RzPageControl1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p: Tpoint;
  index: Integer;
begin
  index := RzPageControl1.TabAtPos(X, Y);
  tabX := X;
  tabY := Y;
  if (Button = mbRight) and (index <> -1) and (index > 0) then
  begin
    p.X := X;
    p.Y := Y;
    p := ClientToScreen(p);
    PopupMenu1.Popup(p.X, p.Y);
  end;
end;

procedure Tmainform.StaticText1Click(Sender: TObject);
begin
  showmessage(GetBuildInfo);
end;

procedure Tmainform.timesync;
var
  ntplist:TNTPUrlArray;
  i:integer;
  InternetTime, LocalhostTime: TDateTime;
  systemtime: Tsystemtime;
begin
    //ShowMessage(DateTimeToTimeStamp(IdSNTP1.DateTime).Date.ToString);
    ntplist:=getntpurl;
    InternetTime:=0;
    for I := 0 to Length(ntplist)-1 do
    begin
      IdSNTP1.Host:=ntplist[i];
      try
        InternetTime:= IdSNTP1.DateTime;
        if InternetTime=0 then
          Continue
        else
          Break;
      except

      end;
    end;
  // ShowMessage(FloatToStr(InternetTime));
    if InternetTime>0 then
    begin
      //showmessage(DateTimeToStr(InternetTime));
      LocalhostTime := now;
      if DateTimeToTimeStamp(InternetTime).Date<>DateTimeToTimeStamp(LocalhostTime).Date then
      begin
        timesyncrunning:=true;
        try

       //   if Application.MessageBox('检测到本地日期与正确日期不同,是否要设置正确时间?', '本地日期不正确',
        //     MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
//     if MessageBox(Handle, '检测到本地日期与正确日期不同,是否要设置正确时间?', '本地日期不正确', MB_YESNO +
  //     MB_ICONQUESTION + MB_TOPMOST) = IDYES then

           begin
             DateTimeToSystemTime(InternetTime, systemtime);   //把Delphi的TDateTime格式转化为API的TSystemTime格式
             if not SetLocalTime(systemtime) then   //设置系统时间
               showmessage('设置系统时间失败,请手动设置.'+#10#13+'当前时间为:'+DateTimeToStr(InternetTime));
           end;
        finally
          timesyncrunning :=false;
        end;
      end;
    end;
   // LocalhostTime := now;
end;

procedure Tmainform.timesyncTimerTimer(Sender: TObject);
begin
   if not timesyncrunning then
     timesync;
end;

procedure Tmainform.updateTimerTimer(Sender: TObject);
var
  updateexe: string;
  process: long;
begin
  if not (Assigned(bplclientuploadFrame) and bplclientuploadframe.IsUploading) then
  begin
    updateexe := ExtractFilePath(Application.ExeName) + 'update.exe';
    if FileExists(updateexe) then
    begin
      process := GetCurrentProcessID;
      ShellExecute(0, 'open', pchar(updateexe), Pchar(inttostr(process)), nil, SW_SHOWNORMAL);
    end;
  end;
end;


end.

