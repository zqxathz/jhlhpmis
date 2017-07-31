object ServerDataModule: TServerDataModule
  OldCreateOrder = False
  Height = 429
  Width = 653
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=jhlh'
      'Password=EnEyMYkBTR'
      'Database=jhlh'
      'CharacterSet=utf8'
      'DriverID=MySQL')
    Left = 336
    Top = 192
  end
  object memberFDQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'select jhlh_admin_member.id,jhlh_admin_member.groupid,jhlh_admin' +
        '_member.username,jhlh_admin_member.`password`,jhlh_admin_group.i' +
        'd,jhlh_admin_group.name'
      'from jhlh_admin_member '
      
        'join jhlh_admin_group on jhlh_admin_member.groupid=jhlh_admin_gr' +
        'oup.id'
      
        'where jhlh_admin_member.username=:username and jhlh_admin_member' +
        '.`password`=:password and jhlh_admin_member.locked=0')
    Left = 344
    Top = 272
    ParamData = <
      item
        Name = 'USERNAME'
        ParamType = ptInput
      end
      item
        Name = 'PASSWORD'
        ParamType = ptInput
      end>
  end
  object methodFDQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'select * from jhlh_admin_method where methodalias=:methodalias a' +
        'nd status=1')
    Left = 232
    Top = 272
    ParamData = <
      item
        Name = 'METHODALIAS'
        ParamType = ptInput
      end>
  end
  object groupFDQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from jhlh_admin_group where name =:name and status=1')
    Left = 440
    Top = 280
    ParamData = <
      item
        Name = 'NAME'
        ParamType = ptInput
      end>
  end
  object FDQuery: TFDQuery
    Connection = FDConnection1
    Left = 112
    Top = 256
  end
end
