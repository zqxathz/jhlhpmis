object clientsycDataModule: TclientsycDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 430
  Width = 623
  object SQLConnection1: TSQLConnection
    DriverName = 'DataSnap'
    KeepConnection = False
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=www.jhlotus.com'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={"ZLibCompression":{"CompressMoreThan":"1024"}}'
      'ConnectTimeout=5000'
      'CommunicationTimeout=5000'
      'CommunicationIPVersion=IP_IPv4'
      'DSAuthenticationPassword=admin'
      'DSAuthenticationUser=admin')
    Left = 336
    Top = 104
    UniqueId = '{E47C037B-B7E9-48D8-9E96-81BB9D31ED96}'
  end
  object expoFDQuery: TFDQuery
    CachedUpdates = True
    ResourceOptions.AssignedValues = [rvPersistent, rvStoreMergeData, rvStoreMergeMeta]
    ResourceOptions.StoreMergeData = dmDataSet
    ResourceOptions.StoreMergeMeta = mmAdd
    UpdateOptions.AssignedValues = [uvUpdateChngFields]
    UpdateOptions.UpdateChangedFields = False
    SQL.Strings = (
      'select * from jhlh_pmis_expo ')
    Left = 344
    Top = 320
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 472
    Top = 328
  end
  object customertypeFDQuery: TFDQuery
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode, evAutoFetchAll]
    FetchOptions.Mode = fmManual
    FetchOptions.AutoFetchAll = afDisable
    SQL.Strings = (
      'select * from jhlh_crm_customerstype')
    Left = 248
    Top = 320
  end
  object paytypeFDQuery: TFDQuery
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode, evAutoFetchAll]
    FetchOptions.Mode = fmManual
    FetchOptions.AutoFetchAll = afDisable
    SQL.Strings = (
      'select * from jhlh_pmis_paytype')
    Left = 144
    Top = 320
  end
  object expotypeFDQuery: TFDQuery
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode, evAutoFetchAll]
    FetchOptions.Mode = fmManual
    FetchOptions.AutoFetchAll = afDisable
    SQL.Strings = (
      'select * from jhlh_pmis_expotype')
    Left = 56
    Top = 320
  end
  object shoppersourceFDQuery: TFDQuery
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode, evAutoFetchAll]
    FetchOptions.Mode = fmManual
    FetchOptions.AutoFetchAll = afDisable
    SQL.Strings = (
      'select * from jhlh_pmis_shopper_sourcetype')
    Left = 56
    Top = 256
  end
  object memberFDQuery: TFDQuery
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode, evAutoFetchAll]
    FetchOptions.Mode = fmManual
    FetchOptions.AutoFetchAll = afDisable
    SQL.Strings = (
      'select * from jhlh_admin_member')
    Left = 200
    Top = 248
  end
  object removecustomerFDCommand: TFDCommand
    CommandText.Strings = (
      
        'delete from jhlh_pmis_customers where update_microsecond not in ' +
        '(select maxid from (select max(update_microsecond) as maxid from' +
        ' jhlh_pmis_customers group by uuid) b);'
      
        'delete from jhlh_pmis_customers where eid not in (select id from' +
        ' jhlh_pmis_expo where jhlh_pmis_expo.status=1 or jhlh_pmis_expo.' +
        'trash=0);')
    Left = 480
    Top = 216
  end
  object customerFDQuery: TFDQuery
    CachedUpdates = True
    OnUpdateError = customerFDQueryUpdateError
    ResourceOptions.AssignedValues = [rvCmdExecMode, rvPersistent, rvSilentMode, rvStoreMergeData, rvStoreMergeMeta]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    SQL.Strings = (
      'select * from jhlh_pmis_customers limit 1')
    Left = 336
    Top = 248
  end
end
