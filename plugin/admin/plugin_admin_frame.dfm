object pluginadminFrame: TpluginadminFrame
  Left = 0
  Top = 0
  Width = 874
  Height = 577
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  ParentDoubleBuffered = False
  ParentFont = False
  TabOrder = 0
  object dxNavBar1: TdxNavBar
    Left = 0
    Top = 0
    Width = 209
    Height = 577
    Align = alLeft
    ActiveGroupIndex = 0
    TabOrder = 0
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    View = 8
    OptionsBehavior.Common.AllowExpandAnimation = True
    OptionsBehavior.Common.AllowMultipleGroupExpansion = False
    OptionsBehavior.Common.AllowSelectLinks = True
    OptionsStyle.DefaultStyles.GroupHeader.BackColor = clBtnFace
    OptionsStyle.DefaultStyles.GroupHeader.BackColor2 = clBtnFace
    OptionsStyle.DefaultStyles.GroupHeader.Font.Charset = DEFAULT_CHARSET
    OptionsStyle.DefaultStyles.GroupHeader.Font.Color = clBtnText
    OptionsStyle.DefaultStyles.GroupHeader.Font.Height = -16
    OptionsStyle.DefaultStyles.GroupHeader.Font.Name = #24494#36719#38597#40657
    OptionsStyle.DefaultStyles.GroupHeader.Font.Style = [fsBold]
    OptionsStyle.DefaultStyles.GroupHeader.AssignedValues = [savFont]
    OptionsStyle.DefaultStyles.Item.BackColor = clWhite
    OptionsStyle.DefaultStyles.Item.BackColor2 = clWhite
    OptionsStyle.DefaultStyles.Item.Font.Charset = DEFAULT_CHARSET
    OptionsStyle.DefaultStyles.Item.Font.Color = clWindowText
    OptionsStyle.DefaultStyles.Item.Font.Height = -15
    OptionsStyle.DefaultStyles.Item.Font.Name = #24494#36719#38597#40657
    OptionsStyle.DefaultStyles.Item.Font.Style = []
    OptionsStyle.DefaultStyles.Item.AssignedValues = [savFont]
    object dxNavBar1Group1: TdxNavBarGroup
      Caption = #26435#38480#31649#29702
      SelectedLinkIndex = -1
      TopVisibleLinkIndex = 0
      OptionsGroupControl.UseControl = True
      Links = <
        item
          Item = dxNavBar1Item1
        end
        item
          Item = dxNavBar1Item2
        end
        item
          Item = dxNavBar1Item3
        end>
    end
    object dxNavBar1Group2: TdxNavBarGroup
      Caption = #23637#20250#31649#29702
      SelectedLinkIndex = -1
      TopVisibleLinkIndex = 0
      OptionsExpansion.Expanded = False
      Links = <
        item
          Item = dxNavBar1Item7
        end
        item
          Item = dxNavBar1Item4
        end
        item
          Item = dxNavBar1Item5
        end
        item
          Item = dxNavBar1Item6
        end
        item
          Item = dxNavBar1Item8
        end>
    end
    object dxNavBar1Item1: TdxNavBarItem
      Caption = #33410#28857#31649#29702
    end
    object dxNavBar1Item2: TdxNavBarItem
      Caption = #26435#38480#31649#29702
    end
    object dxNavBar1Item3: TdxNavBarItem
      Caption = #29992#25143#31649#29702
    end
    object dxNavBar1Item4: TdxNavBarItem
      Caption = #23637#20250#20449#24687
    end
    object dxNavBar1Item5: TdxNavBarItem
      Caption = #39038#23458#26469#28304
    end
    object dxNavBar1Item6: TdxNavBarItem
      Caption = #23458#25143#31867#22411
    end
    object dxNavBar1Item7: TdxNavBarItem
      Caption = #23637#20250#31867#22411
    end
    object dxNavBar1Item8: TdxNavBarItem
      Caption = #25903#20184#31867#22411
    end
    object dxNavBar1Group1Control: TdxNavBarGroupControl
      Left = 13
      Top = 37
      Width = 183
      Height = 41
      Caption = 'dxNavBar1Group1Control'
      TabOrder = 3
      GroupIndex = 0
      OriginalHeight = 41
    end
  end
  object GroupBox1: TGroupBox
    Left = 209
    Top = 0
    Width = 665
    Height = 577
    Align = alClient
    Caption = 'GroupBox1'
    TabOrder = 1
    object cxGrid1: TcxGrid
      Left = 2
      Top = 29
      Width = 661
      Height = 332
      Align = alTop
      TabOrder = 0
      object methodcxGrid1DBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = methodcxGrid1DBTableView
      end
    end
  end
end
