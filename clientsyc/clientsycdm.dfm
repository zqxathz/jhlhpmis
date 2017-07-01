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
      'Filters={}'
      'CommunicationTimeout=5000'
      'ConnectTimeout=5000')
    Left = 368
    Top = 200
    UniqueId = '{E47C037B-B7E9-48D8-9E96-81BB9D31ED96}'
  end
end
