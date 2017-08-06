object bplsettingFrame: TbplsettingFrame
  Left = 0
  Top = 0
  Width = 853
  Height = 496
  BiDiMode = bdLeftToRight
  DoubleBuffered = True
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  ParentBiDiMode = False
  ParentDoubleBuffered = False
  ParentFont = False
  TabOrder = 0
  OnResize = FrameResize
  object dxNavBar1: TdxNavBar
    Left = 0
    Top = 0
    Width = 257
    Height = 496
    Align = alLeft
    ActiveGroupIndex = 0
    TabOrder = 0
    View = 19
    OptionsStyle.DefaultStyles.GroupHeader.BackColor = clBtnFace
    OptionsStyle.DefaultStyles.GroupHeader.BackColor2 = clBtnFace
    OptionsStyle.DefaultStyles.GroupHeader.Font.Charset = DEFAULT_CHARSET
    OptionsStyle.DefaultStyles.GroupHeader.Font.Color = clBtnText
    OptionsStyle.DefaultStyles.GroupHeader.Font.Height = -18
    OptionsStyle.DefaultStyles.GroupHeader.Font.Name = 'Tahoma'
    OptionsStyle.DefaultStyles.GroupHeader.Font.Style = [fsBold]
    OptionsStyle.DefaultStyles.GroupHeader.AssignedValues = [savFont]
    OptionsStyle.DefaultStyles.Item.BackColor = clWhite
    OptionsStyle.DefaultStyles.Item.BackColor2 = clWhite
    OptionsStyle.DefaultStyles.Item.Font.Charset = DEFAULT_CHARSET
    OptionsStyle.DefaultStyles.Item.Font.Color = 13395456
    OptionsStyle.DefaultStyles.Item.Font.Height = -15
    OptionsStyle.DefaultStyles.Item.Font.Name = 'Segoe UI'
    OptionsStyle.DefaultStyles.Item.Font.Style = []
    OptionsStyle.DefaultStyles.Item.AssignedValues = [savFont]
    object dxNavBar1Group1: TdxNavBarGroup
      Caption = #22522#26412#35774#32622
      SelectedLinkIndex = -1
      TopVisibleLinkIndex = 0
      Links = <
        item
          Item = dxNavBar1Item1
        end
        item
          Item = dxNavBar1Item2
        end>
    end
    object dxNavBar1Item1: TdxNavBarItem
      Action = NetSettingAction
    end
    object dxNavBar1Item2: TdxNavBarItem
      Action = softwareAction
    end
  end
  object GroupBox1: TGroupBox
    Left = 257
    Top = 0
    Width = 596
    Height = 496
    Align = alClient
    BiDiMode = bdLeftToRight
    Caption = #32593#32476#35774#32622
    Ctl3D = True
    DoubleBuffered = True
    ParentBackground = False
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentDoubleBuffered = False
    TabOrder = 1
    ExplicitLeft = 201
    ExplicitWidth = 652
    DesignSize = (
      596
      496)
    object Button1: TButton
      Left = 504
      Top = 455
      Width = 75
      Height = 25
      Action = CancelAction
      Anchors = [akRight, akBottom]
      Cancel = True
      TabOrder = 1
      ExplicitLeft = 560
    end
    object Button2: TButton
      Left = 422
      Top = 455
      Width = 75
      Height = 25
      Action = OkAction
      Anchors = [akRight, akBottom]
      TabOrder = 2
      ExplicitLeft = 478
    end
    object Button3: TButton
      Left = 341
      Top = 455
      Width = 75
      Height = 25
      Action = ApplyAction
      Anchors = [akRight, akBottom]
      TabOrder = 3
      ExplicitLeft = 397
    end
    object softwareScrollBox: TScrollBox
      Left = 3
      Top = 37
      Width = 590
      Height = 412
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 4
      ExplicitWidth = 646
    end
    object NetScrollBox: TScrollBox
      Left = 3
      Top = 37
      Width = 590
      Height = 412
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      ExplicitWidth = 646
      object ServerLabeledEdit: TLabeledEdit
        Left = 24
        Top = 40
        Width = 297
        Height = 35
        EditLabel.Width = 160
        EditLabel.Height = 27
        EditLabel.Caption = #26381#21153#22120#22495#21517#25110#22320#22336
        TabOrder = 0
        Text = 'pmis.jhlotus.com'
      end
      object PortLabeledEdit: TLabeledEdit
        Left = 336
        Top = 40
        Width = 97
        Height = 35
        EditLabel.Width = 100
        EditLabel.Height = 27
        EditLabel.Caption = #26381#21153#22120#31471#21475
        MaxLength = 5
        NumbersOnly = True
        TabOrder = 1
        Text = '211'
      end
      object UpdateServerLabeledEdit: TLabeledEdit
        Left = 24
        Top = 120
        Width = 297
        Height = 35
        EditLabel.Width = 140
        EditLabel.Height = 27
        EditLabel.Caption = #26356#26032#26381#21153#22120#22320#22336
        TabOrder = 2
        Text = 'update.jhlotus.com'
      end
      object netresetButton: TButton
        Left = 24
        Top = 176
        Width = 75
        Height = 25
        Action = netresetAction
        TabOrder = 3
      end
    end
  end
  object ActionList1: TActionList
    Left = 536
    Top = 336
    object NetSettingAction: TAction
      Caption = #32593#32476#35774#32622
      OnExecute = NetSettingActionExecute
    end
    object ApplyAction: TAction
      Caption = #24212#29992
      OnExecute = ApplyActionExecute
    end
    object CancelAction: TAction
      Caption = #21462#28040
      OnExecute = CancelActionExecute
    end
    object OkAction: TAction
      Caption = #30830#23450
      OnExecute = OkActionExecute
    end
    object softwareAction: TAction
      Caption = #36719#20214#35774#32622
      OnExecute = softwareActionExecute
    end
    object netresetAction: TAction
      Caption = #40664#35748#20540
      OnExecute = netresetActionExecute
    end
  end
end
