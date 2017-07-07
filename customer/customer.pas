unit customer;

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
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  Data.DB,
  cxDBData,
  Vcl.ExtCtrls,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  customerdm,
  cxContainer,
  Vcl.StdCtrls,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  cxExtEditRepositoryItems,
  cxCurrencyEdit,
  cxPropertiesStore,
  cxEditRepositoryItems,
  cxDBEditRepository,
  System.DateUtils, Vcl.Menus;

type
  TbplCustomerFrame = class(TFrame)
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Panel1: TPanel;
    Splitter1: TSplitter;
    expocxLookupComboBox: TcxLookupComboBox;
    StaticText1: TStaticText;
    cxEditRepository1: TcxEditRepository;
    IDcxEditRepository1Label: TcxEditRepositoryLabel;
    cxPropertiesStore1: TcxPropertiesStore;
    applyButton: TButton;
    Button2: TButton;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    StaticText10: TStaticText;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    StaticText13: TStaticText;
    StaticText14: TStaticText;
    StaticText15: TStaticText;
    StaticText16: TStaticText;
    infoMemo: TMemo;
    addrEdit: TEdit;
    standnumberEdit: TEdit;
    nameEdit: TEdit;
    companyEdit: TEdit;
    emailEdit: TEdit;
    allpaycxCurrencyEdit: TcxCurrencyEdit;
    qqEdit: TEdit;
    firstpaycxCurrencyEdit: TcxCurrencyEdit;
    nowpaycxCurrencyEdit: TcxCurrencyEdit;
    paytypecxLookupComboBox: TcxLookupComboBox;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    telphonecxMaskEdit: TcxMaskEdit;
    cxEditRepository1DateItem: TcxEditRepositoryDateItem;
    paytypecxEditRepository1LookupComboBoxItem
      : TcxEditRepositoryLookupComboBoxItem;
    customertypecxEditRepository1ComboBoxItem1: TcxEditRepositoryComboBoxItem;
    cxEditRepository1CurrencyItem1: TcxEditRepositoryCurrencyItem;
    phonecxMaskEdit: TcxMaskEdit;
    customertypecxComboBox: TcxComboBox;
    salesnamecxEditRepository1ComboBoxItem: TcxEditRepositoryComboBoxItem;
    salescxComboBox: TcxComboBox;
    otherpaycxStyle: TcxStyle;
    cxEditRepository1PopupItem1: TcxEditRepositoryPopupItem;
    PopupMenu1: TPopupMenu;
    autowidthmenu: TMenuItem;
    refreshmenu: TMenuItem;
    fetchmenu: TMenuItem;
    N1: TMenuItem;
    softremovemenu: TMenuItem;
    fetchallmenu: TMenuItem;
    PopupMenu2: TPopupMenu;
    N2: TMenuItem;
    toexcelmenu: TMenuItem;
    procedure expocxLookupComboBoxPropertiesChange(Sender: TObject);
    procedure customertypecxEditRepository1ComboBoxItem1PropertiesInitPopup
      (Sender: TObject);
    procedure salesnamecxEditRepository1ComboBoxItemPropertiesInitPopup
      (Sender: TObject);
    procedure salesnamecxEditRepository1ComboBoxItemPropertiesEditValueChanged
      (Sender: TObject);
    procedure allpaycxCurrencyEditClick(Sender: TObject);
    procedure cxGrid1DBTableView1StylesGetContentStyle
      (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxEditRepository1PopupItem1PropertiesInitPopup(Sender: TObject);
    procedure cxEditRepository1PopupItem1PropertiesCloseUp(Sender: TObject);
    procedure applyButtonClick(Sender: TObject);
    procedure cxGrid1DBTableView1DataControllerDataChanged(Sender: TObject);
    procedure autowidthmenuClick(Sender: TObject);
    procedure refreshmenuClick(Sender: TObject);
    procedure fetchmenuClick(Sender: TObject);
    procedure fetchallmenuClick(Sender: TObject);
    procedure softremovemenuClick(Sender: TObject);
    procedure toexcelmenuClick(Sender: TObject);
  private
    { Private declarations }
    columninfoMemo: TMemo;
    procedure initGirdTableView;
    procedure CxGridToExcel(AcxGrid: TcxGrid);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation
uses cxGridExportLink;

{$R *.dfm}


//将当前GRID数据导出到EXCEL文件
procedure TbplCustomerFrame.CxGridToExcel(AcxGrid: TcxGrid);
var
 SaveDialog: TSaveDialog;
begin
 SaveDialog := TSaveDialog.Create(nil);
 with SaveDialog do
 begin
   Filter := '*.xls|*.xls';
   if Execute then
     ExportGridToExcel(SaveDialog.FileName, AcxGrid, true, true, true, 'xls');
 end;
 SaveDialog.Free;
end;


procedure TbplCustomerFrame.allpaycxCurrencyEditClick(Sender: TObject);
begin
  with (Sender as TcxCurrencyEdit) do
  begin
    if Value = 0 then
      SelectAll;
  end;
end;

procedure TbplCustomerFrame.applyButtonClick(Sender: TObject);
var
  required_str:string;
begin
  required_str:='';

  if trim(standnumberEdit.Text)='' then
   required_str:=required_str+'展位号未填写'+#13#10;

  if trim(nameEdit.Text)='' then
   required_str:=required_str+'姓名未填写'+#13#10;

  if phonecxMaskEdit.Text='' then
    required_str:=required_str+'手机号未填写'+#13#10;

  if required_str<>'' then
  begin
    showmessage( required_str);
    exit;
  end;


  with customerDataModule do
  begin
    customerFDQuery.Append;
    try
      customerFDQuery.FieldValues['eid'] := expoFDQuery.FieldValues['id'];
      customerFDQuery.FieldValues['customertype'] :=
        trim(customertypecxComboBox.Text);
      customerFDQuery.FieldValues['standnumber'] := trim(standnumberEdit.Text);
      customerFDQuery.FieldValues['name'] := trim(nameEdit.Text);
      customerFDQuery.FieldValues['mobilephone'] := phonecxMaskEdit.Text;
      customerFDQuery.FieldValues['paytype'] := paytypeFDQuery.FieldValues['id'];
      customerFDQuery.FieldValues['allpay'] := allpaycxCurrencyEdit.Value;
      customerFDQuery.FieldValues['firstpay'] := firstpaycxCurrencyEdit.Value;
      customerFDQuery.FieldValues['nowpay'] := nowpaycxCurrencyEdit.Value;
      customerFDQuery.FieldValues['telphone'] := trim(telphonecxMaskEdit.Text);
      customerFDQuery.FieldValues['company']:=trim(companyEdit.Text);
      customerFDQuery.FieldValues['email'] := trim(emailEdit.Text);
      customerFDQuery.FieldValues['qq'] := trim(qqEdit.Text);
      customerFDQuery.FieldValues['addr'] := trim(addrEdit.Text);
      customerFDQuery.FieldValues['customerinfo']:=trim(infoMemo.Lines.Text);
      customerFDQuery.FieldValues['groupid'] := 0;
      customerFDQuery.FieldValues['salesname'] := trim(salescxComboBox.Text);
      customerFDQuery.FieldValues['salesid'] := 0;
      customerFDQuery.FieldValues['create_datetime'] :=
        DateTimeToUnix(IncHour(Now, -8));
      customerFDQuery.FieldValues['update_datetime'] :=  DateTimeToUnix(IncHour(Now, -8));

      customerFDQuery.FieldValues['updatetime'] := Now;
      customerFDQuery.FieldValues['createtime'] := Now;

      customerFDQuery.FieldValues['status']:=1;
      customerFDQuery.FieldValues['trash']:=0;
      customerFDQuery.Post;
    except
      customerFDQuery.Cancel;
      raise;
    end;
  end;
end;

procedure TbplCustomerFrame.autowidthmenuClick(Sender: TObject);
begin
  cxGrid1DBTableView1.ApplyBestFit();
end;

constructor TbplCustomerFrame.Create(AOwner: TComponent);
var
i:integer;
begin
  inherited;
  if customerDataModule = nil then
  begin
    customerDataModule := TcustomerDataModule.Create(nil);
    expocxLookupComboBox.ItemIndex := 0;
    paytypecxLookupComboBox.ItemIndex := 0;
    for i := 0 to cxGrid1DBTableView1.ColumnCount - 1 do
    begin
      with cxPropertiesStore1.Components.Add do
      begin
        Component := cxGrid1DBTableView1.Columns[i];
        Properties.Add('width');
      end;
    end;
    initGirdTableView;
    cxPropertiesStore1.RestoreFrom;
    if not Assigned(columninfoMemo) then
    begin
      columninfoMemo := TMemo.Create(Self);
      columninfoMemo.ScrollBars := ssVertical;
      columninfoMemo.Width := 300;
      columninfoMemo.Height := 200;
      columninfoMemo.Visible := false;
      columninfoMemo.Parent := Panel1;
      columninfoMemo.Font.Name := '微软雅黑';
      columninfoMemo.Font.Size := 16;
      cxEditRepository1PopupItem1.Properties.PopupControl := columninfoMemo;
    end;
  end;
end;



procedure TbplCustomerFrame.
  customertypecxEditRepository1ComboBoxItem1PropertiesInitPopup
  (Sender: TObject);
begin
  // showmessage('abc');
  with customertypecxEditRepository1ComboBoxItem1 do
  begin
    // Properties.Items.Clear;
    Properties.Items.Text := customerDataModule.getCustomerType.Text;
  end;
end;

// 客户备注弹出菜单关闭,将MEMO的值写入表
procedure TbplCustomerFrame.cxEditRepository1PopupItem1PropertiesCloseUp
  (Sender: TObject);
begin
  with customerDataModule.customerFDQuery do
  begin
    Edit;
    FieldByName('customerinfo').Value := columninfoMemo.Lines.Text.trim;
    Post;
  end;
end;

// 客户备注弹出菜单初始化,将字段值放入MEMO
procedure TbplCustomerFrame.cxEditRepository1PopupItem1PropertiesInitPopup
  (Sender: TObject);
begin
  if Assigned(columninfoMemo) then
  begin
    columninfoMemo.Lines.Text := customerDataModule.customerFDQuery.FieldByName
      ('customerinfo').AsString;
  end;
end;

procedure TbplCustomerFrame.cxGrid1DBTableView1DataControllerDataChanged(
  Sender: TObject);
begin
if cxGrid1DBTableView1.ColumnCount = 0 then
  begin

    cxGrid1DBTableView1.DataController.CreateAllItems(true);
  end;
end;

procedure TbplCustomerFrame.cxGrid1DBTableView1StylesGetContentStyle
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  if (AItem.Caption = '剩余金额') then
  begin
    if ARecord.Values[AItem.Index] > 0 then
      AStyle := otherpaycxStyle;
  end
end;

destructor TbplCustomerFrame.Destroy;
begin
  if customerDataModule.customerFDQuery.State=dsEdit then
     customerDataModule.customerFDQuery.Post;
  cxPropertiesStore1.StoreTo;
  FreeAndNil(customerDataModule);
  inherited;
end;

procedure TbplCustomerFrame.initGirdTableView;
begin

if cxGrid1DBTableView1.ColumnCount >0 then
  begin
   // cxGrid1DBTableView1.DataController.CreateAllItems(True);

    with TcxGridDBTableSummaryItem
      (cxGrid1DBTableView1.DataController.Summary.FooterSummaryItems.Add) do
    begin
      // FieldName:='id';
      Column := cxGrid1DBTableView1.GetColumnByFieldName('id');
      Kind := skCount;
      Format := '共0条';
    end;
    with TcxGridDBTableSummaryItem
      (cxGrid1DBTableView1.DataController.Summary.FooterSummaryItems.Add) do
    begin
      // FieldName:='allpay';
      Column := cxGrid1DBTableView1.GetColumnByFieldName('allpay');
      Kind := skSum;
      Format := '¥,0.00;¥-,0.00';
    end;
    with TcxGridDBTableSummaryItem
      (cxGrid1DBTableView1.DataController.Summary.FooterSummaryItems.Add) do
    begin
      // FieldName:='firstpay';
      Column := cxGrid1DBTableView1.GetColumnByFieldName('firstpay');
      Kind := skSum;
      Format := '¥,0.00;¥-,0.00';
    end;
    with TcxGridDBTableSummaryItem
      (cxGrid1DBTableView1.DataController.Summary.FooterSummaryItems.Add) do
    begin
      // FieldName:='nowpay';
      Column := cxGrid1DBTableView1.GetColumnByFieldName('nowpay');
      Kind := skSum;
      Format := '¥,0.00;¥-,0.00';
    end;
    with TcxGridDBTableSummaryItem
      (cxGrid1DBTableView1.DataController.Summary.FooterSummaryItems.Add) do
    begin
      // FieldName:='otherpay';
      Column := cxGrid1DBTableView1.GetColumnByFieldName('otherpay');
      Kind := skSum;
      Format := '¥,0.00;¥-,0.00';
    end;

    with cxGrid1DBTableView1.GetColumnByFieldName('id') do
    begin
      HeaderAlignmentHorz := taCenter;
      RepositoryItem := IDcxEditRepository1Label;
      Caption := '编号';
      Index := 1;
    end;

    with cxGrid1DBTableView1.GetColumnByFieldName('eid') do
    begin
      Visible := false;
      Caption := '展会';
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('qq') do
    begin
      Visible := false;
      Caption := 'QQ';
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('email') do
    begin
      Visible := false;
      Caption := '邮箱';
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('addr') do
    begin
      Visible := false;
      Caption := '地址';
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('company') do
    begin
      // Visible:=false;
      Caption := '公司';
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('telphone') do
    begin
      Visible := false;
      Caption := '电话';
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('customertype') do
    begin
      // Visible:=false;
      RepositoryItem := customertypecxEditRepository1ComboBoxItem1;
      HeaderAlignmentHorz := taCenter;
      Caption := '客户类型';
      index := 2;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('standnumber') do
    begin
      // Visible:=false;
      Caption := '展位号';
      index := 3;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('name') do
    begin
      // Visible:=false;
      Caption := '姓名';
      index := 4;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('mobilephone') do
    begin
      // Visible:=false;
      Caption := '手机';
      index := 5;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('paytype') do
    begin
      // Visible:=false;
      Caption := '支付类型';
      index := 6;
      RepositoryItem := paytypecxEditRepository1LookupComboBoxItem;
      HeaderAlignmentHorz := taCenter;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('allpay') do
    begin
      // Visible:=false;
      Caption := '总金额';
      index := 7;
      HeaderAlignmentHorz := taRightJustify;
      RepositoryItem := cxEditRepository1CurrencyItem1;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('firstpay') do
    begin
      // Visible:=false;
      Caption := '定金';
      index := 8;
      HeaderAlignmentHorz := taRightJustify;
      RepositoryItem := cxEditRepository1CurrencyItem1;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('nowpay') do
    begin
      // Visible:=false;
      Caption := '现场支付';
      index := 9;
      HeaderAlignmentHorz := taRightJustify;
      RepositoryItem := cxEditRepository1CurrencyItem1;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('otherpay') do
    begin
      // Visible:=false;
      Caption := '剩余金额';
      index := 10;
      HeaderAlignmentHorz := taRightJustify;
      RepositoryItem := cxEditRepository1CurrencyItem1;
      Editing := false;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('customerinfo') do
    begin
      // Visible:=false;
      Caption := '客户备注';
      index := 13;
      RepositoryItem := cxEditRepository1PopupItem1;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('groupid') do
    begin
      Visible := false;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('salesname') do
    begin
      // Visible:=false;
      Caption := '招展人员';
      index := 11;
      RepositoryItem := salesnamecxEditRepository1ComboBoxItem;
      // Properties.Alignment.Horz:=taCenter;
      HeaderAlignmentHorz := taCenter;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('salesid') do
    begin
      Visible := false;
      Caption := '招展人员编号';
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('create_datetime') do
    begin
      Visible := false;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('update_datetime') do
    begin
      Visible := false;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('createtime') do
    begin
      // Visible:=false;
      RepositoryItem := cxEditRepository1DateItem;
      Options.Editing := false;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('updatetime') do
    begin
      // Visible:=false;
      RepositoryItem := cxEditRepository1DateItem;
      Options.Editing := false;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('status') do
    begin
      Visible := false;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('trash') do
    begin
      Visible := false;
    end;
  end;

end;

procedure TbplCustomerFrame.refreshmenuClick(Sender: TObject);
begin
  cxGrid1DBTableView1.DataController.RefreshExternalData;
end;

procedure TbplCustomerFrame.expocxLookupComboBoxPropertiesChange
  (Sender: TObject);
var
  s: string;
  i: Integer;
  idfooter: TcxDataSummaryItem;
begin

  s := 'and eid=' + customerDataModule.expoFDQuery.FieldByName('id').AsString;
  customerDataModule.customerOpen(s);
  customertypecxEditRepository1ComboBoxItem1PropertiesInitPopup(nil);
  salesnamecxEditRepository1ComboBoxItemPropertiesInitPopup(nil);
  customertypecxComboBox.Properties.Items.Text :=
    customerDataModule.getCustomerType.Text;
  customertypecxComboBox.ItemIndex := 0;
end;

procedure TbplCustomerFrame.fetchallmenuClick(Sender: TObject);
begin
  customerDataModule.customerOpen('');
end;

procedure TbplCustomerFrame.fetchmenuClick(Sender: TObject);
begin
  expocxLookupComboBoxPropertiesChange(nil);
end;

procedure TbplCustomerFrame.
  salesnamecxEditRepository1ComboBoxItemPropertiesEditValueChanged
  (Sender: TObject);
begin
  customerDataModule.addSales(TcxComboBox(Sender).Text);
  // showmessage(TcxComboBox(Sender).Text);
end;

procedure TbplCustomerFrame.
  salesnamecxEditRepository1ComboBoxItemPropertiesInitPopup(Sender: TObject);
begin
  salesnamecxEditRepository1ComboBoxItem.Properties.Items.Text :=
    customerDataModule.getSalesName.Text;
end;

procedure TbplCustomerFrame.softremovemenuClick(Sender: TObject);
begin
  customerDataModule.softremovecurr;
end;

procedure TbplCustomerFrame.toexcelmenuClick(Sender: TObject);
begin
  CxGridToExcel(cxGrid1);
end;

end.
