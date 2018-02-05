object ServerMethods: TServerMethods
  OldCreateOrder = False
  Height = 555
  Width = 984
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=JHLH_MySQL')
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
    Left = 184
    Top = 400
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 144
    Top = 256
  end
  object customertypeFDQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from jhlh_crm_customerstype where status=1 and trash=0')
    Left = 512
    Top = 400
  end
  object paytypeFDQuery: TFDQuery
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData, rvStoreMergeMeta]
    ResourceOptions.StoreMergeData = dmDataAppend
    ResourceOptions.StoreMergeMeta = mmAdd
    SQL.Strings = (
      'select * from jhlh_pmis_paytype where status=1 and trash=0')
    Left = 744
    Top = 400
  end
  object expotypeFDQuery: TFDQuery
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData, rvStoreMergeMeta]
    ResourceOptions.StoreMergeData = dmDataAppend
    ResourceOptions.StoreMergeMeta = mmAdd
    SQL.Strings = (
      'select * from jhlh_pmis_expotype where status=1 and trash=0')
    Left = 624
    Top = 400
  end
  object shoppersourceFDQuery: TFDQuery
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData, rvStoreMergeMeta]
    ResourceOptions.StoreMergeData = dmDataAppend
    ResourceOptions.StoreMergeMeta = mmAdd
    SQL.Strings = (
      'select * from jhlh_pmis_shopper_sourcetype where status=1')
    Left = 288
    Top = 400
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
      'select * from jhlh_pmis_customers limit 1')
    Left = 760
    Top = 184
  end
  object shopperFDQuery: TFDQuery
    CachedUpdates = True
    OnUpdateError = customerFDQueryUpdateError
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.UpdateTableName = 'jhlh_pmis_shopper'
    SQL.Strings = (
      'select * from jhlh_pmis_shopper limit 1')
    Left = 608
    Top = 176
  end
  object ShopperRemoveFDCommand: TFDCommand
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvCmdExecMode]
    CommandText.Strings = (
      
        'delete from jhlh_pmis_shopper where id not in (select maxid from' +
        ' (select max(id) as maxid from jhlh_pmis_shopper group by phone)' +
        ' b) order by phone;')
    Left = 600
    Top = 112
  end
  object memberFDQuery: TFDQuery
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData, rvStoreMergeMeta]
    ResourceOptions.StoreMergeData = dmDataAppend
    ResourceOptions.StoreMergeMeta = mmAdd
    SQL.Strings = (
      
        'select jhlh_admin_member.*,jhlh_admin_group.name as groupname fr' +
        'om jhlh_admin_member '
      
        'join jhlh_admin_group on jhlh_admin_member.groupid=jhlh_admin_gr' +
        'oup.id'
      'where locked=0 !groupname')
    Left = 392
    Top = 400
    MacroData = <
      item
        Value = Null
        Name = 'GROUPNAME'
      end>
  end
  object CustomerRemoveFDCommand: TFDCommand
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvCmdExecMode]
    CommandText.Strings = (
      
        'delete from jhlh_pmis_customers where update_microsecond not in ' +
        '(select maxid from (select max(update_microsecond) as maxid from' +
        ' jhlh_pmis_customers group by uuid) b)')
    Left = 760
    Top = 112
  end
  object expireExpoFDQuery: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvStoreMergeData, rvStoreMergeMeta]
    SQL.Strings = (
      
        'select * from jhlh_pmis_expo where status=0 or trash=1 or client' +
        'visable=0')
    Left = 80
    Top = 400
  end
  object getcustomerFDQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select jhlh_pmis_customers.* from jhlh_pmis_customers '
      
        'JOIN jhlh_pmis_expo on jhlh_pmis_expo.id = jhlh_pmis_customers.e' +
        'id and jhlh_pmis_expo.clientvisable=1'
      '!where')
    Left = 872
    Top = 400
    MacroData = <
      item
        Value = Null
        Name = 'WHERE'
      end>
  end
  object getMemberGroupFDQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT'
      
        #9'jhlh_admin_member.id,jhlh_admin_member.groupid,jhlh_admin_membe' +
        'r.userid,jhlh_admin_member.username,jhlh_admin_member.`password`' +
        ', jhlh_admin_group.asname'
      'FROM'
      #9'jhlh_admin_member'
      
        'JOIN jhlh_admin_group ON jhlh_admin_member.groupid = jhlh_admin_' +
        'group.ID'
      
        'WHERE jhlh_admin_member.username=:username and jhlh_admin_member' +
        '.locked=0')
    Left = 872
    Top = 464
    ParamData = <
      item
        Name = 'USERNAME'
        ParamType = ptInput
      end>
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Console'
    Left = 272
    Top = 136
  end
end
