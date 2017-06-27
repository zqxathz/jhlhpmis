unit customerdm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Dialogs,
  System.Variants, System.DateUtils;

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
    procedure DataModuleCreate(Sender: TObject);
    procedure customerFDQueryAfterGetRecord(DataSet: TFDDataSet);
    procedure customerFDQuerycreatetimeChange(Sender: TField);
    procedure customerFDQueryupdatetimeChange(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure customerOpen(s: string);
    function getCustomerType:TStringList;
  end;

var
  customerDataModule: TcustomerDataModule;

implementation

uses connectiondm;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

function UnixDateToDateTime(const USec: Longint): TDateTime;
const
  cUnixStartDate: TDateTime = 25569.0; // 1970/01/01
begin
  Result := (USec / 86400) + cUnixStartDate;
end;

procedure TcustomerDataModule.DataModuleCreate(Sender: TObject);
begin
  if connectionDataModule <> nil then
  begin
    customerFDQuery.Connection := connectionDataModule.mainFDConnection;
    customertypeFDQuery.Connection := connectionDataModule.mainFDConnection;
    salesFDQuery.Connection := connectionDataModule.mainFDConnection;
    expoFDQuery.Connection := connectionDataModule.mainFDConnection;
    paytypeFDQuery.Connection:=connectionDataModule.mainFDConnection;
  end;
  expoFDQuery.open;
  //customertypeFDQuery.open;
  salesFDQuery.open;
  paytypeFDQuery.open;
end;

function TcustomerDataModule.getCustomerType: TStringList;
begin
  Result:=TStringList.Create;
  customertypeFDQuery.First;
  while not customertypeFDQuery.Eof do
  begin
    Result.Add(customertypeFDQuery.FieldByName('title').AsString);
    customertypeFDQuery.Next;
  end;

end;

procedure TcustomerDataModule.customerFDQueryAfterGetRecord
  (DataSet: TFDDataSet);
begin
  with customerFDQuery do
  begin
    if (FieldValues['create_datetime'] = 0) then
      FieldValues['createtime'] := null
    else
      FieldValues['createtime'] :=
        UnixDateToDateTime(FieldValues['create_datetime']);

    if (FieldValues['update_datetime'] = 0) then
      FieldValues['updatetime'] := null
    else
      FieldValues['updatetime'] :=
        UnixDateToDateTime(FieldValues['update_datetime']);
  end;
end;

procedure TcustomerDataModule.customerFDQuerycreatetimeChange(Sender: TField);
begin
  if (Sender.Value = null) then
    customerFDQuery.FieldValues['create_datetime'] := 0
  else
    customerFDQuery.FieldValues['create_datetime'] :=
      DateTimeToUnix(IncHour(Sender.AsDateTime, 0));
end;

procedure TcustomerDataModule.customerFDQueryupdatetimeChange(Sender: TField);
begin
  if (Sender.Value = null) then
    customerFDQuery.FieldValues['update_datetime'] := 0
  else
    customerFDQuery.FieldValues['update_datetime'] :=
      DateTimeToUnix(IncHour(Sender.AsDateTime, 0));
end;

procedure TcustomerDataModule.customerOpen(s: string);
begin
  customerFDQuery.Close;
  customerFDQuery.Macros.Items[0].Value := s;
  // customerFDQuery.Prepare;
  customerFDQuery.open;

  customertypeFDQuery.Close;
  customertypeFDQuery.Params.Items[0].Value:=expoFDQuery.FieldValues['expotypeid'];
  customertypeFDQuery.open;
end;

end.
