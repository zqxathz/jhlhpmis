unit customerdm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Dialogs,
  System.Variants, System.DateUtils,Vcl.Forms,Windows,common;

type
  TcustomerDataModule = class(TDataModule)
    customerFDQuery: TFDQuery;
    customertypeFDQuery: TFDQuery;
    customerDataSource: TDataSource;
    customertypeDataSource: TDataSource;
    salesFDQuery: TFDQuery;
    salesDataSource: TDataSource;
    expoFDQuery: TFDQuery;
    expoDataSource: TDataSource;
    customerFDQuerycreatetime: TDateField;
    customerFDQueryupdatetime: TDateField;
    paytypeFDQuery: TFDQuery;
    paytypeDataSource: TDataSource;
    customerFDQueryotherpay: TCurrencyField;
    procedure DataModuleCreate(Sender: TObject);
    procedure customerFDQueryAfterGetRecord(DataSet: TFDDataSet);
    procedure customerFDQuerycreatetimeChange(Sender: TField);
    procedure customerFDQueryupdatetimeChange(Sender: TField);
    procedure customerFDQueryCalcFields(DataSet: TDataSet);
    procedure salesFDQueryBeforePost(DataSet: TDataSet);
    procedure customerFDQueryAfterOpen(DataSet: TDataSet);
    procedure customerFDQueryBeforePost(DataSet: TDataSet);
    private
      { Private declarations }
    public
      { Public declarations }
      procedure customerOpen(s: string);
      function getCustomerType: TStringList;
      function getSalesName: TStringList;
      procedure addSales(salesname:string);
      procedure softremovecurr;
  end;

var
  customerDataModule: TcustomerDataModule;

implementation

uses connectiondm;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

//时间戳转日期类型
function UnixDateToDateTime(const USec: Longint): TDateTime;
const
  cUnixStartDate: TDateTime = 25569.0; // 1970/01/01
begin
  Result := (USec / 86400) + cUnixStartDate;
end;

//数据模块创建
procedure TcustomerDataModule.DataModuleCreate(Sender: TObject);
begin
  if connectionDataModule <> nil then
  begin
    customerFDQuery.Connection := connectionDataModule.mainFDConnection;
    customertypeFDQuery.Connection := connectionDataModule.mainFDConnection;
    salesFDQuery.Connection := connectionDataModule.mainFDConnection;
    expoFDQuery.Connection := connectionDataModule.mainFDConnection;
    paytypeFDQuery.Connection := connectionDataModule.mainFDConnection;
  end;
  expoFDQuery.open;
  // customertypeFDQuery.open;
  salesFDQuery.open;
  paytypeFDQuery.open;
end;

function TcustomerDataModule.getCustomerType: TStringList;
begin
  Result := TStringList.Create;
  customertypeFDQuery.First;
  while not customertypeFDQuery.Eof do
  begin
    Result.Add(customertypeFDQuery.FieldByName('title').AsString);
    customertypeFDQuery.Next;
  end;
end;

procedure TcustomerDataModule.addSales(salesname:string);
var
  etypeid:integer;
begin
 if salesname.Trim='' then exit;
 etypeid:=expoFDQuery.FieldValues['expotypeid'];
 if not salesFDQuery.Locate('etypeid;name',varArrayOf([etypeid,Trim(salesname)])) then
 begin
   with salesFDQuery do
   begin
     Append;
     FieldValues['id']:=NUll;
     FieldValues['did']:=NUll;
     FieldValues['etypeid']:=etypeid;
     FieldValues['name']:=Trim(salesname);
     FieldValues['status']:=1;
     FieldValues['trash']:=0;
     Post;
   end;
 end;
end;

function TcustomerDataModule.getSalesName: TStringList;
begin
  Result := TStringList.Create;
  salesFDQuery.First;
  while not salesFDQuery.Eof do
  begin
    if expoFDQuery.FieldByName('expotypeid').AsInteger = salesFDQuery.FieldByName('etypeid').AsInteger then
         Result.Add(salesFDQuery.FieldByName('name').AsString);
    salesFDQuery.Next;
  end;
