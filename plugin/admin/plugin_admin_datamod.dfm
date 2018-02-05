object pluginadmindm: Tpluginadmindm
  OldCreateOrder = False
  Height = 576
  Width = 870
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
      'CommunicationTimeout=5000'
      'ConnectTimeout=5000'
      'DSAuthenticationPassword=admin'
      'DSAuthenticationUser=admin'
      'version=1'
      'DelegateConnection=DBXTrace'
      
        'DBXTrace.TraceFlags=PARAMETER;ERROR;EXECUTE;COMMAND;CONNECT;TRAN' +
        'SACT;BLOB;MISC;VENDOR;READER;DRIVER_LOAD;METADATA'
      'DBXTrace.DriverUnit=Data.DBXTrace'
      'DBXTrace.DelegateDriver=True'
      'DBXTrace.DriverName=DBXTrace'
      
        'DBXTrace.DriverPackageLoader=TDBXTraceDriverLoader,DBXCommonDriv' +
        'er250.bpl'
      
        'DBXTrace.DriverAssemblyLoader=Borland.Data.TDBXTraceDriverLoader' +
        ',Borland.Data.DbxCommonDriver,Version=24.0.0.0,Culture=neutral,P' +
        'ublicKeyToken=91d62ebb5b0d1b1b'
      'DBXTrace.TraceDriver=True'
      'DBXTrace.TraceFile=d:\1.txt')
    BeforeConnect = SQLConnection1BeforeConnect
    Left = 304
    Top = 120
    UniqueId = '{1979D81D-2E8C-4184-908F-1ABC903945B5}'
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    Left = 424
    Top = 120
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 712
    Top = 112
  end
  object methodFDMemTable: TFDMemTable
    OnCalcFields = methodFDMemTableCalcFields
    FieldOptions.AutoCreateMode = acCombineAlways
    FieldDefs = <>
    CachedUpdates = True
    IndexDefs = <>
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'aaa'
        Fields = 'methodalias'
        CaseInsFields = 'methodalias'
        Filter = 'status=1'
      end>
    IndexesActive = False
    IndexName = 'aaa'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Adapter = methodFDTableAdapter
    StoreDefs = True
    Left = 288
    Top = 240
    object methodFDMemTablemethodclass: TStringField
      FieldKind = fkCalculated
      FieldName = 'methodclass'
      Calculated = True
    end
  end
  object groupFDMemTable: TFDMemTable
    CachedUpdates = True
    Indexes = <
      item
        Active = True
        Selected = True
        Name = 'sort'
        Fields = 'sort'
        CaseInsFields = 'sort'
      end>
    IndexName = 'sort'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Adapter = groupFDTableAdapter
    Left = 416
    Top = 232
  end
  object memberFDMemTable: TFDMemTable
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Adapter = memberFDTableAdapter
    Left = 536
    Top = 232
  end
  object customertypeFDMemTable: TFDMemTable
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Adapter = customertypeFDTableAdapter
    Left = 256
    Top = 408
  end
  object expotypeFDMemTable: TFDMemTable
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Adapter = expotypeFDTableAdapter
    Left = 400
    Top = 408
  end
  object expoFDMemTable: TFDMemTable
    BeforePost = expoFDMemTableBeforePost
    FieldOptions.AutoCreateMode = acCombineAlways
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Adapter = expoFDTableAdapter
    Left = 120
    Top = 408
  end
  object paytypeFDMemTable: TFDMemTable
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Adapter = paytypeFDTableAdapter
    Left = 688
    Top = 408
  end
  object shoppersourceFDMemTable: TFDMemTable
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Adapter = shoppersourceFDTableAdapter
    Left = 544
    Top = 408
  end
  object methodFDTableAdapter: TFDTableAdapter
    SchemaAdapter = FDSchemaAdapter1
    DatSTableName = 'methodFDQuery'
    Left = 288
    Top = 304
  end
  object groupFDTableAdapter: TFDTableAdapter
    SchemaAdapter = FDSchemaAdapter1
    DatSTableName = 'groupFDQuery'
    Left = 416
    Top = 304
  end
  object memberFDTableAdapter: TFDTableAdapter
    SchemaAdapter = FDSchemaAdapter1
    DatSTableName = 'memberFDQuery'
    Left = 536
    Top = 304
  end
  object expoFDTableAdapter: TFDTableAdapter
    SchemaAdapter = FDSchemaAdapter1
    DatSTableName = 'expoFDQuery'
    Left = 112
    Top = 480
  end
  object customertypeFDTableAdapter: TFDTableAdapter
    SchemaAdapter = FDSchemaAdapter1
    DatSTableName = 'customerstypeFDQuery'
    Left = 256
    Top = 480
  end
  object expotypeFDTableAdapter: TFDTableAdapter
    SchemaAdapter = FDSchemaAdapter1
    DatSTableName = 'expotypeFDQuery'
    Left = 400
    Top = 480
  end
  object shoppersourceFDTableAdapter: TFDTableAdapter
    SchemaAdapter = FDSchemaAdapter1
    DatSTableName = 'shoppersourceFDQuery'
    Left = 536
    Top = 480
  end
  object paytypeFDTableAdapter: TFDTableAdapter
    SchemaAdapter = FDSchemaAdapter1
    DatSTableName = 'paytypeFDQuery'
    Left = 684
    Top = 480
  end
end
