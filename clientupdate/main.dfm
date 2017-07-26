object updateForm: TupdateForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #27491#22312#26356#26032#36719#20214
  ClientHeight = 142
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 27
  object Label1: TLabel
    Left = 8
    Top = 103
    Width = 97
    Height = 24
    AutoSize = False
    Caption = #19979#36733#25991#20214':'
  end
  object Label2: TLabel
    Left = 486
    Top = 103
    Width = 94
    Height = 24
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0KB/s'
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 576
    Height = 89
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object ProgressBar1: TProgressBar
    Left = 104
    Top = 104
    Width = 377
    Height = 24
    Smooth = True
    TabOrder = 1
  end
  object NetHTTPClient1: TNetHTTPClient
    Asynchronous = True
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    AllowCookies = True
    HandleRedirects = True
    UserAgent = 'Embarcadero URI Client/1.0'
    OnRequestCompleted = NetHTTPClient1RequestCompleted
    OnRequestError = NetHTTPClient1RequestError
    OnReceiveData = NetHTTPClient1ReceiveData
    Left = 496
    Top = 32
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 392
    Top = 48
  end
end
