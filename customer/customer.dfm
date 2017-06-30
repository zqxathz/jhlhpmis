object bplCustomerFrame: TbplCustomerFrame
  Left = 0
  Top = 0
  Width = 1219
  Height = 603
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 0
    Top = 317
    Width = 1219
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 0
    ExplicitWidth = 416
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 1219
    Height = 317
    Align = alClient
    PopupMenu = PopupMenu1
    TabOrder = 0
    TabStop = False
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = customerDataModule.customerDataSource
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      DataController.OnDataChanged = cxGrid1DBTableView1DataControllerDataChanged
      OptionsBehavior.ImmediateEditor = False
      OptionsData.Deleting = False
      OptionsView.Footer = True
      OptionsView.Indicator = True
      Styles.ContentEven = cxStyle1
      Styles.ContentOdd = cxStyle2
      Styles.OnGetContentStyle = cxGrid1DBTableView1StylesGetContentStyle
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 320
    Width = 1219
    Height = 283
    Align = alBottom
    BevelOuter = bvNone
    Constraints.MinHeight = 283
    TabOrder = 1
    DesignSize = (
      1219
      283)
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
      Properties.ListSource = customerDataModule.expoDataSource
      Properties.OnChange = expocxLookupComboBoxPropertiesChange
      TabOrder = 0
      Width = 741
    end
    object StaticText1: TStaticText
      Left = 9
      Top = 10
      Width = 89
      Height = 31
      Caption = #36873#25321#23637#20250':'
      TabOrder = 17
    end
    object applyButton: TButton
      Left = 968
      Top = 242
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #22686#21152
      TabOrder = 16
      OnClick = applyButtonClick
    end
    object Button2: TButton
      Left = 1049
      Top = 242
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #37325#32622
      TabOrder = 18
      TabStop = False
    end
    object StaticText2: TStaticText
      Left = 216
      Top = 51
      Width = 69
      Height = 31
      Caption = #23637#20301#21495':'
      TabOrder = 19
    end
    object StaticText3: TStaticText
      Left = 400
      Top = 51
      Width = 49
      Height = 31
      Caption = #22995#21517':'
      TabOrder = 20
    end
    object StaticText4: TStaticText
      Left = 569
      Top = 51
      Width = 49
      Height = 31
      Caption = #25163#26426':'
      TabOrder = 21
    end
    object StaticText5: TStaticText
      Left = 822
      Top = 51
      Width = 49
      Height = 31
      Caption = #20844#21496':'
      TabOrder = 22
    end
    object StaticText6: TStaticText
      Left = 9
      Top = 131
      Width = 49
      Height = 31
      Caption = #30005#35805':'
      TabOrder = 23
    end
    object StaticText7: TStaticText
      Left = 9
      Top = 51
      Width = 49
      Height = 31
      Caption = #31867#22411':'
      TabOrder = 24
    end
    object StaticText8: TStaticText
      Left = 9
      Top = 90
      Width = 69
      Height = 31
      Caption = #24635#37329#39069':'
      TabOrder = 25
    end
    object StaticText9: TStaticText
      Left = 216
      Top = 90
      Width = 49
      Height = 31
      Caption = #35746#37329':'
      TabOrder = 26
    end
    object StaticText10: TStaticText
      Left = 397
      Top = 90
      Width = 89
      Height = 31
      Caption = #29616#22330#20132#27454':'
      TabOrder = 27
    end
    object StaticText11: TStaticText
      Left = 642
      Top = 89
      Width = 89
      Height = 31
      Caption = #25903#20184#31867#22411':'
      TabOrder = 28
    end
    object StaticText12: TStaticText
      Left = 216
      Top = 131
      Width = 41
      Height = 31
      Caption = 'QQ:'
      TabOrder = 29
    end
    object StaticText13: TStaticText
      Left = 431
      Top = 131
      Width = 49
      Height = 31
      Caption = #37038#31665':'
      TabOrder = 30
    end
    object StaticText14: TStaticText
      Left = 888
      Top = 88
      Width = 89
      Height = 31
      Caption = #25307#23637#20154#21592':'
      PopupMenu = PopupMenu2
      TabOrder = 31
    end
    object StaticText15: TStaticText
      Left = 9
      Top = 169
      Width = 49
      Height = 31
      Caption = #22320#22336':'
      TabOrder = 32
    end
    object StaticText16: TStaticText
      Left = 9
      Top = 205
      Width = 49
      Height = 31
      Caption = #22791#27880':'
      TabOrder = 33
    end
    object infoMemo: TMemo
      Left = 64
      Top = 205
      Width = 818
      Height = 62
      Anchors = [akLeft, akTop, akBottom]
      TabOrder = 15
    end
    object addrEdit: TEdit
      Left = 64
      Top = 164
      Width = 818
      Height = 35
      TabOrder = 14
    end
    object standnumberEdit: TEdit
      Left = 285
      Top = 47
      Width = 108
      Height = 35
      TabOrder = 2
    end
    object nameEdit: TEdit
      Left = 450
      Top = 47
      Width = 114
      Height = 35
      TabOrder = 3
    end
    object companyEdit: TEdit
      Left = 877
      Top = 48
      Width = 254
      Height = 35
      TabOrder = 5
    end
    object emailEdit: TEdit
      Left = 486
      Top = 125
      Width = 396
      Height = 35
      TabOrder = 13
    end
    object allpaycxCurrencyEdit: TcxCurrencyEdit
      Left = 84
      Top = 88
      EditValue = 0.000000000000000000
      Properties.EditFormat = '0.00;-0.00'
      Properties.Nullable = False
      Properties.Nullstring = '0'
      Properties.UseNullString = True
      TabOrder = 6
      OnClick = allpaycxCurrencyEditClick
      Width = 127
    end
    object qqEdit: TEdit
      Left = 255
      Top = 126
      Width = 170
      Height = 35
      NumbersOnly = True
      TabOrder = 12
    end
    object firstpaycxCurrencyEdit: TcxCurrencyEdit
      Left = 266
      Top = 85
      EditValue = 0.000000000000000000
      Properties.EditFormat = '0.00;-0.00'
      Properties.Nullable = False
      TabOrder = 7
      OnClick = allpaycxCurrencyEditClick
      Width = 127
    end
    object nowpaycxCurrencyEdit: TcxCurrencyEdit
      Left = 486
      Top = 87
      EditValue = 0.000000000000000000
      Properties.EditFormat = '0.00;-0.00'
      TabOrder = 8
      OnClick = allpaycxCurrencyEditClick
      Width = 150
    end
    object paytypecxLookupComboBox: TcxLookupComboBox
      Left = 737
      Top = 86
      RepositoryItem = paytypecxEditRepository1LookupComboBoxItem
      Properties.ListColumns = <>
      TabOrder = 9
      Width = 145
    end
    object telphonecxMaskEdit: TcxMaskEdit
      Left = 64
      Top = 126
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d{0,11}'
      Properties.MaxLength = 0
      TabOrder = 11
      Width = 147
    end
    object phonecxMaskEdit: TcxMaskEdit
      Left = 621
      Top = 47
      Properties.MaskKind = emkRegExprEx
      Properties.EditMask = '([1])\d{10}'
      TabOrder = 4
      Width = 196
    end
    object customertypecxComboBox: TcxComboBox
      Left = 64
      Top = 49
      TabOrder = 1
      Width = 147
    end
    object salescxComboBox: TcxComboBox
      Left = 983
      Top = 86
      RepositoryItem = salesnamecxEditRepository1ComboBoxItem
      TabOrder = 10
      Width = 148
    end
  end
  object cxEditRepository1: TcxEditRepository
    Left = 640
    Top = 213
    object IDcxEditRepository1Label: TcxEditRepositoryLabel
      Properties.Alignment.Horz = taCenter
    end
    object cxEditRepository1DateItem: TcxEditRepositoryDateItem
      Properties.Alignment.Horz = taCenter
      Properties.DateButtons = [btnClear, btnToday]
      Properties.DisplayFormat = 'yyyy'#24180'm'#26376'd'#26085
      Properties.EditFormat = 'yyyy'#24180'm'#26376'd'#26085
      Properties.Nullstring = #26080
      Properties.ReadOnly = False
      Properties.SaveTime = False
      Properties.UseNullString = True
      Properties.WeekNumbers = True
    end
    object paytypecxEditRepository1LookupComboBoxItem: TcxEditRepositoryLookupComboBoxItem
      Properties.Alignment.Horz = taCenter
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'id'
      Properties.ListColumns = <
        item
          Caption = #25903#20184#31867#22411
          FieldName = 'payname'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = customerDataModule.paytypeDataSource
    end
    object customertypecxEditRepository1ComboBoxItem1: TcxEditRepositoryComboBoxItem
      Properties.Alignment.Horz = taCenter
      Properties.ImmediatePost = True
      Properties.Items.Strings = (
        'a'
        'd'
        'a'
        'd')
      Properties.OnInitPopup = customertypecxEditRepository1ComboBoxItem1PropertiesInitPopup
    end
    object cxEditRepository1CurrencyItem1: TcxEditRepositoryCurrencyItem
      Properties.EditFormat = '0.00'
    end
    object salesnamecxEditRepository1ComboBoxItem: TcxEditRepositoryComboBoxItem
      Properties.DropDownSizeable = True
      Properties.OnEditValueChanged = salesnamecxEditRepository1ComboBoxItemPropertiesEditValueChanged
      Properties.OnInitPopup = salesnamecxEditRepository1ComboBoxItemPropertiesInitPopup
    end
    object cxEditRepository1PopupItem1: TcxEditRepositoryPopupItem
      Properties.PopupSysPanelStyle = True
      Properties.OnCloseUp = cxEditRepository1PopupItem1PropertiesCloseUp
      Properties.OnInitPopup = cxEditRepository1PopupItem1PropertiesInitPopup
    end
  end
  object cxPropertiesStore1: TcxPropertiesStore
    Components = <
      item
        Component = Panel1
        Properties.Strings = (
          'Height')
      end>
    StorageName = 'customer.ini'
    Left = 728
    Top = 208
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 720
    Top = 264
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = 14024703
    end
    object cxStyle2: TcxStyle
    end
    object otherpaycxStyle: TcxStyle
      AssignedValues = [svFont, svTextColor]
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -20
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      Font.Quality = fqClearType
      TextColor = clRed
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 592
    Top = 288
    object refreshmenu: TMenuItem
      Caption = #21047#26032
      OnClick = refreshmenuClick
    end
    object softremovemenu: TMenuItem
      Caption = #21024#38500
      OnClick = softremovemenuClick
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
    object fetchallmenu: TMenuItem
      Caption = #26174#31034#25152#26377#35760#24405
      OnClick = fetchallmenuClick
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 712
    Top = 328
    object N2: TMenuItem
      Caption = #21024#38500
    end
  end
end
