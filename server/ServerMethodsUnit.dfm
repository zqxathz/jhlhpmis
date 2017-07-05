object ServerMethods: TServerMethods
  OldCreateOrder = False
  Height = 329
  Width = 505
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=jhlh'
      'Password=EnEyMYkBTR'
      'Database=jhlh'
      'CharacterSet=utf8'
      'DriverID=MySQL')
    Left = 56
    Top = 32
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = '/lib64/mysql/libmysqlclient.so'
    Left = 128
    Top = 32
  end
  object expoFDQuery: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData, rvStoreMergeMeta]
    SQL.Strings = (
      
        'select * from jhlh_pmis_expo where status=1 and trash=0 and clie' +
        'ntvisable=1')
    Left = 248
    Top = 248
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 208
    Top = 32
  end
  object customertypeFDQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from jhlh_crm_customerstype where status=1 and trash=0')
    Left = 432
    Top = 248
  end
  object paytypeFDQuery: TFDQuery
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData, rvStoreMergeMeta]
    ResourceOptions.StoreMergeData = dmDataAppend
    ResourceOptions.StoreMergeMeta = mmAdd
    SQL.Strings = (
      'select * from jhlh_pmis_paytype where status=1 and trash=0')
    Left = 168
    Top = 248
  end
  object expotypeFDQuery: TFDQuery
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData, rvStoreMergeMeta]
    ResourceOptions.StoreMergeData = dmDataAppend
    ResourceOptions.StoreMergeMeta = mmAdd
    SQL.Strings = (
      'select * from jhlh_pmis_expotype where status=1 and trash=0')
    Left = 80
    Top = 248
  end
  object shoppersourceFDQuery: TFDQuery
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData, rvStoreMergeMeta]
    ResourceOptions.StoreMergeData = dmDataAppend
    ResourceOptions.StoreMergeMeta = mmAdd
    SQL.Strings = (
      'select * from jhlh_pmis_shopper_sourcetype where status=1')
    Left = 336
    Top = 248
  end
  object customerFDQuery: TFDQuery
    OnUpdateError = customerFDQueryUpdateError
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'jhlh_pmis_customers'
    Left = 64
    Top = 128
  end
end
