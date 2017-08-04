unit shopper;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Dialogs, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, dxSkinsCore, cxNavigator, Data.DB,
  cxDBData, cxDBLookupComboBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  cxDropDownEdit, cxPropertiesStore, Vcl.ExtCtrls, cxMaskEdit, cxCalendar,
  cxEditRepositoryItems, cxCheckBox, cxButtonEdit, cxCalc,
  cxDBExtLookupComboBox, shopperdm, cxContainer, cxTextEdit, cxLookupEdit,
  cxDBLookupEdit, Vcl.StdCtrls, System.DateUtils, cxGridExportLink, cxLabel,
  RzPanel, RzStatus, Vcl.Menus, Vcl.ComCtrls, dxCore, cxDateUtils,
  XLSSheetData5, XLSReadWriteII5, Clipbrd, cxExport, FireDAC.Phys.SQLiteWrapper,
  bplframe, Vcl.Forms;

type
  TInputType = (itnormal, itgife);

  Tbplshopperframe = class(TFrame, IcxExportProgress)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    shopperds: TDataSource;
    cxGrid1DBTableView1id: TcxGridDBColumn;
    cxGrid1DBTableView1eid: TcxGridDBColumn;
    cxGrid1DBTableView1gid: TcxGridDBColumn;
    cxGrid1DBTableView1sid: TcxGridDBColumn;
    cxGrid1DBTableView1cardcode: TcxGridDBColumn;
    cxGrid1DBTableView1name: TcxGridDBColumn;
    cxGrid1DBTableView1sex: TcxGridDBColumn;
    cxGrid1DBTableView1weixin: TcxGridDBColumn;
    cxGrid1DBTableView1phone: TcxGridDBColumn;
    cxGrid1DBTableView1email: TcxGridDBColumn;
    cxGrid1DBTableView1passport: TcxGridDBColumn;
    cxGrid1DBTableView1adcode: TcxGridDBColumn;
    cxGrid1DBTableView1addr: TcxGridDBColumn;
    cxGrid1DBTableView1expiry_time: TcxGridDBColumn;
    cxGrid1DBTableView1create_time: TcxGridDBColumn;
    cxGrid1DBTableView1update_time: TcxGridDBColumn;
    cxGrid1DBTableView1birthday_time: TcxGridDBColumn;
    cxGrid1DBTableView1chinese_birthday: TcxGridDBColumn;
    cxGrid1DBTableView1lastshop_time: TcxGridDBColumn;
    cxGrid1DBTableView1trash: TcxGridDBColumn;
    cxGrid1DBTableView1status: TcxGridDBColumn;
    shoppersoureceds: TDataSource;
    sexds: TDataSource;
    cxPropertiesStore1: TcxPropertiesStore;
    Panel1: TPanel;
    Splitter1: TSplitter;
    cxStyleRepository1: TcxStyleRepository;
    GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyle9: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyle13: TcxStyle;
    cxStyle14: TcxStyle;
    cxEditRepository1: TcxEditRepository;
    cxEditRepository1DateItem1: TcxEditRepositoryDateItem;
    cxEditRepository1DateItem2: TcxEditRepositoryDateItem;
    areads: TDataSource;
    cxGrid1DBTableView2: TcxGridDBTableView;
    cxGrid1DBTableView2p: TcxGridDBColumn;
    cxGrid1DBTableView2c: TcxGridDBColumn;
    cxGrid1DBTableView2a: TcxGridDBColumn;
    cxGrid1DBTableView2adcode: TcxGridDBColumn;
    expods: TDataSource;
    expocxLookupComboBox: TcxLookupComboBox;
    phonecxMaskEdit: TcxMaskEdit;
    applyButton: TButton;
    shoppersourcecxLookupComboBox: TcxLookupComboBox;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    PopupMenu1: TPopupMenu;
    deletemenu: TMenuItem;
    N1: TMenuItem;
    allrecordmenu: TMenuItem;
    toexcelmenu: TMenuItem;
    StaticText4: TStaticText;
    nameedit: TEdit;
    StaticText5: TStaticText;
    sexcxLookupComboBox: TcxLookupComboBox;
    weixinedit: TEdit;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    emailEdit: TEdit;
    StaticText8: TStaticText;
    passportEdit: TEdit;
    StaticText9: TStaticText;
    birtydaycxDateEdit: TcxDateEdit;
    chinesebdCheckBox: TCheckBox;
    StaticText10: TStaticText;
    pastcxDateEdit: TcxDateEdit;
    StaticText11: TStaticText;
    lastshopcxDateEdit: TcxDateEdit;
    StaticText12: TStaticText;
    addrEdit: TEdit;
    restButton: TButton;
    XLSReadWriteII51: TXLSReadWriteII5;
    fromexcelmenu: TMenuItem;
    refreshmenu: TMenuItem;
    copyitemmenu: TMenuItem;
    fetchmenu: TMenuItem;
    autowidthmenu: TMenuItem;
    RzStatusBar1: TRzStatusBar;
    RzStatusPane1: TRzStatusPane;
    RzStatusPane2: TRzStatusPane;
    RzClockStatus1: TRzClockStatus;
    RzProgressStatus1: TRzProgressStatus;
    RzStatusPane3: TRzStatusPane;
    updateareaallbutton: TButton;
    Label1: TLabel;
    goodsEdit: TEdit;
    cxGrid1DBTableView1goods: TcxGridDBColumn;
    cxGrid1DBTableView1mod: TcxGridDBColumn;
    procedure expocxLookupComboBoxPropertiesChange(Sender: TObject);
    procedure updateareaallbuttonClick(Sender: TObject);
    procedure applyButtonClick(Sender: TObject);
    procedure phonecxMaskEditKeyPress(Sender: TObject; var Key: Char);
    procedure toexcelmenuClick(Sender: TObject);
    procedure allrecordmenuClick(Sender: TObject);
    procedure fromexcelmenuClick(Sender: TObject);
    procedure phonecxMaskEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure refreshmenuClick(Sender: TObject);
    procedure deletemenuClick(Sender: TObject);
    procedure copyitemmenuClick(Sender: TObject);
    procedure cxGrid1DBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure restButtonClick(Sender: TObject);
    procedure cxGrid1DBTableView1phonePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure fetchmenuClick(Sender: TObject);
    procedure autowidthmenuClick(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure shoppersourcecxLookupComboBoxPropertiesChange(Sender: TObject);
    procedure shoppersourcecxLookupComboBoxPropertiesPopup(Sender: TObject);
    procedure shoppersourcecxLookupComboBoxPropertiesCloseUp(Sender: TObject);
    procedure cxGrid1DBTableView1sidPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    Recordmod:integer;
    procedure CxGridToExcel(AcxGrid: TcxGrid);
    procedure Resetform;
    procedure LoadExcel;
    procedure OnProgress(Sender: TObject; Percent: Integer);
  public
    { Public declarations }
    inputtype: TInputType;
    procedure List;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  shopperdatamod: Tshopperdatamod;

implementation

{$R *.dfm}

uses
  confirmappend;

// 将当前GRID数据导出到EXCEL文件
procedure Tbplshopperframe.CxGridToExcel(AcxGrid: TcxGrid);
var
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(nil);
  with SaveDialog do
  begin
    Filter := '*.xls|*.xls';
    if Execute then
      ExportGridToExcel(SaveDialog.FileName, AcxGrid, true, true, true,
        'xls', Self);
  end;
  SaveDialog.Free;
end;

procedure Tbplshopperframe.OnProgress(Sender: TObject; Percent: Integer);
begin
  Application.ProcessMessages;
  RzProgressStatus1.Percent := Percent;
  if Percent = 100 then
  begin
    ShowMessage('导出完成');
    RzStatusPane3.Visible := false;
    RzProgressStatus1.Visible := false;
  end;
  if Percent = 1 then
  begin
    RzProgressStatus1.Visible := true;
    RzStatusPane3.Visible := true;
  end;
end;

// 右键菜单删除当前记录
procedure Tbplshopperframe.deletemenuClick(Sender: TObject);
begin
  case MessageBox(0, '是否要删除当前记录?', '警告', MB_OKCANCEL + MB_ICONWARNING +
    MB_DEFBUTTON2) of
    IDOK:
      with shopperdatamod.shopperfdquery do
      begin
        Edit;
        FieldValues['trash'] := 1;
        Post;
        RefreshRecord;
      end;
    IDCANCEL:
      exit;
  end;

end;

// 导入EXCEL文件到数据库
procedure Tbplshopperframe.LoadExcel;
var
  OpenDialog: TOpenDialog;
  i, sexint, ierror: Integer;
begin
  OpenDialog := TOpenDialog.Create(nil);
  with OpenDialog do
  begin
    Filter := '*.xls|*.xls|*.xlsx|*.xlsx';
    if Execute then
      XLSReadWriteII51.FileName := OpenDialog.FileName
    else
    begin
      Free;
      exit;
    end;
    Free;
  end;
  XLSReadWriteII51.Read;
  shopperdatamod.shopperfdquery.DisableControls;
  shopperdatamod.shopperfdquery.CachedUpdates := true;
  try
    try
      for i := XLSReadWriteII51.Sheets[0].FirstRow + 1 to XLSReadWriteII51.Sheets
        [0].LastRow do
      begin
        shopperdatamod.shopperfdquery.Append;
        with shopperdatamod.shopperfdquery do
        begin
          FieldValues['eid'] := shopperdatamod.expofdquery.FieldValues['id'];
          FieldValues['gid'] := 0;
          FieldValues['sid'] := shopperdatamod.shoppersourcefdquery.
            FieldValues['id'];
          FieldValues['name'] := XLSReadWriteII51.Sheets[0].asstring[1, i];
          sexint := 0;
          if XLSReadWriteII51.Sheets[0].asstring[2, i] = '先生' then
            sexint := 1
          else if XLSReadWriteII51.Sheets[0].asstring[2, i] = '女士' then
            sexint := 2;

          FieldValues['sex'] := sexint;
          FieldValues['weixin'] := '';
          FieldValues['phone'] := XLSReadWriteII51.Sheets[0].asstring[3, i];
          FieldValues['email'] := '';
          FieldValues['passport'] := '';
          FieldValues['adcode'] := shopperdatamod.expofdquery.FieldValues
            ['adcode'];
          FieldValues['addr'] := '';
          FieldValues['expiry_time'] := 0;

          // ShowMessage(XLSReadWriteII51.Sheets[0].AsString[5,i]);

          FieldValues['create_time'] :=
            DateTimeToUnix(VarToDateTime(XLSReadWriteII51.Sheets[0]
            .asstring[5, i]));
          FieldValues['update_time'] :=
            DateTimeToUnix(VarToDateTime(XLSReadWriteII51.Sheets[0]
            .asstring[5, i]));
          FieldValues['birthday_time'] := 0;
          FieldValues['chinese_birthday'] := 0;
          FieldValues['lastshop_time'] := 0;
          FieldValues['trash'] := 0;
          FieldValues['status'] := 1;
          FieldValues['createtime'] :=
            VarToDateTime(XLSReadWriteII51.Sheets[0].asstring[5, i]);
          FieldValues['updatetime'] :=
            VarToDateTime(XLSReadWriteII51.Sheets[0].asstring[5, i]);
          FieldValues['area'] := RzStatusPane1.Caption;
        end;
        shopperdatamod.shopperfdquery.Post;
      end;
      shopperdatamod.shopperfdquery.OnUpdateRecord :=
        shopperdatamod.shopperfdqueryUpdateRecord;

      shopperdatamod.shopperfdquery.Connection.StartTransaction;

      ierror := shopperdatamod.shopperfdquery.ApplyUpdates;
      if ierror = 0 then
      begin
        shopperdatamod.shopperfdquery.Connection.Commit;
        shopperdatamod.shopperfdquery.CommitUpdates;
      end
      else
      begin
        shopperdatamod.shopperfdquery.Connection.Rollback;
        ShowMessage('写入到数据库失败,EXCEL的内容必须符合格式');
      end;
    except
      ShowMessage('写入到数据库失败,EXCEL的内容必须符合格式');
    end;
  finally
    shopperdatamod.shopperfdquery.CachedUpdates := false;
    shopperdatamod.shopperfdquery.OnUpdateRecord := nil;
    shopperdatamod.shopperfdquery.Refresh;
    shopperdatamod.shopperfdquery.EnableControls;
  end;
end;

// 初始化当前Frame
procedure Tbplshopperframe.List;
begin
  expocxLookupComboBox.ItemIndex := 0;
  shoppersourcecxLookupComboBox.ItemIndex := 0;
  sexcxLookupComboBox.ItemIndex := 0;
end;

// PHONE编辑框中回车提交数据
procedure Tbplshopperframe.phonecxMaskEditKeyPress(Sender: TObject;
  var Key: Char);
begin

  if Key = #13 then
  begin
    applyButtonClick(applyButton);
    Key := #0;
  end;
end;

// 手机号输入自动验证失败后弹出的文字
procedure Tbplshopperframe.phonecxMaskEditPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  ErrorText := '请输入正确的手机号!';

end;

// 刷新当前数据
procedure Tbplshopperframe.refreshmenuClick(Sender: TObject);
begin
  cxGrid1DBTableView1.DataController.RefreshExternalData;
end;

// 重置当前所有输入组件,并把光标放在手机号编辑框
procedure Tbplshopperframe.Resetform;
begin
  phonecxMaskEdit.Clear;
  phonecxMaskEdit.SetFocus;
  nameedit.Clear;
  sexcxLookupComboBox.ItemIndex := 0;
  weixinedit.Clear;
  emailEdit.Clear;
  passportEdit.Clear;
  birtydaycxDateEdit.Clear;
  pastcxDateEdit.Clear;
  // lastshopcxDateEdit.Text := '';
  lastshopcxDateEdit.Clear;
  addrEdit.Clear;
  goodsEdit.Clear;
  chinesebdCheckBox.Checked := false;
end;

// 重置当前输入的按钮事件
procedure Tbplshopperframe.restButtonClick(Sender: TObject);
begin
  Resetform;
end;

procedure Tbplshopperframe.shoppersourcecxLookupComboBoxPropertiesChange(Sender: TObject);
var
  str:string;
begin
  //showmessage();
  Recordmod:=0;
  if shopperdatamod.shoppersourcefdquery.FieldByName('mod').AsString='normal' then
    Recordmod:=0;
  if shopperdatamod.shoppersourcefdquery.FieldByName('mod').AsString='repeat' then
    Recordmod:=1;
  str:=shopperdatamod.shoppersourcefdquery.FieldByName('title').AsString;
  if str.Contains('拍卖') or str.Contains('购物') then
  begin
    Label1.Visible:=true;
    goodsEdit.Visible:=true;
  end
  else
  begin
    Label1.Visible:=false;
    goodsEdit.Visible:=false;
  end;

end;

procedure Tbplshopperframe.shoppersourcecxLookupComboBoxPropertiesCloseUp(Sender: TObject);
begin
  shopperdatamod.shoppersourcefdquery.Filtered:=false;
  cxGrid1DBTableView1sid.Properties.LockUpdate(false);
  shoppersourcecxLookupComboBox.Properties.LockUpdate(false);
end;

procedure Tbplshopperframe.shoppersourcecxLookupComboBoxPropertiesPopup(Sender: TObject);
begin
   cxGrid1DBTableView1sid.Properties.LockUpdate(true);
   shoppersourcecxLookupComboBox.Properties.LockUpdate(true);
   shopperdatamod.shoppersourcefdquery.Filtered:=true;
end;

procedure Tbplshopperframe.Splitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := NewSize > 210;
end;

// 防止PANEL跑到StatusBar下面去
procedure Tbplshopperframe.Splitter1Moved(Sender: TObject);
begin
  RzStatusBar1.Top := 9999;
end;

// 右键弹出菜单导出到EXCEL
procedure Tbplshopperframe.toexcelmenuClick(Sender: TObject);
begin
  CxGridToExcel(cxGrid1);
end;

// 右键弹出菜单显示所有记录
procedure Tbplshopperframe.allrecordmenuClick(Sender: TObject);
var
  sqlstr: string;
begin
  // sqlstr := format(SHOPPER_SQL, [' group by phone order by id']);
  sqlstr := format(SHOPPER_SQL, ['']);
  shopperdatamod.shopperfdquery.Close;
  shopperdatamod.shopperfdquery.Open(sqlstr);
  shopperdatamod.areafdquery.First;
end;

// 加入一条新数据
procedure Tbplshopperframe.applyButtonClick(Sender: TObject);
var
  ipoint: Integer;
  phone: Variant;
  ierror: Boolean;
  Caption: TCaption;
  chinesebd: Integer;
  validatedate: string;
  procedure AppendData(updatetype:integer=0);
  begin
    // 对Dataset添加数据
      try
        try
          with shopperdatamod do
          begin
            shopperfdquery.DisableControls;
            shopperfdquery.Append;
            with shopperfdquery do
            begin
              FieldValues['eid'] := expofdquery.FieldValues['id'];
              FieldValues['gid'] := 1;
              FieldValues['sid'] := shoppersourcefdquery.FieldValues['id'];
              FieldValues['name'] := Trim(nameedit.Text);
              FieldValues['sex'] := sexcxLookupComboBox.ItemIndex;
              FieldValues['weixin'] := Trim(weixinedit.Text);
              FieldValues['phone'] := Trim(phonecxMaskEdit.Text);
              FieldValues['email'] := Trim(emailEdit.Text);
              FieldValues['passport'] := Trim(passportEdit.Text);
              FieldValues['adcode'] := expofdquery.FieldValues['adcode'];
              FieldValues['addr'] := Trim(addrEdit.Text);
              FieldValues['create_time'] := DateTimeToUnix(IncHour(Now, -8));
              FieldValues['update_time'] := DateTimeToUnix(IncHour(Now, -8));

              if birtydaycxDateEdit.Text = '' then
                FieldValues['birthday_time'] := 0
              else
              begin
                FieldValues['birthday_time'] :=
                  DateTimeToUnix(birtydaycxDateEdit.Date);
                FieldValues['birthdaytime'] := birtydaycxDateEdit.Date;
              end;

              if chinesebdCheckBox.Checked then
                chinesebd := 1
              else
                chinesebd := 0;

              FieldValues['chinese_birthday'] := chinesebd;

              if lastshopcxDateEdit.Text = '' then
                FieldValues['lastshop_time'] := 0
              else
              begin
                FieldValues['lastshop_time'] :=
                  DateTimeToUnix(lastshopcxDateEdit.Date);
                FieldValues['lastshoptime'] := lastshopcxDateEdit.Date;
              end;

              if pastcxDateEdit.Text = '' then
                FieldValues['expiry_time'] := 0
              else
              begin
                FieldValues['expiry_time'] := DateTimeToUnix(pastcxDateEdit.Date);
                FieldValues['expirytime'] := pastcxDateEdit.Date;
              end;

              FieldValues['trash'] := 0;
              FieldValues['status'] := 1;
              FieldValues['createtime'] := Now();
              FieldValues['updatetime'] := Now();
              FieldValues['area'] := RzStatusPane1.Caption;
              FieldValues['goods'] := Trim(goodsEdit.Text);
              FieldValues['mod'] := Recordmod;
            end;
            shopperfdquery.Post;

            { 检测当前展会中是否已经有这个手机号,如果有全部软删除,
              只保留当前输入的为可用 }
            if not validatePhone(Trim(phonecxMaskEdit.Text),
              shopperfdquery.FieldByName('id').AsInteger, 1) then
              shopperfdquery.Refresh;
          end;
          Resetform;
        except
          on E: ESQLiteNativeException do
          begin
            shopperdatamod.shopperfdquery.Cancel;
            if E.ErrorCode = 2067 then
              ShowMessage(inttostr(E.ErrorCode))
            else
              raise;
          end;
        end;
      finally
        shopperdatamod.shopperfdquery.EnableControls;
      end;
  end;
begin
  if Trim(phonecxMaskEdit.Text) = '' then
  begin
    ShowMessage('必须输入手机号码');
    exit;
  end;

  // 验证手机号是否正确
  ierror := false;
  phone := phonecxMaskEdit.Text;
  phonecxMaskEdit.Properties.ValidateDisplayValue(phone, Caption, ierror,
    phonecxMaskEdit);
  if ierror then
  begin
    ShowMessage('请输入正确的手机号');
    exit;
  end;

  if (inputtype = itnormal) or (inputtype=itgife) then
  begin
    if shopperdatamod.shopperfdquery.Locate('phone,mod',VarArrayOf([phone,0])) then
    begin
      if inputtype=itnormal then
      begin

      end;
    end;
  end;

  if inputtype = itgife then
  begin
    validatedate := shopperdatamod.validatePhone(phone);
    if not validatedate.IsEmpty then
    begin
      Beep;
      confirmappendForm := TconfirmappendForm.Create(Self);
      try
        confirmappendForm.Label1.Caption :=
          format(confirmappendForm.Label1.Caption, [phone]);
        confirmappendForm.Label2.Caption :=
          format(confirmappendForm.Label2.Caption, [validatedate]);
        if confirmappendForm.ShowModal = mrCancel then
          exit;
      finally
        confirmappendForm.Free;
      end;
    end;
  end;

end;

procedure Tbplshopperframe.autowidthmenuClick(Sender: TObject);
begin
  cxGrid1DBTableView1.ApplyBestFit();
end;

// 右键弹出菜单复制当前选中字段到剪贴板
procedure Tbplshopperframe.copyitemmenuClick(Sender: TObject);
begin
  Clipboard.AsText := cxGrid1DBTableView1.Controller.SelectedRows[0]
    .DisplayTexts[cxGrid1DBTableView1.Controller.FocusedColumn.Index];
end;

// FRAME创建
constructor Tbplshopperframe.Create(AOwner: TComponent);
begin
  inherited;
  if shopperdatamod = nil then
  begin
    shopperdatamod := Tshopperdatamod.Create(nil);
    shopperds.DataSet := shopperdatamod.shopperfdquery;
  end;
  // cxPropertiesStore1.StorageName := ExtractFilePath(Application.Exename)
  // + inifile;
  cxPropertiesStore1.Active := true;
  cxPropertiesStore1.RestoreFrom; // 读取保存的一些组件数据
  RzProgressStatus1.Visible := false;
  RzStatusBar1.Top := 9999; // 防止PANEL跑到StatusBar下面去
  Recordmod:=0;
end;

// 在Grid里按Ctrl+C复制当前格子的文本内容
procedure Tbplshopperframe.cxGrid1DBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = 67) then
    copyitemmenuClick(nil);
