object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'WebBrowser Samples'
  ClientHeight = 438
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 0
    Width = 333
    Height = 397
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 408
    ExplicitTop = 64
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C0000006B220000082900000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620B000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 397
    Width = 333
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 635
    object btnLoad: TButton
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Load'
      TabOrder = 0
      OnClick = btnLoadClick
    end
    object btnPrint1: TButton
      Left = 89
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Print 1'
      TabOrder = 1
      OnClick = btnPrint1Click
    end
    object btnPrint2: TButton
      Left = 170
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Print 2'
      TabOrder = 2
      OnClick = btnPrint2Click
    end
    object btnPrint3: TButton
      Left = 251
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Print 3'
      TabOrder = 3
      OnClick = btnPrint3Click
    end
  end
end
