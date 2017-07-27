object updateDataModule: TupdateDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 357
  Width = 564
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
      'DSAuthenticationPassword=guest'
      'DSAuthenticationUser=guest'
      'CommunicationTimeout=5000'
      'ConnectTimeout=5000')
    Left = 232
    Top = 176
    UniqueId = '{6E5AB97C-42DA-4247-A88A-699B39A8154A}'
  end
  object NetHTTPClient1: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    AllowCookies = True
    HandleRedirects = True
    UserAgent = 'Embarcadero URI Client/1.0'
    OnAuthEvent = NetHTTPClient1AuthEvent
    Left = 368
    Top = 184
  end
end
