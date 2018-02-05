object roleselectForm: TroleselectForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #36873#25321#26435#38480
  ClientHeight = 544
  ClientWidth = 1061
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 27
  object Panel2: TPanel
    Left = 0
    Top = 503
    Width = 1061
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    ExplicitTop = 478
    ExplicitWidth = 787
    DesignSize = (
      1061
      41)
    object Button1: TButton
      Left = 880
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #30830#23450
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 606
    end
    object Button2: TButton
      Left = 969
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #21462#28040
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 695
    end
    object Button3: TButton
      Left = 32
      Top = 8
      Width = 75
      Height = 25
      Caption = #20840#36873
      TabOrder = 2
    end
    object Button4: TButton
      Left = 113
      Top = 8
      Width = 75
      Height = 25
      Caption = #20840#19981#36873
      TabOrder = 3
    end
  end
  object cxTreeList1: TcxTreeList
    Left = 0
    Top = 41
    Width = 1061
    Height = 462
    Align = alClient
    Bands = <
      item
      end>
    Navigator.Buttons.CustomButtons = <>
    OptionsView.ColumnAutoWidth = True
    OptionsView.Indicator = True
    TabOrder = 1
    ExplicitWidth = 787
    ExplicitHeight = 437
    object cxTreeList1Column1: TcxTreeListColumn
      Caption.Text = #21517#31216
      DataBinding.ValueType = 'String'
      Options.Editing = False
      Width = 261
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      SortOrder = soDescending
      SortIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxTreeList1Column3: TcxTreeListColumn
      Caption.Text = #21035#21517
      DataBinding.ValueType = 'String'
      Options.Editing = False
      Width = 277
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxTreeList1Column2: TcxTreeListColumn
      PropertiesClassName = 'TcxCheckBoxProperties'
      Properties.ImmediatePost = True
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Properties.OnChange = cxTreeList1Column2PropertiesChange
      Caption.Text = #36873#25321
      DataBinding.ValueType = 'String'
      Width = 75
      Position.ColIndex = 2
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1061
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ParentBackground = False
    TabOrder = 2
    ExplicitWidth = 787
  end
end
