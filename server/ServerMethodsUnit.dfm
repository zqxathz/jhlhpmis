object ServerMethods: TServerMethods
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 329
  Width = 505
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=jhlh'
      'Password=EnEyMYkBTR'
      'Database=jhlh'
      'DriverID=MySQL')
    Left = 328
    Top = 160
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 208
    Top = 208
  end
end
