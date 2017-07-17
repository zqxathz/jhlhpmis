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
      
        'select count(id) as count from jhlh_admin_member where username=' +
        ':username and password=:password')
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
end
