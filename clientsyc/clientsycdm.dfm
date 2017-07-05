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
      'HostName=192.168.2.201'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={"ZLibCompression":{"CompressMoreThan":"1024"}}')
    Left = 336
    Top = 224
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
    Top = 312
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
end
