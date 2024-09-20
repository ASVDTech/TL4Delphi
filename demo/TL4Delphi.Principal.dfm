object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  Caption = 'TL4Delphi Community'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnDestroy = FormDestroy
  TextHeight = 15
  object mmLog: TMemo
    Left = 0
    Top = 0
    Width = 273
    Height = 401
    TabOrder = 0
  end
  object Button1: TButton
    Left = 296
    Top = 8
    Width = 153
    Height = 25
    Caption = 'Start Telegram'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 296
    Top = 31
    Width = 153
    Height = 25
    Caption = 'Stop Telegram'
    TabOrder = 2
    OnClick = Button2Click
  end
  object edtChatID: TEdit
    Left = 296
    Top = 128
    Width = 153
    Height = 23
    TabOrder = 3
    TextHint = 'ChatID'
  end
  object edtMensagem: TEdit
    Left = 296
    Top = 165
    Width = 153
    Height = 23
    TabOrder = 4
    TextHint = 'Mensagem'
  end
  object Button3: TButton
    Left = 296
    Top = 207
    Width = 153
    Height = 25
    Caption = 'Enviar Mensagem'
    TabOrder = 5
    OnClick = Button3Click
  end
  object TL4Delphi: TTL4Delphi
    Config.TempoCiclo = 2000
    Left = 432
    Top = 240
  end
end
