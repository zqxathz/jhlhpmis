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
    Left = 328
    Top = 160
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = '/lib64/mysql/libmysqlclient.so'
    Left = 120
    Top = 176
  end
  object expoFDQuery: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData, rvStoreMergeMeta]
    SQL.Strings = (
      
        'select * from jhlh_pmis_expo where status=1 and trash=0 and clie' +
        'ntvisable=1')
    Left = 328
    Top = 256
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 200
    Top = 176
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
    Left = 208
    Top = 240
  end
end
