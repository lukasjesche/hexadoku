object NeuerHighScoreFRM: TNeuerHighScoreFRM
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Neuer HighScore!'
  ClientHeight = 142
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 110
  TextHeight = 16
  object Label1: TLabel
    Left = 10
    Top = 10
    Width = 140
    Height = 16
    Caption = 'Herzlichen Gl'#252'ckwunsch!'
  end
  object Label2: TLabel
    Left = 10
    Top = 30
    Width = 247
    Height = 16
    Caption = 'Du hast es in die HighScore Liste geschafft!'
  end
  object Label3: TLabel
    Left = 10
    Top = 49
    Width = 319
    Height = 16
    Caption = 'Bitte gib deinen Namen ein, um deine Zeit zu speichern!'
  end
  object Label4: TLabel
    Left = 10
    Top = 73
    Width = 67
    Height = 16
    Caption = 'Dein Name:'
  end
  object Edit1: TEdit
    Left = 85
    Top = 69
    Width = 251
    Height = 24
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 10
    Top = 102
    Width = 330
    Height = 31
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
end
