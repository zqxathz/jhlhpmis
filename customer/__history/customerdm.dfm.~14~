object customerDataModule: TcustomerDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 430
  Width = 615
  object customerFDQuery: TFDQuery
    FieldOptions.AutoCreateMode = acCombineAlways
    FieldOptions.PositionMode = poFirst
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
      ReadOnly = True
    end
    object customerFDQueryupdatetime: TDateField
      DisplayLabel = #20462#25913#26085#26399
      FieldKind = fkInternalCalc
      FieldName = 'updatetime'
      ReadOnly = True
    end
  end
  object customertypeFDQuery: TFDQuery
    SQL.Strings = (
      'select * from jhlh_crm_customerstype where status=1 and trash=0')
    Left = 352
    Top = 80
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
end
