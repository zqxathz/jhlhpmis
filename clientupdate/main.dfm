object updateForm: TupdateForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'updateForm'
  ClientHeight = 177
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 126
    Width = 257
    Height = 13
    AutoSize = False
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 48
    Top = 145
    Width = 257
    Height = 13
    AutoSize = False
    Caption = 'Label1'
  end
  object Memo1: TMemo
    Left = 48
    Top = 8
    Width = 489
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object ProgressBar1: TProgressBar
    Left = 48
    Top = 103
    Width = 489
    Height = 17
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
    Left = 360
    Top = 120
  end
end
