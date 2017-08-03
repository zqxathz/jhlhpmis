object bplshopperframe: Tbplshopperframe
  Left = 0
  Top = 0
  Width = 1182
  Height = 611
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 0
    Top = 366
    Width = 1182
    Height = 4
    Cursor = crVSplit
    Align = alBottom
    OnCanResize = Splitter1CanResize
    OnMoved = Splitter1Moved
    ExplicitTop = 408
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 1182
    Height = 366
    Align = alClient
    PopupMenu = PopupMenu1
    TabOrder = 0
    TabStop = False
    LookAndFeel.SkinName = ''
    object cxGrid1DBTableView1: TcxGridDBTableView
      OnKeyDown = cxGrid1DBTableView1KeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = shopperds
      DataController.KeyFieldNames = 'id'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = #24635#25968':0'
          Kind = skCount
          FieldName = 'id'
          Column = cxGrid1DBTableView1id
          VisibleForCustomization = False
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.CopyCaptionsToClipboard = False
      OptionsBehavior.CopyRecordsToClipboard = False
      OptionsBehavior.ImmediateEditor = False
      OptionsBehavior.CopyPreviewToClipboard = False
      OptionsCustomize.ColumnHiding = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsView.CellAutoHeight = True
      OptionsView.Footer = True
      OptionsView.Indicator = True
      Styles.StyleSheet = GridTableViewStyleSheetDevExpress
      object cxGrid1DBTableView1id: TcxGridDBColumn
        Caption = #32534#21495
        DataBinding.FieldName = 'id'
        PropertiesClassName = 'TcxLabelProperties'
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Filtering = False
        VisibleForCustomization = False
        Width = 51
      end
      object cxGrid1DBTableView1eid: TcxGridDBColumn
        DataBinding.FieldName = 'eid'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGrid1DBTableView1gid: TcxGridDBColumn
        DataBinding.FieldName = 'gid'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGrid1DBTableView1cardcode: TcxGridDBColumn
        DataBinding.FieldName = 'cardcode'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGrid1DBTableView1sid: TcxGridDBColumn
        Caption = #39038#23458#26469#28304
        DataBinding.FieldName = 'sid'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.KeyFieldNames = 'id'
        Properties.ListColumns = <
          item
            FieldName = 'title'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = shoppersoureceds
        Width = 89
      end
      object cxGrid1DBTableView1name: TcxGridDBColumn
        Caption = #22995#21517
        DataBinding.FieldName = 'name'
        Width = 73
      end
      object cxGrid1DBTableView1sex: TcxGridDBColumn
        Caption = #24615#21035
        DataBinding.FieldName = 'sex'
        PropertiesClassName = 'TcxLookupComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'id'
        Properties.ListColumns = <
          item
            FieldName = 'title'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = sexds
        Width = 56
      end
      object cxGrid1DBTableView1weixin: TcxGridDBColumn
        Caption = #24494#20449#21495
        DataBinding.FieldName = 'weixin'
        Width = 106
      end
      object cxGrid1DBTableView1phone: TcxGridDBColumn
        Caption = #25163#26426#21495
        DataBinding.FieldName = 'phone'
        PropertiesClassName = 'TcxMaskEditProperties'
        Properties.MaskKind = emkRegExprEx
        Properties.EditMask = '\d+'
        Properties.MaxLength = 0
        Properties.OnValidate = cxGrid1DBTableView1phonePropertiesValidate
        Width = 109
      end
      object cxGrid1DBTableView1email: TcxGridDBColumn
        Caption = #30005#23376#37038#31665
        DataBinding.FieldName = 'email'
        Width = 159
      end
      object cxGrid1DBTableView1passport: TcxGridDBColumn
        Caption = #36523#20221#35777
        DataBinding.FieldName = 'passport'
      end
      object cxGrid1DBTableView1birthday_time: TcxGridDBColumn
        Caption = #29983#26085
        DataBinding.FieldName = 'birthdaytime'
        RepositoryItem = cxEditRepository1DateItem1
        Width = 100
      end
      object cxGrid1DBTableView1chinese_birthday: TcxGridDBColumn
        Caption = #20892#21382
        DataBinding.FieldName = 'chinese_birthday'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Width = 61
      end
      object cxGrid1DBTableView1adcode: TcxGridDBColumn
        Caption = #22478#24066
        DataBinding.FieldName = 'area'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        VisibleForEditForm = bTrue
        Width = 140
      end
      object cxGrid1DBTableView1addr: TcxGridDBColumn
        Caption = #35814#32454#22320#22336
        DataBinding.FieldName = 'addr'
        Width = 162
      end
      object cxGrid1DBTableView1expiry_time: TcxGridDBColumn
        Caption = #36807#26399#26085#26399
        DataBinding.FieldName = 'expirytime'
        RepositoryItem = cxEditRepository1DateItem1
        Width = 100
      end
      object cxGrid1DBTableView1goods: TcxGridDBColumn
        Caption = #36141#20080#21830#21697
        DataBinding.FieldName = 'goods'
        Width = 230
      end
      object cxGrid1DBTableView1lastshop_time: TcxGridDBColumn
        Caption = #26368#21518#28040#36153#26085#26399
        DataBinding.FieldName = 'lastshoptime'
        RepositoryItem = cxEditRepository1DateItem2
        Width = 132
      end
      object cxGrid1DBTableView1create_time: TcxGridDBColumn
        Caption = #21019#24314#26085#26399
        DataBinding.FieldName = 'createtime'
        RepositoryItem = cxEditRepository1DateItem1
        Options.Editing = False
        Width = 100
      end
      object cxGrid1DBTableView1update_time: TcxGridDBColumn
        Caption = #26356#26032#26085#26399
        DataBinding.FieldName = 'updatetime'
        RepositoryItem = cxEditRepository1DateItem1
        Options.Editing = False
        Width = 100
      end
      object cxGrid1DBTableView1trash: TcxGridDBColumn
        DataBinding.FieldName = 'trash'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGrid1DBTableView1status: TcxGridDBColumn
        DataBinding.FieldName = 'status'
        Visible = False
        VisibleForCustomization = False
      end
      object cxGrid1DBTableView1mod: TcxGridDBColumn
        DataBinding.FieldName = 'mod'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGrid1DBTableView2: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      FilterBox.CustomizeDialog = False
      FilterBox.Visible = fvAlways
      DataController.DataSource = areads
      DataController.KeyFieldNames = 'adcode'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      object cxGrid1DBTableView2p: TcxGridDBColumn
        DataBinding.FieldName = 'p'
        Visible = False
        GroupIndex = 0
        SortIndex = 1
        SortOrder = soAscending
      end
      object cxGrid1DBTableView2c: TcxGridDBColumn
        DataBinding.FieldName = 'c'
        Visible = False
        GroupIndex = 1
        SortIndex = 0
        SortOrder = soAscending
      end
      object cxGrid1DBTableView2a: TcxGridDBColumn
        DataBinding.FieldName = 'a'
      end
      object cxGrid1DBTableView2adcode: TcxGridDBColumn
        DataBinding.FieldName = 'adcode'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object RzStatusBar1: TRzStatusBar
    Left = 0
    Top = 581
    Width = 1182
    Height = 30
    AutoStyle = False
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    DoubleBuffered = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 1
    object RzStatusPane1: TRzStatusPane
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 40
      Height = 24
      Align = alLeft
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      AutoSize = True
      Caption = #22320#21306
    end
    object RzStatusPane2: TRzStatusPane
      Left = 231
      Top = 0
      Width = 40
      Height = 30
      Align = alLeft
      AutoSize = True
      Caption = ''
    end
    object RzClockStatus1: TRzClockStatus
      Left = 1010
      Top = 0
      Width = 172
      Height = 30
      Align = alRight
      Alignment = taRightJustify
      ExplicitLeft = 1048
    end
    object RzProgressStatus1: TRzProgressStatus
      Left = 858
      Top = 0
      Width = 152
      Height = 30
      Align = alRight
      ParentShowHint = False
      PartsComplete = 0
      Percent = 0
      ShowPercent = True
      TotalParts = 0
      ExplicitLeft = 896
    end
    object RzStatusPane3: TRzStatusPane
      Left = 780
      Top = 0
      Width = 78
      Height = 30
      Align = alRight
      Alignment = taRightJustify
      AutoSize = True
      Caption = #27491#22312#23548#20986':'
      ExplicitLeft = 822
    end
    object updateareaallbutton: TButton
      Left = 46
      Top = 0
      Width = 185
      Height = 30
      Align = alLeft
      Caption = #23558#24403#21069#22478#24066#26356#26032#21040#25152#26377#35760#24405
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = False
      OnClick = updateareaallbuttonClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 370
    Width = 1182
    Height = 211
    Align = alBottom
    BevelOuter = bvNone
    Constraints.MinHeight = 211
    DockSite = True
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 2
    object Label1: TLabel
      Left = 9
      Top = 175
      Width = 85
      Height = 27
      Caption = #36141#20080#21830#21697':'
      Visible = False
    end
    object expocxLookupComboBox: TcxLookupComboBox
      Left = 100
      Top = 6
      TabStop = False
      Properties.DropDownAutoSize = True
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownSizeable = True
      Properties.KeyFieldNames = 'id'
      Properties.ListColumns = <
        item
          Caption = #24320#22987#26085#26399
          Width = 100
          FieldName = 'startdate'
        end
        item
          Caption = #23637#20250#21517#31216
          Width = 200
          FieldName = 'title'
        end
        item
          Caption = #23637#20250#22320#28857
          Width = 150
          FieldName = 'addr'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = expods
      Properties.OnChange = expocxLookupComboBoxPropertiesChange
      TabOrder = 0
      Width = 741
    end
    object phonecxMaskEdit: TcxMaskEdit
      Left = 100
      Top = 46
      Properties.MaskKind = emkRegExprEx
      Properties.EditMask = '([1])[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      Properties.OnValidate = phonecxMaskEditPropertiesValidate
      TabOrder = 1
      OnKeyPress = phonecxMaskEditKeyPress
      Width = 181
    end
    object applyButton: TButton
      Left = 945
      Top = 170
      Width = 105
      Height = 35
      Caption = #28155#21152
      TabOrder = 13
      OnClick = applyButtonClick
    end
    object shoppersourcecxLookupComboBox: TcxLookupComboBox
      Left = 953
      Top = 6
      TabStop = False
      Properties.DropDownAutoSize = True
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownSizeable = True
      Properties.KeyFieldNames = 'id'
      Properties.ListColumns = <
        item
          Caption = #26469#28304#31867#22411
          Width = 150
          FieldName = 'title'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = shoppersoureceds
      Properties.OnChange = shoppersourcecxLookupComboBoxPropertiesChange
      TabOrder = 15
      Width = 209
    end
    object StaticText1: TStaticText
      Left = 9
      Top = 10
      Width = 89
      Height = 31
      Caption = #36873#25321#23637#20250':'
      TabOrder = 16
    end
    object StaticText2: TStaticText
      Left = 862
      Top = 10
      Width = 89
      Height = 31
      Caption = #39038#23458#26469#28304':'
      TabOrder = 17
    end
    object StaticText3: TStaticText
      Left = 9
      Top = 50
      Width = 89
      Height = 31
      Caption = #25163#26426#21495#30721':'
      TabOrder = 18
    end
    object StaticText4: TStaticText
      Left = 290
      Top = 50
      Width = 49
      Height = 31
      Caption = #22995#21517':'
      TabOrder = 19
    end
    object nameedit: TEdit
      Left = 345
      Top = 47
      Width = 131
      Height = 35
      TabOrder = 2
    end
    object StaticText5: TStaticText
      Left = 484
      Top = 50
      Width = 49
      Height = 31
      Caption = #24615#21035':'
      TabOrder = 20
    end
    object sexcxLookupComboBox: TcxLookupComboBox
      Left = 539
      Top = 47
      Properties.DropDownAutoSize = True
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediateDropDownWhenActivated = True
      Properties.KeyFieldNames = 'id'
      Properties.ListColumns = <
        item
          FieldName = 'title'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = sexds
      TabOrder = 3
      Width = 71
    end
    object weixinedit: TEdit
      Left = 673
      Top = 47
      Width = 165
      Height = 35
      TabOrder = 4
    end
    object StaticText6: TStaticText
      Left = 620
      Top = 50
      Width = 49
      Height = 31
      Caption = #24494#20449':'
      TabOrder = 21
    end
    object StaticText7: TStaticText
      Left = 844
      Top = 50
      Width = 49
      Height = 31
      Caption = #37038#31665':'
      TabOrder = 22
    end
    object emailEdit: TEdit
      Left = 896
      Top = 47
      Width = 266
      Height = 35
      TabOrder = 5
    end
    object StaticText8: TStaticText
      Left = 9
      Top = 91
      Width = 89
      Height = 31
      Caption = #36523#20221#35777#21495':'
      TabOrder = 23
    end
    object passportEdit: TEdit
      Left = 100
      Top = 87
      Width = 234
      Height = 35
      TabOrder = 6
    end
    object StaticText9: TStaticText
      Left = 344
      Top = 91
      Width = 49
      Height = 31
      Caption = #29983#26085':'
      TabOrder = 24
    end
    object birtydaycxDateEdit: TcxDateEdit
      Left = 395
      Top = 88
      Properties.DateButtons = [btnClear, btnToday]
      Properties.ImmediateDropDownWhenActivated = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 7
      Width = 136
    end
    object chinesebdCheckBox: TCheckBox
      Left = 541
      Top = 96
      Width = 67
      Height = 17
      Alignment = taLeftJustify
      Caption = #20892#21382':'
      TabOrder = 8
    end
    object StaticText10: TStaticText
      Left = 621
      Top = 91
      Width = 89
      Height = 31
      Caption = #36807#26399#26085#26399':'
      TabOrder = 25
    end
    object pastcxDateEdit: TcxDateEdit
      Left = 716
      Top = 88
      Properties.ImmediateDropDownWhenActivated = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 9
      Width = 134
    end
    object StaticText11: TStaticText
      Left = 856
      Top = 91
      Width = 89
      Height = 31
      Caption = #26368#21518#28040#36153':'
      TabOrder = 26
    end
    object lastshopcxDateEdit: TcxDateEdit
      Left = 946
      Top = 88
      Properties.InputKind = ikStandard
      Properties.Kind = ckDateTime
      TabOrder = 10
      Width = 216
    end
    object StaticText12: TStaticText
      Left = 9
      Top = 131
      Width = 89
      Height = 31
      Caption = #35814#32454#22320#22336':'
      TabOrder = 27
    end
    object addrEdit: TEdit
      Left = 100
      Top = 128
      Width = 1062
      Height = 35
      TabOrder = 11
    end
    object restButton: TButton
      Left = 1056
      Top = 170
      Width = 106
      Height = 35
      Caption = #37325#32622
      TabOrder = 14
      TabStop = False
      OnClick = restButtonClick
    end
    object Edit1: TEdit
      Left = 100
      Top = 170
      Width = 653
      Height = 35
      TabOrder = 12
      Visible = False
    end
  end
  object shopperds: TDataSource
    DataSet = shopperdatamod.shopperfdquery
    Left = 816
    Top = 256
  end
  object shoppersoureceds: TDataSource
    AutoEdit = False
    DataSet = shopperdatamod.shoppersourcefdquery
    Left = 328
    Top = 312
  end
  object sexds: TDataSource
    DataSet = shopperdatamod.sexfdmemtable
    Left = 448
    Top = 272
  end
  object cxPropertiesStore1: TcxPropertiesStore
    Active = False
    Components = <
      item
        Component = cxGrid1DBTableView1adcode
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1addr
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1birthday_time
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1cardcode
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1chinese_birthday
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1create_time
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1eid
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1email
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1expiry_time
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1gid
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1id
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1lastshop_time
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1name
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1passport
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1phone
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1sex
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1sid
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1status
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1trash
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1update_time
        Properties.Strings = (
          'Width')
      end
      item
        Component = cxGrid1DBTableView1weixin
        Properties.Strings = (
          'Width')
      end
      item
        Component = Panel1
        Properties.Strings = (
          'Height')
      end>
    StorageName = 'shopper.ini'
    Left = 752
    Top = 264
  end
  object cxStyleRepository1: TcxStyleRepository
    Scalable = True
    Left = 632
    Top = 254
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 15451300
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16247513
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      TextColor = clBlack
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 16247513
      TextColor = clBlack
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clBtnFace
      TextColor = clBlack
    end
    object cxStyle5: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 14811135
      TextColor = clBlack
    end
    object cxStyle6: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 14811135
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clNavy
    end
    object cxStyle7: TcxStyle
      AssignedValues = [svColor]
      Color = 14872561
    end
    object cxStyle8: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 4707838
      TextColor = clBlack
    end
    object cxStyle9: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 12937777
      TextColor = clWhite
    end
    object cxStyle10: TcxStyle
      AssignedValues = [svColor]
      Color = 15451300
    end
    object cxStyle11: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 4707838
      TextColor = clBlack
    end
    object cxStyle12: TcxStyle
      AssignedValues = [svColor]
      Color = 15451300
    end
    object cxStyle13: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 14811135
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clNavy
    end
    object cxStyle14: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = 12937777
      TextColor = clWhite
    end
    object GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet
      Caption = 'DevExpress'
      Styles.Background = cxStyle1
      Styles.Content = cxStyle2
      Styles.ContentEven = cxStyle3
      Styles.ContentOdd = cxStyle4
      Styles.FilterBox = cxStyle5
      Styles.Inactive = cxStyle10
      Styles.IncSearch = cxStyle11
      Styles.Selection = cxStyle14
      Styles.Footer = cxStyle6
      Styles.Group = cxStyle7
      Styles.GroupByBox = cxStyle8
      Styles.Header = cxStyle9
      Styles.Indicator = cxStyle12
      Styles.Preview = cxStyle13
      BuiltIn = True
    end
  end
  object cxEditRepository1: TcxEditRepository
    Left = 744
    Top = 214
    object cxEditRepository1DateItem1: TcxEditRepositoryDateItem
      Properties.DateButtons = [btnClear, btnToday]
      Properties.DisplayFormat = 'yyyy'#24180'm'#26376'd'#26085
      Properties.EditFormat = 'yyyy'#24180'm'#26376'd'#26085
      Properties.Nullstring = #26080
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.UseNullString = True
      Properties.View = cavModern
      Properties.WeekNumbers = True
    end
    object cxEditRepository1DateItem2: TcxEditRepositoryDateItem
      Properties.DateButtons = [btnClear, btnNow, btnToday]
      Properties.DisplayFormat = 'yyyy'#24180'm'#26376'd'#26085' hh:mm'
      Properties.EditFormat = 'yyyy'#24180'm'#26376'd'#26085' hh:mm'
      Properties.ImmediatePost = True
      Properties.Kind = ckDateTime
      Properties.Nullstring = #26080
      Properties.UseNullString = True
    end
  end
  object areads: TDataSource
    DataSet = shopperdatamod.areafdquery
    Left = 384
    Top = 240
  end
  object expods: TDataSource
    DataSet = shopperdatamod.expofdquery
    Left = 528
    Top = 272
  end
  object PopupMenu1: TPopupMenu
    Left = 584
    Top = 312
    object refreshmenu: TMenuItem
      Caption = #21047#26032
      OnClick = refreshmenuClick
    end
    object deletemenu: TMenuItem
      Caption = #21024#38500#24403#21069#35760#24405
      OnClick = deletemenuClick
    end
    object copyitemmenu: TMenuItem
      Caption = #22797#21046#24403#21069#23383#27573
      OnClick = copyitemmenuClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object autowidthmenu: TMenuItem
      Caption = #33258#21160#36866#24212#23485#24230
      OnClick = autowidthmenuClick
    end
    object fetchmenu: TMenuItem
      Caption = #26174#31034#24403#21069#23637#20250
      OnClick = fetchmenuClick
    end
    object allrecordmenu: TMenuItem
      Caption = #26174#31034#25152#26377#35760#24405
      OnClick = allrecordmenuClick
    end
    object toexcelmenu: TMenuItem
      Caption = #23548#20986'EXCEL'
      OnClick = toexcelmenuClick
    end
    object fromexcelmenu: TMenuItem
      Caption = #23548#20837'EXCEL'
      OnClick = fromexcelmenuClick
    end
  end
  object XLSReadWriteII51: TXLSReadWriteII5
    ComponentVersion = '5.20.62'
    Version = xvExcel2007
    DirectRead = False
    DirectWrite = False
    Left = 1000
    Top = 200
  end
end
