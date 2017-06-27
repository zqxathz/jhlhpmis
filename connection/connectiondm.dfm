object connectionDataModule: TconnectionDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 323
  Width = 483
  object mainFDConnection: TFDConnection
    Params.Strings = (
      'StringFormat=Unicode'
      'LockingMode=Exclusive'
      'Synchronous=Off'
      'DriverID=jhqlSQLite')
    Left = 360
    Top = 168
  end
  object mainFDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    DriverID = 'jhqlSQLite'
    Left = 224
    Top = 168
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrHourGlass
    Left = 352
    Top = 248
  end
end
