object loginframe: Tloginframe
  Left = 0
  Top = 0
  Width = 500
  Height = 400
  TabOrder = 0
  DesignSize = (
    500
    400)
  object GroupBox1: TGroupBox
    Left = 106
    Top = 107
    Width = 292
    Height = 174
    Anchors = []
    Caption = #31995#32479#30331#24405
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 39
      Width = 67
      Height = 24
      Caption = #29992#25143#21517':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 24
      Top = 77
      Width = 67
      Height = 24
      Caption = #23494#12288#30721':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object usernameedit: TEdit
      Left = 97
      Top = 36
      Width = 170
      Height = 32
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'admin'
    end
    object passwordedit: TEdit
      Left = 97
      Top = 74
      Width = 170
      Height = 32
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 1
      Text = 'admin'
    end
    object Panel1: TPanel
      Left = 2
      Top = 131
      Width = 288
      Height = 41
      Align = alBottom
      Caption = 'Panel1'
      ParentBackground = False
      ShowCaption = False
      TabOrder = 2
      object loginbutton: TButton
        Left = 1
        Top = 1
        Width = 192
        Height = 39
        Align = alLeft
        Caption = #30331#24405
        TabOrder = 0
        OnClick = loginbuttonClick
      end
      object syncmemberButton: TButton
        Left = 192
        Top = 1
        Width = 95
        Height = 39
        Align = alRight
        Caption = #21516#27493#29992#25143
        TabOrder = 1
        OnClick = syncmemberButtonClick
      end
    end
  end
end
