object customerDataModule: TcustomerDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 430
  Width = 615
  object customerFDQuery: TFDQuery
    AfterOpen = customerFDQueryAfterOpen
    OnCalcFields = customerFDQueryCalcFields
    FieldOptions.AutoCreateMode = acCombineAlways
    FieldOptions.PositionMode = poFirst
    AfterGetRecord = customerFDQueryAfterGetRecord
    FetchOptions.AssignedValues = [evMode]
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      
        'select * from jhlh_pmis_customers where status=1 and trash=0 !ei' +
        'd')
    Left = 232
    Top = 80
    MacroData = <
      item
        Value = Null
        Name = 'EID'
      end>
    object customerFDQuerycreatetime: TDateField
      DisplayLabel = #30331#35760#26085#26399
      FieldKind = fkInternalCalc
      FieldName = 'createtime'
      ProviderFlags = [pfInWhere]
      OnChange = customerFDQuerycreatetimeChange
    end
    object customerFDQueryupdatetime: TDateField
      DisplayLabel = #20462#25913#26085#26399
      FieldKind = fkInternalCalc
      FieldName = 'updatetime'
      ProviderFlags = [pfInWhere]
      OnChange = customerFDQueryupdatetimeChange
    end
    object customerFDQueryotherpay: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'otherpay'
      ProviderFlags = [pfInWhere]
      ReadOnly = True
      Calculated = True
    end
  end
  object customertypeFDQuery: TFDQuery
    SQL.Strings = (
      
        'select * from jhlh_crm_customerstype where status=1 and trash=0 ' +
        'and expotypeid=:eid')
    Left = 352
    Top = 80
    ParamData = <
      item
        Name = 'EID'
        ParamType = ptInput
      end>
  end
  object customerDataSource: TDataSource
    DataSet = customerFDQuery
    Left = 232
    Top = 192
  end
  object customertypeDataSource: TDataSource
    DataSet = customertypeFDQuery
    Left = 344
    Top = 192
  end
  object salesFDQuery: TFDQuery
    BeforePost = salesFDQueryBeforePost
    SQL.Strings = (
      'select * from jhlh_hrms_sales where status=1 and trash=0')
    Left = 456
    Top = 80
  end
  object salesDataSource: TDataSource
    DataSet = salesFDQuery
    Left = 464
    Top = 192
  end
  object expoFDQuery: TFDQuery
    SQL.Strings = (
      
        'select * from jhlh_pmis_expo where status=1 and trash=0 order by' +
        ' startdate desc')
    Left = 112
    Top = 80
  end
  object expoDataSource: TDataSource
    DataSet = expoFDQuery
    Left = 104
    Top = 192
  end
  object paytypeFDQuery: TFDQuery
    SQL.Strings = (
      'select * from jhlh_pmis_paytype where status=1 and trash=0')
    Left = 544
    Top = 88
  end
  object paytypeDataSource: TDataSource
    DataSet = paytypeFDQuery
    Left = 544
    Top = 184
  end
end