end;

// 手机号字段验证
procedure Tbplshopperframe.cxGrid1DBTableView1phonePropertiesValidate
  (Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  i,col_index:integer;
begin
  if VarIsStr(DisplayValue) then
    if (Length(DisplayValue) > 11) or (string(DisplayValue)[1] <> '1') then
    begin
      Error := true;
      ErrorText := '手机号码格式错误,请重新输入';
      exit;
    end;
  col_index:=cxGrid1DBTableView1.GetColumnByFieldName('phone').Index;
  for I := 0 to cxGrid1DBTableView1.ViewData.RecordCount-1 do
  begin
     if not cxGrid1DBTableView1.ViewData.Records[i].Focused then
     begin
      if cxGrid1DBTableView1.ViewData.Records[i].Values[col_index] = DisplayValue then
      begin
        Error:=true;
        ErrorText := '手机号码重复';
        break;
      end;
     end;
  end;
end;

//顾客来源变动时,自动修改当前记录的MOD字段
procedure Tbplshopperframe.cxGrid1DBTableView1sidPropertiesEditValueChanged(Sender: TObject);
var
  modvalue:Variant;
  col_index:integer;
begin
  modvalue:=shopperdatamod.shoppersourcefdquery.Lookup('title',TcxLookupComboBox(Sender).Text,'mod');
  if not VarIsNull(modvalue) then
  begin
    if modvalue='normal' then
      shopperdatamod.shopperfdquery.FieldByName('mod').NewValue:=0
    else if modvalue='repeat' then
       shopperdatamod.shopperfdquery.FieldByName('mod').NewValue:=1;
  end;
end;

//Frame释放时执行的一些操作,保存当前FRAME里一些组件的属性
destructor Tbplshopperframe.Destroy;
begin
  cxPropertiesStore1.StoreTo(true);
  // FreeAndNil(shopperdatamod);
  inherited;
end;

// 展会ComboBox改变时,根据展会拉取数据
procedure Tbplshopperframe.expocxLookupComboBoxPropertiesChange
  (Sender: TObject);
var
  sqlstr: string;
begin
  sqlstr := format(SHOPPER_SQL,
    [' and eid=' + shopperdatamod.expofdquery.FieldByName('id').asstring]);
  shopperdatamod.shopperfdquery.Close;
  shopperdatamod.shopperfdquery.Open(sqlstr);
  shopperdatamod.areafdquery.First;
  shopperdatamod.areafdquery.DisableControls;
  while not shopperdatamod.areafdquery.Eof do
  begin
    if (shopperdatamod.expofdquery.FieldValues['adcode']
      = shopperdatamod.areafdquery.FieldValues['adcode']) then
    begin
      with shopperdatamod.areafdquery do
        RzStatusPane1.Caption := FieldValues['p'] + FieldValues['c'] +
          FieldValues['a'];
      break;
    end;
    shopperdatamod.areafdquery.Next;
  end;
  shopperdatamod.areafdquery.EnableControls;
end;

// 右键弹出菜单导入EXCEL
procedure Tbplshopperframe.fetchmenuClick(Sender: TObject);
begin
  expocxLookupComboBoxPropertiesChange(nil);
end;

procedure Tbplshopperframe.fromexcelmenuClick(Sender: TObject);
begin
  LoadExcel;
end;

// 将当前展会的AREACODE更新到当前所有记录
procedure Tbplshopperframe.updateareaallbuttonClick(Sender: TObject);
var
  iErrors: Integer;
begin
  if shopperdatamod.shopperfdquery.RecordCount > 0 then
  begin
    if Application.MessageBox('是否要批量更新地区信息?', '提示', MB_YESNO + MB_ICONQUESTION +
      MB_DEFBUTTON2) = IDNO then
      exit;

    with shopperdatamod do
    begin
      shopperfdquery.DisableControls;
      shopperfdquery.CachedUpdates := true;
      shopperfdquery.First;
      try
        try
          while not shopperfdquery.Eof do
          begin
            shopperfdquery.Edit;
            shopperfdquery.FieldValues['adcode'] := expofdquery.FieldValues
              ['adcode'];
            shopperfdquery.Post;
            shopperfdquery.Next;
          end;
          shopperfdquery.Connection.StartTransaction;
          iErrors := shopperfdquery.ApplyUpdates;
          if iErrors > 0 then
          begin
            shopperfdquery.Connection.Rollback;
            ShowMessage('出现错误,更新失败');
          end
          else
          begin
            shopperfdquery.Connection.Commit;
            shopperfdquery.CommitUpdates;
          end;
        except

        end;
      finally
        shopperfdquery.CachedUpdates := false;
        shopperfdquery.EnableControls;
      end;
    end;
  end;
end;

end.