end;

procedure TcustomerDataModule.salesFDQueryBeforePost(DataSet: TDataSet);
begin
 DataSet.FieldByName('id').Required:=false;
 Dataset.FieldByName('did').Required:=False;
end;

procedure TcustomerDataModule.softremovecurr;
begin
  case MessageBox(0, '是否要删除当前记录?', '警告', MB_OKCANCEL + MB_ICONWARNING +
    MB_DEFBUTTON2) of
    IDOK:
      begin
        customerFDQuery.Edit;
        customerFDQuery.FieldValues['trash']:=1;
        customerFDQuery.Post;
        customerFDQuery.RefreshRecord();
      end;
    IDCANCEL:
      begin
        exit;
      end;
  end;
end;


procedure TcustomerDataModule.customerFDQueryAfterGetRecord(DataSet: TFDDataSet);
begin
  with customerFDQuery do
  begin
    if (FieldValues['create_datetime'] = 0) then
      FieldValues['createtime'] := null
    else
      FieldValues['createtime'] := UnixDateToDateTime(FieldValues['create_datetime']);

    if (FieldValues['update_datetime'] = 0) then
      FieldValues['updatetime'] := null
    else
      FieldValues['updatetime'] := UnixDateToDateTime(FieldValues['update_datetime']);
  end;
end;

procedure TcustomerDataModule.customerFDQueryAfterOpen(DataSet: TDataSet);
begin
DataSet.FieldByName('id').ProviderFlags:=DataSet.FieldByName('id').ProviderFlags+[pfInKey];
end;

procedure TcustomerDataModule.customerFDQueryBeforePost(DataSet: TDataSet);
begin


  if DataSet.State = dsEdit then
  begin
    DataSet.FieldByName('update_microsecond').AsLargeInt :=getmillisecond;
  end;
  if DataSet.State = dsInsert then
  begin
    DataSet.FieldByName('update_microsecond').AsLargeInt:=getmillisecond;
    Dataset.FieldByName('uuid').Value:=getuuid;
  end;
end;

procedure TcustomerDataModule.customerFDQueryCalcFields(DataSet: TDataSet);
begin

  if DataSet.FieldByName('allpay').AsCurrency > 0 then
  begin
    DataSet.FieldByName('otherpay').AsCurrency := DataSet.FieldByName('allpay').AsCurrency -
      DataSet.FieldByName('firstpay').AsCurrency - DataSet.FieldByName('nowpay').AsCurrency;
  end
  else
  begin
    DataSet.FieldByName('otherpay').AsCurrency :=0;
  end;

end;

procedure TcustomerDataModule.customerFDQuerycreatetimeChange(Sender: TField);
begin
  if (Sender.Value = null) then
    customerFDQuery.FieldValues['create_datetime'] := 0
  else
    customerFDQuery.FieldValues['create_datetime'] := DateTimeToUnix(IncHour(Sender.AsDateTime, 0));
end;

procedure TcustomerDataModule.customerFDQueryupdatetimeChange(Sender: TField);
begin
  if (Sender.Value = null) then
    customerFDQuery.FieldValues['update_datetime'] := 0
  else
    customerFDQuery.FieldValues['update_datetime'] := DateTimeToUnix(IncHour(Sender.AsDateTime, 0));
end;

procedure TcustomerDataModule.customerOpen(s: string);
begin

  // 通过参数打开customer类型表
  customertypeFDQuery.Close;
  customertypeFDQuery.Params.Items[0].Value := expoFDQuery.FieldValues['expotypeid'];
  customertypeFDQuery.open;
  // 通过宏打开customer表

  customerFDQuery.Close;
  customerFDQuery.Macros.Items[0].Value := s;
  customerFDQuery.open;


end;

end.
