unit customer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, Vcl.ExtCtrls, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, customerdm, cxContainer,
  Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxExtEditRepositoryItems, cxCurrencyEdit, cxPropertiesStore,
  cxEditRepositoryItems, cxDBEditRepository;

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
    Button1: TButton;
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
    Edit1: TEdit;
    cxLookupComboBox1: TcxLookupComboBox;
    standnumberEdit: TEdit;
    nameEdit: TEdit;
    companyEdit: TEdit;
    emailEdit: TEdit;
    allpaycxCurrencyEdit: TcxCurrencyEdit;
    qqEdit: TEdit;
    firstpaycxCurrencyEdit: TcxCurrencyEdit;
    nowpaycxCurrencyEdit: TcxCurrencyEdit;
    paytypecxLookupComboBox: TcxLookupComboBox;
    salescxLookupComboBox: TcxLookupComboBox;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    telphonecxMaskEdit: TcxMaskEdit;
    cxEditRepository1DateItem: TcxEditRepositoryDateItem;
    paytypecxEditRepository1LookupComboBoxItem: TcxEditRepositoryLookupComboBoxItem;
    customertypecxEditRepository1ComboBoxItem1: TcxEditRepositoryComboBoxItem;
    cxEditRepository1CurrencyItem1: TcxEditRepositoryCurrencyItem;
    phonecxMaskEdit: TcxMaskEdit;
    procedure expocxLookupComboBoxPropertiesChange(Sender: TObject);
    procedure customertypecxEditRepository1ComboBoxItem1PropertiesInitPopup(
      Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

constructor TbplCustomerFrame.Create(AOwner: TComponent);
begin
  inherited;
  if customerDataModule=nil then
  begin
    customerDataModule:=TcustomerDataModule.Create(nil);
  end;
  expocxLookupComboBox.ItemIndex:=0;
end;

procedure TbplCustomerFrame.customertypecxEditRepository1ComboBoxItem1PropertiesInitPopup(
  Sender: TObject);
begin
 //showmessage('abc');
 with customertypecxEditRepository1ComboBoxItem1 do
  begin
    //Properties.Items.Clear;
    Properties.Items.Text:=customerDataModule.getCustomerType.Text;
  end;
end;

destructor TbplCustomerFrame.Destroy;
begin
  FreeAndNil(customerDataModule);
  inherited;
end;

procedure TbplCustomerFrame.expocxLookupComboBoxPropertiesChange(Sender: TObject);
var
  s:string;
  i:integer;
begin
  s:='and eid='+customerDataModule.expoFDQuery.FieldByName('id').AsString;
  customerDataModule.customerOpen(s);
  customertypecxEditRepository1ComboBoxItem1PropertiesInitPopup(nil);
  if cxGrid1DBTableView1.ColumnCount=0 then
  begin
    cxGrid1DBTableView1.DataController.CreateAllItems(True);
    with cxGrid1DBTableView1.GetColumnByFieldName('id') do
    begin
      HeaderAlignmentHorz:=taCenter;
      RepositoryItem:=IDcxEditRepository1Label;
      Caption:='编号';
      Index:=1;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('eid') do
    begin
      Visible:=false;
      Caption:='展会';
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('qq') do
    begin
      Visible:=false;
      Caption:='QQ';
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('email') do
    begin
      Visible:=false;
      Caption:='邮箱';
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('addr') do
    begin
      Visible:=false;
      Caption:='地址';
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('company') do
    begin
      //Visible:=false;
      Caption:='公司';
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('telphone') do
    begin
      Visible:=false;
      Caption:='电话';
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('customertype') do
    begin
      //Visible:=false;
      RepositoryItem:=customertypecxEditRepository1ComboBoxItem1;
      HeaderAlignmentHorz:=taCenter;
      Caption:='客户类型';
      index:=2;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('standnumber') do
    begin
      //Visible:=false;
      Caption:='展位号';
      index:=3;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('name') do
    begin
      //Visible:=false;
      Caption:='姓名';
      index:=4;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('mobilephone') do
    begin
      //Visible:=false;
      Caption:='手机';
      index:=5;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('paytype') do
    begin
      //Visible:=false;
      Caption:='支付类型';
      index:=6;
      RepositoryItem:=paytypecxEditRepository1LookupComboBoxItem;
      HeaderAlignmentHorz:=taCenter;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('allpay') do
    begin
      //Visible:=false;
      Caption:='总金额';
      index:=7;
      HeaderAlignmentHorz:=taRightJustify;
      RepositoryItem:=cxEditRepository1CurrencyItem1;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('firstpay') do
    begin
      //Visible:=false;
      Caption:='定金';
      index:=8;
      HeaderAlignmentHorz:=taRightJustify;
      RepositoryItem:=cxEditRepository1CurrencyItem1;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('nowpay') do
    begin
      //Visible:=false;
      Caption:='现场支付';
      index:=9;
      HeaderAlignmentHorz:=taRightJustify;
      RepositoryItem:=cxEditRepository1CurrencyItem1;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('customerinfo') do
    begin
      //Visible:=false;
      Caption:='客户备注';
      index:=13;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('groupid') do
    begin
      Visible:=false;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('salesname') do
    begin
      //Visible:=false;
      Caption:='招展人员';
      index:=10;
      PropertiesClass:=TcxTextEditProperties;
      Properties.Alignment.Horz:=taCenter;
      HeaderAlignmentHorz:=taCenter;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('salesid') do
    begin
      Visible:=false;
      Caption:='招展人员编号';
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('create_datetime') do
    begin
      Visible:=false;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('update_datetime') do
    begin
      Visible:=false;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('createtime') do
    begin
      //Visible:=false;
      RepositoryItem:=cxEditRepository1DateItem;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('updatetime') do
    begin
      //Visible:=false;
      RepositoryItem:=cxEditRepository1DateItem;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('status') do
    begin
      Visible:=false;
    end;
    with cxGrid1DBTableView1.GetColumnByFieldName('trash') do
    begin
      Visible:=false;
    end;

  end;
  cxGrid1DBTableView1.ApplyBestFit(nil,true);
end;

end.
