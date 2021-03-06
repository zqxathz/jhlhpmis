object shopperdatamod: Tshopperdatamod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 337
  Width = 516
  object shopperfdquery: TFDQuery
    BeforeOpen = shopperfdqueryBeforeOpen
    AfterOpen = shopperfdqueryAfterOpen
    BeforePost = shopperfdqueryBeforePost
    OnUpdateRecord = shopperfdqueryUpdateRecord
    AfterApplyUpdates = shopperfdqueryAfterApplyUpdates
    AfterGetRecord = shopperfdqueryAfterGetRecord
    FetchOptions.AssignedValues = [evCursorKind]
    UpdateOptions.AssignedValues = [uvLockWait, uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'id'
    UpdateOptions.AutoIncFields = 'id'
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      'jhlh_pmis_shopper')
    Left = 224
    Top = 104
    object shopperfdqueryid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object shopperfdqueryeid: TIntegerField
      FieldName = 'eid'
      Origin = 'eid'
      Required = True
      Visible = False
    end
    object shopperfdquerygid: TIntegerField
      FieldName = 'gid'
      Origin = 'gid'
      Required = True
      Visible = False
    end
    object shopperfdquerysid: TIntegerField
      FieldName = 'sid'
      Origin = 'sid'
      Required = True
    end
    object shopperfdquerycardcode: TWideStringField
      FieldName = 'cardcode'
      Origin = 'cardcode'
      Visible = False
    end
    object shopperfdqueryname: TWideStringField
      FieldName = 'name'
      Origin = 'name'
      Required = True
      Size = 10
    end
    object shopperfdquerysex: TIntegerField
      FieldName = 'sex'
      Origin = 'sex'
      Required = True
    end
    object shopperfdqueryweixin: TWideStringField
      FieldName = 'weixin'
      Origin = 'weixin'
      Required = True
      Size = 100
    end
    object shopperfdqueryphone: TWideStringField
      FieldName = 'phone'
      Origin = 'phone'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 50
    end
    object shopperfdqueryemail: TWideStringField
      FieldName = 'email'
      Origin = 'email'
      Required = True
      Size = 100
    end
    object shopperfdquerypassport: TWideStringField
      FieldName = 'passport'
      Origin = 'passport'
      Required = True
      Size = 30
    end
    object shopperfdqueryadcode: TIntegerField
      FieldName = 'adcode'
      Origin = 'adcode'
      Required = True
    end
    object shopperfdqueryaddr: TWideStringField
      FieldName = 'addr'
      Origin = 'addr'
      Required = True
      Size = 500
    end
    object shopperfdquerychinese_birthday: TIntegerField
      FieldName = 'chinese_birthday'
      Origin = 'chinese_birthday'
    end
    object shopperfdquerytrash: TIntegerField
      FieldName = 'trash'
      Origin = 'trash'
      Required = True
      Visible = False
    end
    object shopperfdquerystatus: TIntegerField
      FieldName = 'status'
      Origin = 'status'
      Required = True
      Visible = False
    end
    object shopperfdqueryexpiry_time: TIntegerField
      FieldName = 'expiry_time'
      Origin = 'expiry_time'
      Visible = False
    end
    object shopperfdquerycreate_time: TIntegerField
      FieldName = 'create_time'
      Origin = 'create_time'
      Required = True
      Visible = False
    end
    object shopperfdqueryupdate_time: TIntegerField
      FieldName = 'update_time'
      Origin = 'update_time'
      Required = True
      Visible = False
    end
    object shopperfdquerybirthday_time: TIntegerField
      FieldName = 'birthday_time'
      Origin = 'birthday_time'
      Visible = False
    end
    object shopperfdquerylastshop_time: TIntegerField
      FieldName = 'lastshop_time'
      Origin = 'lastshop_time'
      Visible = False
    end
    object shopperfdqueryexpirytime: TDateField
      FieldKind = fkInternalCalc
      FieldName = 'expirytime'
      OnChange = shopperfdqueryexpirytimeChange
    end
    object shopperfdquerycreatetime: TDateField
      FieldKind = fkInternalCalc
      FieldName = 'createtime'
      OnChange = shopperfdquerycreatetimeChange
    end
    object shopperfdqueryupdatetime: TDateField
      FieldKind = fkInternalCalc
      FieldName = 'updatetime'
      OnChange = shopperfdqueryupdatetimeChange
    end
    object shopperfdquerybirthdaytime: TDateField
      FieldKind = fkInternalCalc
      FieldName = 'birthdaytime'
      OnChange = shopperfdquerybirthdaytimeChange
    end
    object shopperfdquerylastshoptime: TDateTimeField
      FieldKind = fkInternalCalc
      FieldName = 'lastshoptime'
      OnChange = shopperfdquerylastshoptimeChange
    end
    object shopperfdqueryarea: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'area'
    end
    object shopperfdquerygoods: TWideStringField
      FieldName = 'goods'
    end
    object shopperfdquerymod: TIntegerField
      FieldName = 'mod'
    end
  end
  object shoppersourcefdquery: TFDQuery
    Filter = 'status=1'
    FetchOptions.AssignedValues = [evUnidirectional, evCursorKind, evLiveWindowParanoic, evLiveWindowFastFirst]
    SQL.Strings = (
      
        'select * from jhlh_pmis_shopper_sourcetype order by jhlh_pmis_sh' +
        'opper_sourcetype.sort')
    Left = 96
    Top = 96
    object shoppersourcefdqueryid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object shoppersourcefdquerypid: TIntegerField
      FieldName = 'pid'
      Origin = 'pid'
      Required = True
    end
    object shoppersourcefdquerytitle: TWideStringField
      FieldName = 'title'
      Origin = 'title'
      Size = 255
    end
    object shoppersourcefdquerystatus: TIntegerField
      FieldName = 'status'
      Origin = 'status'
      Required = True
    end
    object shoppersourcefdquerymod: TWideStringField
      FieldName = 'mod'
    end
  end
  object sexfdmemtable: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'title'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 408
    Top = 64
    Content = {
      414442530F00C55D0D010000FF00010001FF02FF0304001A0000007300650078
      00660064006D0065006D007400610062006C00650005000A0000005400610062
      006C006500060000000000070000080032000000090000FF0AFF0B0400040000
      0069006400050004000000690064000C00010000000E000D000F000110000111
      000112000113000114000115000400000069006400FEFF0B04000A0000007400
      690074006C00650005000A0000007400690074006C0065000C00020000000E00
      16001700140000000F000110000111000112000113000114000115000A000000
      7400690074006C006500180014000000FEFEFF19FEFF1AFEFF1BFEFEFEFF1CFE
      FF1D1E0002000000FF1FFEFEFE0E004D0061006E0061006700650072001E0055
      0070006400610074006500730052006500670069007300740072007900120054
      00610062006C0065004C006900730074000A005400610062006C00650008004E
      0061006D006500140053006F0075007200630065004E0061006D0065000A0054
      006100620049004400240045006E0066006F0072006300650043006F006E0073
      0074007200610069006E00740073001E004D0069006E0069006D0075006D0043
      006100700061006300690074007900180043006800650063006B004E006F0074
      004E0075006C006C00140043006F006C0075006D006E004C006900730074000C
      0043006F006C0075006D006E00100053006F007500720063006500490044000E
      006400740049006E007400330032001000440061007400610054007900700065
      001400530065006100720063006800610062006C006500120041006C006C006F
      0077004E0075006C006C000800420061007300650014004F0041006C006C006F
      0077004E0075006C006C0012004F0049006E0055007000640061007400650010
      004F0049006E00570068006500720065001A004F0072006900670069006E0043
      006F006C004E0061006D00650018006400740041006E00730069005300740072
      0069006E0067000800530069007A006500140053006F00750072006300650053
      0069007A0065001C0043006F006E00730074007200610069006E0074004C0069
      0073007400100056006900650077004C006900730074000E0052006F0077004C
      006900730074001800520065006C006100740069006F006E004C006900730074
      001C0055007000640061007400650073004A006F00750072006E0061006C0012
      00530061007600650050006F0069006E0074000E004300680061006E00670065
      007300}
    object sexfdmemtableid: TIntegerField
      FieldName = 'id'
    end
    object sexfdmemtabletitle: TStringField
      FieldName = 'title'
    end
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 416
    Top = 264
  end
  object areafdquery: TFDQuery
    IndexFieldNames = 'adcode'
    FetchOptions.AssignedValues = [evMode, evCursorKind, evLiveWindowParanoic, evLiveWindowFastFirst]
    FetchOptions.Mode = fmAll
    FetchOptions.LiveWindowFastFirst = True
    SQL.Strings = (
      'SELECT'
      '  expo.title as expotitle,'
      '  expo.adcode as expoadcode,'
      #9'c.name AS p,'
      #9'b.name AS c,'
      #9'a.name AS a,'
      #9'a.adcode'
      'FROM'
      '  jhlh_pmis_expo expo'
      'LEFT'#9'JOIN area a ON expo.adcode = a.adcode'
      'LEFT JOIN area b ON a.padcode = b.adcode'
      'LEFT JOIN area c ON b.padcode = c.adcode'
      'WHERE'
      #9'a.level = 3')
    Left = 216
    Top = 176
    object areafdqueryp: TWideStringField
      FieldName = 'p'
      Origin = 'name'
      Required = True
    end
    object areafdqueryc: TWideStringField
      FieldName = 'c'
      Origin = 'name'
      ProviderFlags = []
      Required = True
    end
    object areafdquerya: TWideStringField
      FieldName = 'a'
      Origin = 'name'
      ProviderFlags = []
      Required = True
    end
    object areafdqueryadcode: TIntegerField
      FieldName = 'adcode'
      Origin = 'adcode'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object expofdquery: TFDQuery
    SQL.Strings = (
      
        'select * from jhlh_pmis_expo  where status=1 and trash=0 order b' +
        'y startdate desc')
    Left = 96
    Top = 176
    object expofdqueryid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object expofdqueryexpotypeid: TIntegerField
      FieldName = 'expotypeid'
      Origin = 'expotypeid'
      Required = True
    end
    object expofdquerytitle: TWideStringField
      FieldName = 'title'
      Origin = 'title'
      Required = True
      Size = 255
    end
    object expofdquerysubtitle: TWideStringField
      FieldName = 'subtitle'
      Origin = 'subtitle'
      Size = 255
    end
    object expofdqueryadcode: TIntegerField
      FieldName = 'adcode'
      Origin = 'adcode'
      Required = True
    end
    object expofdqueryaddr: TWideStringField
      FieldName = 'addr'
      Origin = 'addr'
      Required = True
      Size = 255
    end
    object expofdquerystartdate: TDateField
      FieldName = 'startdate'
      Origin = 'startdate'
    end
    object expofdqueryenddate: TDateField
      FieldName = 'enddate'
      Origin = 'enddate'
    end
    object expofdquerybeforedate: TDateField
      FieldName = 'beforedate'
      Origin = 'beforedate'
    end
    object expofdqueryafterdate: TDateField
      FieldName = 'afterdate'
      Origin = 'afterdate'
    end
    object expofdqueryinfo: TWideMemoField
      FieldName = 'info'
      Origin = 'info'
      BlobType = ftWideMemo
    end
    object expofdqueryweblink: TWideStringField
      FieldName = 'weblink'
      Origin = 'weblink'
      Size = 255
    end
    object expofdquerystatus: TIntegerField
      FieldName = 'status'
      Origin = 'status'
      Required = True
    end
    object expofdquerytrash: TIntegerField
      FieldName = 'trash'
      Origin = 'trash'
      Required = True
    end
  end
  object FDEventAlerter1: TFDEventAlerter
    Names.Strings = (
      'shoppers')
    Options.Kind = 'Events'
    Options.Timeout = 10000
    Options.AutoRegister = True
    OnAlert = FDEventAlerter1Alert
    Left = 352
    Top = 184
  end
  object validateFdCommand: TFDCommand
    CommandKind = skSelectForUnLock
    CommandText.Strings = (
      
        'select id from jhlh_pmis_shopper where phone=:phone and eid=:eid' +
        ' and mod=0 and status=1 and trash=0 limit 0,2')
    ParamData = <
      item
        Name = 'PHONE'
        ParamType = ptInput
      end
      item
        Name = 'EID'
        ParamType = ptInput
      end>
    Left = 80
    Top = 288
  end
  object updateshopperFDCommand: TFDCommand
    CommandKind = skUpdate
    CommandText.Strings = (
      'update jhlh_pmis_shopper set trash=1'
      
        'where phone=:phone and id<>:id and eid=:eid and trash=0 and mod=' +
        '0')
    ParamData = <
      item
        Name = 'PHONE'
        ParamType = ptInput
      end
      item
        Name = 'ID'
        ParamType = ptInput
      end
      item
        Name = 'EID'
        ParamType = ptInput
      end>
    Left = 88
    Top = 240
  end
  object softremoveFDCommand: TFDCommand
    UpdateOptions.AssignedValues = [uvLockMode]
    UpdateOptions.LockMode = lmPessimistic
    UpdateOptions.KeyFields = 'id'
    CommandKind = skUpdate
    CommandText.Strings = (
      'update jhlh_pmis_shopper set trash=1'
      'where phone in (!phone) and eid=:eid and trash=0 and'
      'id not in '
      '(select max(id) from jhlh_pmis_shopper '
      'group by phone having count(*)>1)')
    OnError = softremoveFDCommandError
    ParamData = <
      item
        Name = 'EID'
        ParamType = ptInput
      end>
    MacroData = <
      item
        Value = Null
        Name = 'PHONE'
      end>
    Left = 320
    Top = 248
  end
  object recoverdelFDCommand: TFDCommand
    CommandKind = skUpdate
    CommandText.Strings = (
      'update jhlh_pmis_shopper set trash=0'
      
        'where id = (select id from  jhlh_pmis_shopper  where phone=:phon' +
        'e and eid=:eid and trash=1 and status=1 and mod=0 order by id de' +
        'sc limit 1)')
    ParamData = <
      item
        Name = 'PHONE'
        ParamType = ptInput
      end
      item
        Name = 'EID'
        ParamType = ptInput
      end>
    Left = 200
    Top = 280
  end
end
