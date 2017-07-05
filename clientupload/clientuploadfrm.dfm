object bplclientuploadFrame: TbplclientuploadFrame
  Left = 0
  Top = 0
  Width = 965
  Height = 568
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  DesignSize = (
    965
    568)
  object Button1: TButton
    Left = 336
    Top = 455
    Width = 293
    Height = 47
    Anchors = [akLeft, akRight, akBottom]
    Caption = #24320#22987#26356#26032
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 186
    Top = 32
    Width = 593
    Height = 369
    Anchors = [akLeft, akTop, akRight, akBottom]
    BorderStyle = bsNone
    Color = clActiveCaption
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    StyleElements = [seFont, seBorder]
  end
end
