object clientuploadDataModule: TclientuploadDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 477
  Width = 699
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
      'DSAuthenticationPassword=111'
      'DSAuthenticationUser=111')
    BeforeConnect = SQLConnection1BeforeConnect
    Left = 376
    Top = 232
    UniqueId = '{25A7D595-54B4-4CF8-8413-7F57E17F0D5D}'
  end
  object customerFDQuery: TFDQuery
    CachedUpdates = True
    Transaction = FDTransaction1
    SQL.Strings = (
      
        'select * from jhlh_pmis_customers where status=1 and trash=0 &ex' +
        'poids')
    Left = 280
    Top = 328
    MacroData = <
      item
        Value = ''
        Name = 'expoids'
      end>
  end
  object shopperFDQuery: TFDQuery
    CachedUpdates = True
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * from jhlh_pmis_shopper where status=1 and trash=0')
    Left = 456
    Top = 328
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 240
    Top = 272
  end
  object FDTransaction1: TFDTransaction
    Options.DisconnectAction = xdRollback
    Left = 528
    Top = 240
  end
  object setshopperautoincFDCommand: TFDCommand
    Transaction = FDTransaction1
    CommandText.Strings = (
      'update sqlite_sequence set seq=0 where name='#39'jhlh_pmis_shopper'#39)
    Left = 568
    Top = 328
  end
end
