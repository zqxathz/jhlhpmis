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
      'Port=8082'
      'CommunicationProtocol=http'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
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
    Left = 448
    Top = 224
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 472
    Top = 312
  end
  object DataSource1: TDataSource
    Left = 272
    Top = 312
  end
end
