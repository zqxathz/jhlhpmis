object ServerMethods: TServerMethods
  OldCreateOrder = False
  Height = 555
  Width = 984
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=jhlh'
      'Password=EnEyMYkBTR'
      'Database=jhlh'
      'CharacterSet=utf8'
      'DriverID=MySQL')
    Left = 384
    Top = 168
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = '/lib64/mysql/libmysqlclient.so'
    Left = 144
    Top = 176
  end
  object expoFDQuery: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData, rvStoreMergeMeta]
    SQL.Strings = (
      
        'select * from jhlh_pmis_expo where status=1 and trash=0 and clie' +
        'ntvisable=1')
    Left = 288
    Top = 288
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 144
    Top = 256
  end
  object customertypeFDQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from jhlh_crm_customerstype where status=1 and trash=0')
    Left = 592
    Top = 288
  end
  object paytypeFDQuery: TFDQuery
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData, rvStoreMergeMeta]
    ResourceOptions.StoreMergeData = dmDataAppend
    ResourceOptions.StoreMergeMeta = mmAdd
    SQL.Strings = (
      'select * from jhlh_pmis_paytype where status=1 and trash=0')
    Left = 440
    Top = 288
  end
  object expotypeFDQuery: TFDQuery
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData, rvStoreMergeMeta]
    ResourceOptions.StoreMergeData = dmDataAppend
    ResourceOptions.StoreMergeMeta = mmAdd
    SQL.Strings = (
      'select * from jhlh_pmis_expotype where status=1 and trash=0')
    Left = 768
    Top = 296
  end
  object shoppersourceFDQuery: TFDQuery
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData, rvStoreMergeMeta]
    ResourceOptions.StoreMergeData = dmDataAppend
    ResourceOptions.StoreMergeMeta = mmAdd
    SQL.Strings = (
      'select * from jhlh_pmis_shopper_sourcetype where status=1')
    Left = 440
    Top = 408
  end
  object customerFDQuery: TFDQuery
    CachedUpdates = True
    OnUpdateError = customerFDQueryUpdateError
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData]
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.UpdateTableName = 'jhlh_pmis_customers'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'select * from jhlh_pmis_customers')
    Left = 600
    Top = 408
  end
  object shopperFDQuery: TFDQuery
    CachedUpdates = True
    OnUpdateError = customerFDQueryUpdateError
    Connection = FDConnection1
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    UpdateOptions.UpdateTableName = 'jhlh_pmis_shopper'
    SQL.Strings = (
      'select * from jhlh_pmis_shopper')
    Left = 288
    Top = 408
  end
  object ShopperRemoveFDCommand: TFDCommand
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvCmdExecMode]
    CommandText.Strings = (
      
        'delete from jhlh_pmis_shopper where id not in (select maxid from' +
        ' (select max(id) as maxid from jhlh_pmis_shopper group by phone)' +
        ' b) order by phone;')
    Left = 544
    Top = 176
  end
end
