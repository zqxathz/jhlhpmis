object ServerAdminMethods: TServerAdminMethods
  OldCreateOrder = False
  Height = 513
  Width = 791
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=JHLH_MySQL')
    Left = 416
    Top = 128
  end
  object FDSchemaAdapter1: TFDSchemaAdapter
    Left = 416
    Top = 208
  end
  object memberFDQuery: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      'select * from jhlh_admin_member')
    Left = 296
    Top = 272
  end
  object groupFDQuery: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      'select * from jhlh_admin_group')
    Left = 392
    Top = 272
  end
  object methodFDQuery: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      'select * from jhlh_admin_method')
    Left = 488
    Top = 272
  end
  object customerstypeFDQuery: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      'select * from jhlh_crm_customerstype')
    Left = 296
    Top = 408
  end
  object expotypeFDQuery: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      'select * from jhlh_pmis_expotype')
    Left = 416
    Top = 408
  end
  object expoFDQuery: TFDQuery
    FieldOptions.AutoCreateMode = acCombineAlways
    CachedUpdates = True
    AfterGetRecord = expoFDQueryAfterGetRecord
    Connection = FDConnection1
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      'select * from jhlh_pmis_expo')
    Left = 184
    Top = 408
    object expoFDQuerycalstartdate: TDateField
      FieldKind = fkInternalCalc
      FieldName = 'calstartdate'
      ProviderFlags = [pfInWhere]
    end
    object expoFDQuerycalenddate: TDateField
      FieldKind = fkInternalCalc
      FieldName = 'calenddate'
    end
    object expoFDQuerycalbeforedate: TDateField
      FieldKind = fkInternalCalc
      FieldName = 'calbeforedate'
    end
    object expoFDQuerycalafterdate: TDateField
      FieldKind = fkInternalCalc
      FieldName = 'calafterdate'
    end
  end
  object shoppersourceFDQuery: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      'select * from jhlh_pmis_shopper_sourcetype')
    Left = 528
    Top = 408
  end
  object paytypeFDQuery: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    SchemaAdapter = FDSchemaAdapter1
    SQL.Strings = (
      'select * from jhlh_pmis_paytype')
    Left = 648
    Top = 408
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 632
    Top = 152
  end
  object methodDataSource: TDataSource
    DataSet = methodFDQuery
    Left = 488
    Top = 336
  end
end
