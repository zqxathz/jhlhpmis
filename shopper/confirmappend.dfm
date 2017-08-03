object confirmappendForm: TconfirmappendForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #27492#25163#26426#21495#24050#32463#39046#21462#36807','#35831#30830#35748
  ClientHeight = 182
  ClientWidth = 497
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 27
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 473
    Height = 27
    Alignment = taCenter
    AutoSize = False
    Caption = '%s '#27492#25163#26426#21495#22312#26412#27425#23637#20250#24050#32463#21442#19982#36807#27963#21160
  end
  object Label2: TLabel
    Left = 88
    Top = 49
    Width = 305
    Height = 27
    Alignment = taCenter
    AutoSize = False
    Caption = #21442#19982#26085#26399#20026':%s'
  end
  object CheckBox1: TCheckBox
    Left = 152
    Top = 82
    Width = 201
    Height = 25
    Caption = #26159#21542#35201#20877#27425#21442#19982'?'
    TabOrder = 0
    OnClick = CheckBox1Click
  end
  object Button1: TButton
    Left = 174
    Top = 136
    Width = 75
    Height = 25
    Caption = #30830#23450
    Enabled = False
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 255
    Top = 136
    Width = 75
    Height = 25
    Cancel = True
    Caption = #21462#28040
    Default = True
    ModalResult = 2
    TabOrder = 2
  end
end
