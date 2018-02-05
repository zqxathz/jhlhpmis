object pluginadminFrame: TpluginadminFrame
  Left = 0
  Top = 0
  Width = 1173
  Height = 727
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
    Height = 727
    Align = alLeft
    ActiveGroupIndex = 0
    TabOrder = 0
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    View = 8
    OptionsBehavior.Common.AllowExpandAnimation = True
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
      Action = methodsAction
    end
    object dxNavBar1Item2: TdxNavBarItem
      Action = groupAction
    end
    object dxNavBar1Item3: TdxNavBarItem
      Action = memberAction
    end
    object dxNavBar1Item4: TdxNavBarItem
      Action = expoAction
    end
    object dxNavBar1Item5: TdxNavBarItem
      Caption = #39038#23458#26469#28304
    end
    object dxNavBar1Item6: TdxNavBarItem
      Caption = #23458#25143#31867#22411
    end
    object dxNavBar1Item7: TdxNavBarItem
      Action = expotypeAction
    end
    object dxNavBar1Item8: TdxNavBarItem
      Caption = #25903#20184#31867#22411
    end
  end
  object GroupBox1: TGroupBox
    Left = 209
    Top = 0
    Width = 964
    Height = 727
    Align = alClient
    Caption = 'GroupBox1'
    TabOrder = 1
    object ScrollBox1: TScrollBox
      Left = 2
      Top = 29
      Width = 960
      Height = 355
      VertScrollBar.Smooth = True
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 0
      ExplicitHeight = 91
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 960
        Height = 355
        Align = alClient
        TabOrder = 0
        TabStop = False
        ExplicitHeight = 321
        object methodcxGrid1DBTableView: TcxGridDBTableView
          PopupMenu = PopupMenu1
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = methodDataSource
          DataController.KeyFieldNames = 'id'
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.PullFocusing = True
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object methodcxGrid1DBTableViewColumn1: TcxGridDBColumn
            DataBinding.FieldName = 'id'
            Visible = False
            VisibleForCustomization = False
          end
          object methodcxGrid1DBTableViewColumn5: TcxGridDBColumn
            Caption = #31867#21517
            DataBinding.FieldName = 'methodclass'
            Visible = False
            GroupIndex = 0
            MinWidth = 128
            Options.Editing = False
            Options.HorzSizing = False
            Options.Moving = False
            Width = 128
          end
          object methodcxGrid1DBTableViewColumn2: TcxGridDBColumn
            Caption = #26041#27861
            DataBinding.FieldName = 'methodalias'
            Options.Editing = False
            Options.Moving = False
            Width = 308
          end
          object methodcxGrid1DBTableViewColumn3: TcxGridDBColumn
            Caption = #21517#31216
            DataBinding.FieldName = 'methodtitle'
            Width = 304
          end
          object methodcxGrid1DBTableViewColumn4: TcxGridDBColumn
            Caption = #29366#24577
            DataBinding.FieldName = 'status'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            MinWidth = 80
            Options.AutoWidthSizable = False
            Options.HorzSizing = False
            Width = 80
          end
        end
        object groupcxGrid1DBTableView: TcxGridDBTableView
          PopupMenu = PopupMenu2
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = groupDataSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsView.CellEndEllipsis = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object groupcxGrid1DBTableViewColumn1: TcxGridDBColumn
            Caption = #32534#21495
            DataBinding.FieldName = 'id'
            Visible = False
            Options.Editing = False
            Options.AutoWidthSizable = False
            Options.Moving = False
            VisibleForCustomization = False
            Width = 60
          end
          object groupcxGrid1DBTableViewColumn2: TcxGridDBColumn
            Caption = #21517#31216
            DataBinding.FieldName = 'name'
            Options.Moving = False
            Width = 159
          end
          object groupcxGrid1DBTableViewColumn3: TcxGridDBColumn
            Caption = #26631#39064
            DataBinding.FieldName = 'title'
            Options.Moving = False
            Width = 242
          end
          object groupcxGrid1DBTableViewColumn4: TcxGridDBColumn
            Caption = #26435#38480
            DataBinding.FieldName = 'authmethod'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ViewStyle = vsButtonsOnly
            Properties.OnButtonClick = groupcxGrid1DBTableViewColumn4PropertiesButtonClick
            Options.Moving = False
            Width = 193
          end
          object groupcxGrid1DBTableViewColumn5: TcxGridDBColumn
            Caption = #25490#24207
            DataBinding.FieldName = 'sort'
            PropertiesClassName = 'TcxSpinEditProperties'
            Properties.MaxValue = 999.000000000000000000
            Properties.MinValue = 1.000000000000000000
            Options.AutoWidthSizable = False
            Options.Moving = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 80
          end
          object groupcxGrid1DBTableViewColumn6: TcxGridDBColumn
            Caption = #29366#24577
            DataBinding.FieldName = 'status'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            MinWidth = 94
            Options.AutoWidthSizable = False
            Options.HorzSizing = False
            Width = 94
          end
        end
        object membercxGrid1DBTableView: TcxGridDBTableView
          PopupMenu = PopupMenu3
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = memberDataSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object membercxGrid1DBTableViewColumn1: TcxGridDBColumn
            Caption = #32534#21495
            DataBinding.FieldName = 'id'
            Visible = False
            Options.Editing = False
            Options.Moving = False
            VisibleForCustomization = False
            Width = 93
          end
          object membercxGrid1DBTableViewColumn2: TcxGridDBColumn
            Caption = #20998#32452
            DataBinding.FieldName = 'groupid'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.DropDownSizeable = True
            Properties.DropDownWidth = 400
            Properties.KeyFieldNames = 'id'
            Properties.ListColumns = <
              item
                Caption = #26631#39064
                Fixed = True
                MinWidth = 64
                Width = 180
                FieldName = 'title'
              end
              item
                Caption = #20998#32452#21517#31216
                Fixed = True
                MinWidth = 64
                Width = 180
                FieldName = 'name'
              end>
            Properties.ListSource = groupDataSource
            Width = 112
          end
          object membercxGrid1DBTableViewColumn3: TcxGridDBColumn
            Caption = #29992#25143'id'
            DataBinding.FieldName = 'userid'
            Width = 74
          end
          object membercxGrid1DBTableViewColumn4: TcxGridDBColumn
            Caption = #29992#25143#21517
            DataBinding.FieldName = 'username'
            Width = 101
          end
          object membercxGrid1DBTableViewColumn5: TcxGridDBColumn
            Caption = #23494#30721
            DataBinding.FieldName = 'password'
            Width = 89
          end
          object membercxGrid1DBTableViewColumn6: TcxGridDBColumn
            Caption = #26165#31216
            DataBinding.FieldName = 'nickname'
            Width = 115
          end
          object membercxGrid1DBTableViewColumn7: TcxGridDBColumn
            Caption = #20840#21517
            DataBinding.FieldName = 'fullname'
            Width = 109
          end
          object membercxGrid1DBTableViewColumn9: TcxGridDBColumn
            Caption = #25163#26426#21495'1'
            DataBinding.FieldName = 'mobilephone1'
            Width = 147
          end
          object membercxGrid1DBTableViewColumn10: TcxGridDBColumn
            Caption = #25163#26426#21495'2'
            DataBinding.FieldName = 'mobilephone2'
            Width = 142
          end
          object membercxGrid1DBTableViewColumn8: TcxGridDBColumn
            Caption = #36523#20221#35777#21495
            DataBinding.FieldName = 'identity'
            Width = 162
          end
          object membercxGrid1DBTableViewColumn11: TcxGridDBColumn
            Caption = #30005#23376#37038#31665
            DataBinding.FieldName = 'email'
            Width = 134
          end
          object membercxGrid1DBTableViewColumn12: TcxGridDBColumn
            Caption = 'QQ'
            DataBinding.FieldName = 'qq'
            Width = 82
          end
          object membercxGrid1DBTableViewColumn13: TcxGridDBColumn
            Caption = #22320#22336
            DataBinding.FieldName = 'addr'
            Width = 105
          end
          object membercxGrid1DBTableViewColumn14: TcxGridDBColumn
            Caption = #26368#21518#30331#24405#26102#38388
            DataBinding.FieldName = 'logindatetime'
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.DateButtons = [btnClear, btnNow, btnToday]
            Properties.Kind = ckDateTime
            Width = 200
          end
          object membercxGrid1DBTableViewColumn15: TcxGridDBColumn
            Caption = #38145#23450
            DataBinding.FieldName = 'locked'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
          end
        end
        object expotypecxGrid1DBTableView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = expotypeDataSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.GroupByBox = False
          object expotypecxGrid1DBTableViewColumn1: TcxGridDBColumn
            Caption = #32534#21495
            DataBinding.FieldName = 'id'
            Options.Editing = False
            Width = 105
          end
          object expotypecxGrid1DBTableViewColumn2: TcxGridDBColumn
            Caption = #21517#31216
            DataBinding.FieldName = 'title'
            Width = 408
          end
          object expotypecxGrid1DBTableViewColumn3: TcxGridDBColumn
            Caption = #29366#24577
            DataBinding.FieldName = 'status'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Width = 103
          end
          object expotypecxGrid1DBTableViewColumn4: TcxGridDBColumn
            Caption = #36719#21024#38500
            DataBinding.FieldName = 'trash'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Width = 96
          end
        end
        object expocxGrid1DBTableView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = expoDataSource
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.EditAutoHeight = eahRow
          OptionsView.CellAutoHeight = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object expocxGrid1DBTableViewColumn1: TcxGridDBColumn
            Caption = #32534#21495
            DataBinding.FieldName = 'id'
            Options.Editing = False
          end
          object expocxGrid1DBTableViewColumn2: TcxGridDBColumn
            Caption = #23637#20250#31867#22411
            DataBinding.FieldName = 'expotypeid'
            PropertiesClassName = 'TcxLookupComboBoxProperties'
            Properties.DropDownListStyle = lsFixedList
            Properties.DropDownSizeable = True
            Properties.KeyFieldNames = 'id'
            Properties.ListColumns = <
              item
                Caption = #21517#31216
                FieldName = 'title'
              end>
            Properties.ListSource = expotypeDataSource
            Width = 118
          end
          object expocxGrid1DBTableViewColumn3: TcxGridDBColumn
            Caption = #23637#20250#26631#39064
            DataBinding.FieldName = 'title'
            Width = 243
          end
          object expocxGrid1DBTableViewColumn4: TcxGridDBColumn
            Caption = #23637#20250#21103#26631#39064
            DataBinding.FieldName = 'subtitle'
            Width = 231
          end
          object expocxGrid1DBTableViewColumn5: TcxGridDBColumn
            Caption = #22478#24066
            DataBinding.FieldName = 'adcode'
            Width = 136
          end
          object expocxGrid1DBTableViewColumn6: TcxGridDBColumn
            Caption = #22320#22336
            DataBinding.FieldName = 'addr'
            Width = 172
          end
          object expocxGrid1DBTableViewColumn7: TcxGridDBColumn
            DataBinding.FieldName = 'startdate'
            Visible = False
            VisibleForCustomization = False
            Width = 107
          end
          object expocxGrid1DBTableViewColumn8: TcxGridDBColumn
            DataBinding.FieldName = 'enddate'
            Visible = False
            VisibleForCustomization = False
            Width = 104
          end
          object expocxGrid1DBTableViewColumn9: TcxGridDBColumn
            DataBinding.FieldName = 'beforedate'
            Visible = False
            VisibleForCustomization = False
            Width = 107
          end
          object expocxGrid1DBTableViewColumn10: TcxGridDBColumn
            DataBinding.FieldName = 'afterdate'
            Visible = False
            VisibleForCustomization = False
            Width = 104
          end
          object expocxGrid1DBTableViewColumn16: TcxGridDBColumn
            Caption = #24320#22987#26085#26399
            DataBinding.FieldName = 'calstartdate'
            Width = 121
          end
          object expocxGrid1DBTableViewColumn17: TcxGridDBColumn
            Caption = #32467#26463#26085#26399
            DataBinding.FieldName = 'calenddate'
            Width = 130
          end
          object expocxGrid1DBTableViewColumn18: TcxGridDBColumn
            Caption = #24067#23637#26085#26399
            DataBinding.FieldName = 'calbeforedate'
            Width = 126
          end
          object expocxGrid1DBTableViewColumn19: TcxGridDBColumn
            Caption = #25764#23637#26085#26399
            DataBinding.FieldName = 'calafterdate'
            Width = 125
          end
          object expocxGrid1DBTableViewColumn11: TcxGridDBColumn
            Caption = #31616#20171
            DataBinding.FieldName = 'info'
            Width = 186
          end
          object expocxGrid1DBTableViewColumn12: TcxGridDBColumn
            Caption = #38142#25509
            DataBinding.FieldName = 'weblink'
            PropertiesClassName = 'TcxHyperLinkEditProperties'
            Width = 193
          end
          object expocxGrid1DBTableViewColumn13: TcxGridDBColumn
            Caption = #29366#24577
            DataBinding.FieldName = 'status'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Width = 52
          end
          object expocxGrid1DBTableViewColumn14: TcxGridDBColumn
            Caption = #36719#21024#38500
            DataBinding.FieldName = 'trash'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Width = 68
          end
          object expocxGrid1DBTableViewColumn15: TcxGridDBColumn
            Caption = #23458#25143#31471#26174#31034
            DataBinding.FieldName = 'clientvisable'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            Width = 114
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = expocxGrid1DBTableView
        end
      end
    end
    object Panel1: TPanel
      Left = 2
      Top = 686
      Width = 960
      Height = 39
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel1'
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      DesignSize = (
        960
        39)
      object Button1: TButton
        Left = 742
        Top = 2
        Width = 115
        Height = 31
        Action = postdataAction
        Anchors = [akRight, akBottom]
        Caption = #20445#23384#35774#32622
        TabOrder = 0
      end
      object Button2: TButton
        Left = 870
        Top = 2
        Width = 75
        Height = 31
        Anchors = [akRight, akBottom]
        Caption = #20851#38381
        TabOrder = 1
      end
    end
    object PageControl1: TPageControl
      Left = 2
      Top = 384
      Width = 960
      Height = 302
      ActivePage = TabSheet1
      Align = alBottom
      TabOrder = 2
      TabPosition = tpBottom
      object TabSheet1: TTabSheet
        Caption = 'TabSheet1'
        ExplicitLeft = 28
        ExplicitTop = 30
        ExplicitWidth = 879
        ExplicitHeight = 326
        object expomgPanel: TPanel
          Left = 0
          Top = 7
          Width = 952
          Height = 255
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'expomgPanel'
          ParentBackground = False
          ShowCaption = False
          TabOrder = 0
          ExplicitLeft = 2
          ExplicitTop = 120
          ExplicitWidth = 960
          object expotypePanel: TPanel
            Left = 4
            Top = 28
            Width = 960
            Height = 53
            BevelOuter = bvNone
            Caption = 'expotypePanel'
            ParentBackground = False
            ShowCaption = False
            TabOrder = 0
            object Label17: TLabel
              Left = 16
              Top = 8
              Width = 45
              Height = 27
              Caption = #21517#31216':'
            end
            object expotypenameEdit: TEdit
              Left = 67
              Top = 6
              Width = 209
              Height = 35
              TabOrder = 0
            end
            object expotypeaddButton: TButton
              Left = 653
              Top = 22
              Width = 75
              Height = 25
              Action = expotypeaddAction
              TabOrder = 1
            end
            object expotyperesetButton: TButton
              Left = 734
              Top = 22
              Width = 75
              Height = 25
              Action = expotyperesetAction
              TabOrder = 2
            end
          end
          object expoPanel: TPanel
            Left = 0
            Top = 14
            Width = 960
            Height = 243
            BevelOuter = bvNone
            Caption = 'expoPanel'
            ParentBackground = False
            ShowCaption = False
            TabOrder = 1
            Visible = False
            object Label18: TLabel
              Left = 12
              Top = 11
              Width = 45
              Height = 27
              Caption = #31867#22411':'
            end
            object Label19: TLabel
              Left = 309
              Top = 7
              Width = 45
              Height = 27
              Caption = #20250#26631':'
            end
            object Label20: TLabel
              Left = 289
              Top = 49
              Width = 65
              Height = 27
              Caption = #21103#20250#26631':'
            end
            object Label21: TLabel
              Left = 12
              Top = 49
              Width = 45
              Height = 27
              Caption = #22478#24066':'
            end
            object Label22: TLabel
              Left = 309
              Top = 91
              Width = 45
              Height = 27
              Caption = #22320#28857':'
            end
            object Label23: TLabel
              Left = 12
              Top = 132
              Width = 45
              Height = 27
              Caption = #24320#23637':'
            end
            object Label24: TLabel
              Left = 282
              Top = 130
              Width = 45
              Height = 27
              Caption = #38381#23637':'
            end
            object Label25: TLabel
              Left = 12
              Top = 169
              Width = 45
              Height = 27
              Caption = #24067#23637':'
            end
            object Label26: TLabel
              Left = 282
              Top = 169
              Width = 45
              Height = 27
              Caption = #25764#23637':'
            end
            object Label27: TLabel
              Left = 545
              Top = 132
              Width = 45
              Height = 27
              Caption = #31616#20171':'
            end
            object Label28: TLabel
              Left = 12
              Top = 208
              Width = 45
              Height = 27
              Caption = #38142#25509':'
            end
            object expotitleEdit: TEdit
              Left = 360
              Top = 8
              Width = 529
              Height = 35
              TabOrder = 0
            end
            object subtitleEdit: TEdit
              Left = 360
              Top = 48
              Width = 529
              Height = 35
              TabOrder = 1
            end
            object expotypecxLookupComboBox: TcxLookupComboBox
              Left = 63
              Top = 6
              Properties.ListColumns = <>
              TabOrder = 2
              Width = 212
            end
            object areacxButtonEdit: TcxButtonEdit
              Left = 63
              Top = 46
              Properties.Buttons = <
                item
                  Default = True
                  Kind = bkEllipsis
                end>
              TabOrder = 3
              Width = 212
            end
            object expoaddrEdit: TEdit
              Left = 360
              Top = 88
              Width = 529
              Height = 35
              TabOrder = 4
            end
            object startdatecxDateEdit: TcxDateEdit
              Left = 63
              Top = 127
              TabOrder = 5
              Width = 212
            end
            object enddatecxDateEdit: TcxDateEdit
              Left = 333
              Top = 127
              TabOrder = 6
              Width = 205
            end
            object befordatecxDateEdit: TcxDateEdit
              Left = 63
              Top = 167
              TabOrder = 7
              Width = 212
            end
            object afterdatecxDateEdit: TcxDateEdit
              Left = 333
              Top = 167
              TabOrder = 8
              Width = 205
            end
            object expoaddButton: TButton
              Left = 733
              Top = 214
              Width = 75
              Height = 25
              Caption = 'expoaddButton'
              TabOrder = 9
            end
            object exporesetButton: TButton
              Left = 814
              Top = 214
              Width = 75
              Height = 25
              Caption = 'Button3'
              TabOrder = 10
            end
            object infoMemo: TMemo
              Left = 596
              Top = 127
              Width = 293
              Height = 75
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -14
              Font.Name = #24494#36719#38597#40657
              Font.Style = []
              ParentFont = False
              ScrollBars = ssVertical
              TabOrder = 11
            end
            object clientvisiableCheckBox: TCheckBox
              Left = 561
              Top = 218
              Width = 132
              Height = 17
              Caption = #23458#25143#31471#26174#31034
              Checked = True
              State = cbChecked
              TabOrder = 12
            end
            object weblinkEdit: TEdit
              Left = 63
              Top = 208
              Width = 475
              Height = 35
              TabOrder = 13
            end
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'TabSheet2'
        ImageIndex = 1
        ExplicitWidth = 633
        ExplicitHeight = 326
        object groupPanel: TPanel
          Left = 0
          Top = 167
          Width = 952
          Height = 95
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'groupPanel'
          ParentBackground = False
          ShowCaption = False
          TabOrder = 0
          Visible = False
          ExplicitLeft = 2
          ExplicitTop = 375
          ExplicitWidth = 960
          object Label1: TLabel
            Left = 16
            Top = 11
            Width = 45
            Height = 27
            Caption = #32452#21517':'
          end
          object Label2: TLabel
            Left = 282
            Top = 11
            Width = 45
            Height = 27
            Caption = #21035#21517':'
          end
          object Label3: TLabel
            Left = 541
            Top = 11
            Width = 45
            Height = 27
            Caption = #25490#24207':'
          end
          object Label4: TLabel
            Left = 16
            Top = 55
            Width = 45
            Height = 27
            Caption = #26435#38480':'
          end
          object nameEdit: TEdit
            Left = 67
            Top = 8
            Width = 209
            Height = 35
            TabOrder = 0
          end
          object titleEdit: TEdit
            Left = 333
            Top = 8
            Width = 196
            Height = 35
            TabOrder = 1
          end
          object sortSpinEdit: TSpinEdit
            Left = 600
            Top = 8
            Width = 97
            Height = 37
            MaxValue = 999
            MinValue = 1
            TabOrder = 2
            Value = 100
          end
          object statusCheckBox: TCheckBox
            Left = 712
            Top = 16
            Width = 65
            Height = 17
            Alignment = taLeftJustify
            Caption = #29366#24577
            Checked = True
            State = cbChecked
            TabOrder = 3
          end
          object groupaddButton: TButton
            Left = 653
            Top = 62
            Width = 75
            Height = 25
            Action = groupaddAction
            TabOrder = 4
          end
          object Button4: TButton
            Left = 530
            Top = 53
            Width = 64
            Height = 34
            Caption = #36873#25321
            TabOrder = 5
            OnClick = Button4Click
          end
          object groupresetButton: TButton
            Left = 734
            Top = 62
            Width = 75
            Height = 25
            Action = groupresetAction
            TabOrder = 6
          end
          object authmethodComboBox: TComboBox
            Left = 67
            Top = 52
            Width = 463
            Height = 35
            AutoCloseUp = True
            Style = csDropDownList
            TabOrder = 7
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'TabSheet3'
        ImageIndex = 2
        ExplicitWidth = 919
        ExplicitHeight = 372
        object memberPanel: TPanel
          Left = 0
          Top = 46
          Width = 952
          Height = 216
          Align = alBottom
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          Visible = False
          ExplicitLeft = 2
          ExplicitTop = 470
          ExplicitWidth = 960
          object Label5: TLabel
            Left = 16
            Top = 11
            Width = 45
            Height = 27
            Caption = #20998#32452':'
          end
          object Label6: TLabel
            Left = 315
            Top = 11
            Width = 65
            Height = 27
            Caption = #29992#25143#21517':'
          end
          object Label7: TLabel
            Left = 619
            Top = 11
            Width = 45
            Height = 27
            Caption = #23494#30721':'
          end
          object Label8: TLabel
            Left = 16
            Top = 51
            Width = 63
            Height = 27
            Caption = #29992#25143'id:'
          end
          object Label9: TLabel
            Left = 335
            Top = 51
            Width = 45
            Height = 27
            Caption = #26165#31216':'
          end
          object Label10: TLabel
            Left = 619
            Top = 51
            Width = 45
            Height = 27
            Caption = #20840#21517':'
          end
          object Label11: TLabel
            Left = 16
            Top = 92
            Width = 77
            Height = 27
            Caption = #25163#26426#21495'1:'
          end
          object Label12: TLabel
            Left = 303
            Top = 94
            Width = 77
            Height = 27
            Caption = #25163#26426#21495'2:'
          end
          object Label13: TLabel
            Left = 599
            Top = 92
            Width = 65
            Height = 27
            Caption = #36523#20221#35777':'
          end
          object Label14: TLabel
            Left = 16
            Top = 133
            Width = 45
            Height = 27
            Caption = #37038#31665':'
          end
          object Label15: TLabel
            Left = 343
            Top = 132
            Width = 37
            Height = 27
            Caption = 'QQ:'
          end
          object Label16: TLabel
            Left = 16
            Top = 171
            Width = 45
            Height = 27
            Caption = #22320#22336':'
          end
          object usernameEdit: TEdit
            Left = 386
            Top = 7
            Width = 209
            Height = 35
            TabOrder = 1
          end
          object useridEdit: TEdit
            Left = 99
            Top = 48
            Width = 198
            Height = 35
            TabOrder = 3
          end
          object groupcxLookupComboBox: TcxLookupComboBox
            Left = 67
            Top = 7
            Properties.DropDownListStyle = lsFixedList
            Properties.DropDownWidth = 400
            Properties.KeyFieldNames = 'id'
            Properties.ListColumns = <
              item
                Caption = #26631#39064
                Width = 150
                FieldName = 'title'
              end
              item
                Caption = #21517#31216
                FieldName = 'name'
              end>
            Properties.ListSource = groupDataSource
            TabOrder = 0
            Width = 230
          end
          object passwordEdit: TEdit
            Left = 670
            Top = 7
            Width = 209
            Height = 35
            TabOrder = 2
          end
          object nicknameEdit: TEdit
            Left = 386
            Top = 47
            Width = 209
            Height = 35
            TabOrder = 4
          end
          object fullnameEdit: TEdit
            Left = 670
            Top = 47
            Width = 209
            Height = 35
            TabOrder = 5
          end
          object phone1Edit: TEdit
            Left = 99
            Top = 89
            Width = 198
            Height = 35
            TabOrder = 6
          end
          object phone2Edit: TEdit
            Left = 386
            Top = 88
            Width = 209
            Height = 35
            TabOrder = 7
          end
          object identityEdit: TEdit
            Left = 670
            Top = 88
            Width = 209
            Height = 35
            TabOrder = 8
          end
          object emailEdit: TEdit
            Left = 67
            Top = 130
            Width = 230
            Height = 35
            TabOrder = 9
          end
          object qqEdit: TEdit
            Left = 386
            Top = 129
            Width = 209
            Height = 35
            NumbersOnly = True
            TabOrder = 10
          end
          object addrEdit: TEdit
            Left = 67
            Top = 170
            Width = 527
            Height = 35
            TabOrder = 11
          end
          object memberaddButton: TButton
            Left = 720
            Top = 180
            Width = 75
            Height = 25
            Action = memeberaddAction
            TabOrder = 12
          end
          object memeberresetButton: TButton
            Left = 801
            Top = 180
            Width = 75
            Height = 25
            Action = memeberresetAction
            TabOrder = 13
            TabStop = False
          end
        end
      end
    end
  end
  object ActionList1: TActionList
    Left = 16
    Top = 544
    object methodsAction: TAction
      Caption = #33410#28857#31649#29702
      OnExecute = methodsActionExecute
    end
    object groupAction: TAction
      Caption = #20998#32452#31649#29702
      OnExecute = groupActionExecute
    end
    object memberAction: TAction
      Caption = #29992#25143#31649#29702
      OnExecute = memberActionExecute
    end
    object postdataAction: TAction
      Caption = #20445#23384
      OnExecute = postdataActionExecute
    end
    object groupaddAction: TAction
      Category = 'group'
      Caption = #22686#21152
      OnExecute = groupaddActionExecute
    end
    object groupresetAction: TAction
      Category = 'group'
      Caption = #37325#32622
      OnExecute = groupresetActionExecute
    end
    object groupclassallAction: TAction
      Category = 'group'
      Caption = #36873#25321#24403#21069#31867#25152#26377
      OnExecute = groupclassallActionExecute
    end
    object groupclassnoallAction: TAction
      Category = 'group'
      Caption = #21462#28040#24403#21069#31867#25152#26377
      OnExecute = groupclassnoallActionExecute
    end
    object memeberaddAction: TAction
      Category = 'memeber'
      Caption = #22686#21152
      OnExecute = memeberaddActionExecute
    end
    object memeberresetAction: TAction
      Category = 'memeber'
      Caption = #37325#32622
      OnExecute = memeberresetActionExecute
    end
    object groupdeleteAction: TAction
      Category = 'group'
      Caption = #21024#38500#24403#21069#35760#24405
      OnExecute = groupdeleteActionExecute
    end
    object groupundoAction: TAction
      Category = 'group'
      Caption = #24674#22797#19978#19968#27425#25805#20316
      OnExecute = groupundoActionExecute
    end
    object memberdeleteAction: TAction
      Category = 'memeber'
      Caption = #21024#38500#24403#21069#35760#24405
      OnExecute = memberdeleteActionExecute
    end
    object memeberundoAction: TAction
      Category = 'memeber'
      Caption = #24674#22797#19978#19968#27425#25805#20316
      OnExecute = memeberundoActionExecute
    end
    object memebergroupAction: TAction
      Category = 'memeber'
      Caption = #20998#32452#26174#31034
      OnExecute = memebergroupActionExecute
    end
    object expotypeAction: TAction
      Caption = #23637#20250#31867#22411
      OnExecute = expotypeActionExecute
    end
    object expoAction: TAction
      Caption = #23637#20250#20449#24687
      OnExecute = expotypeActionExecute
    end
    object expotypeaddAction: TAction
      Category = 'expotype'
      Caption = #22686#21152
    end
    object expotyperesetAction: TAction
      Category = 'expotype'
      Caption = #37325#32622
    end
  end
  object methodDataSource: TDataSource
    DataSet = pluginadmindm.methodFDMemTable
    Left = 88
    Top = 440
  end
  object groupDataSource: TDataSource
    DataSet = pluginadmindm.groupFDMemTable
    Left = 168
    Top = 432
  end
  object PopupMenu1: TPopupMenu
    Left = 24
    Top = 360
    object N1: TMenuItem
      Action = groupclassallAction
    end
    object N2: TMenuItem
      Action = groupclassnoallAction
    end
  end
  object memberDataSource: TDataSource
    DataSet = pluginadmindm.memberFDMemTable
    Left = 16
    Top = 440
  end
  object PopupMenu2: TPopupMenu
    Left = 88
    Top = 368
    object groupdeleteMenu: TMenuItem
      Action = groupdeleteAction
    end
    object groupundomenu: TMenuItem
      Action = groupundoAction
    end
  end
  object PopupMenu3: TPopupMenu
    Left = 152
    Top = 360
    object memberdeletemenu: TMenuItem
      Action = memberdeleteAction
    end
    object memberundomenu: TMenuItem
      Action = memeberundoAction
    end
    object membergroupmenu: TMenuItem
      Action = memebergroupAction
    end
  end
  object expoDataSource: TDataSource
    DataSet = pluginadmindm.expoFDMemTable
    Left = 32
    Top = 496
  end
  object expotypeDataSource: TDataSource
    DataSet = pluginadmindm.expotypeFDMemTable
    Left = 128
    Top = 496
  end
end
