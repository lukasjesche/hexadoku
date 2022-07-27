object EinstellungensFRM: TEinstellungensFRM
  Left = 0
  Top = 0
  Caption = 'Einstellungen f'#252'r HexaDoku - Das Spiel'
  ClientHeight = 292
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 110
  TextHeight = 14
  object Label5: TLabel
    Left = 8
    Top = 8
    Width = 41
    Height = 14
    Caption = 'Farben:'
  end
  object FarbenPanel: TPanel
    Left = 4
    Top = 28
    Width = 404
    Height = 259
    TabOrder = 0
    object ImageVor: TImage
      Left = 261
      Top = 52
      Width = 120
      Height = 60
    end
    object Label4: TLabel
      Left = 249
      Top = 32
      Width = 54
      Height = 14
      Caption = 'Vorschau:'
    end
    object Label3: TLabel
      Left = 68
      Top = 8
      Width = 85
      Height = 14
      Caption = 'Schriftfarbe der'
    end
    object ImageV: TImage
      Left = 27
      Top = 33
      Width = 15
      Height = 15
    end
    object ImageE: TImage
      Left = 27
      Top = 66
      Width = 15
      Height = 15
    end
    object ImageF: TImage
      Left = 247
      Top = 135
      Width = 15
      Height = 15
    end
    object ImageM: TImage
      Left = 27
      Top = 96
      Width = 15
      Height = 15
    end
    object ImageAE: TImage
      Left = 27
      Top = 223
      Width = 15
      Height = 15
    end
    object ImageAF: TImage
      Left = 27
      Top = 195
      Width = 15
      Height = 15
    end
    object ImageH: TImage
      Left = 27
      Top = 135
      Width = 15
      Height = 15
    end
    object ButtonV: TButton
      Left = 48
      Top = 28
      Width = 153
      Height = 25
      Caption = 'vorgegebenen Ziffern'
      TabOrder = 0
      OnClick = ButtonVClick
    end
    object ButtonE: TButton
      Left = 48
      Top = 59
      Width = 153
      Height = 25
      Caption = 'eigenen Ziffern'
      TabOrder = 1
      OnClick = ButtonEClick
    end
    object ButtonH: TButton
      Left = 48
      Top = 128
      Width = 153
      Height = 25
      Caption = 'Hintergrundfarbe'
      TabOrder = 2
      OnClick = ButtonHClick
    end
    object ButtonM: TButton
      Left = 48
      Top = 89
      Width = 153
      Height = 25
      Caption = 'M'#246'glichkeiten'
      TabOrder = 3
      OnClick = ButtonMClick
    end
    object ButtonAE: TButton
      Left = 48
      Top = 216
      Width = 341
      Height = 25
      Caption = 'Farbe der aktiven Einheit'
      TabOrder = 4
      OnClick = ButtonAEClick
    end
    object ButtonAF: TButton
      Left = 48
      Top = 185
      Width = 341
      Height = 25
      Caption = 'Farbe des aktiven Fensters'
      TabOrder = 5
      OnClick = ButtonAFClick
    end
    object ButtonF: TButton
      Left = 269
      Top = 128
      Width = 120
      Height = 25
      Caption = 'Fehlerfarbe'
      TabOrder = 6
      OnClick = ButtonFClick
    end
  end
  object ColorDialogV: TColorDialog
    Color = clBlue
    Left = 174
    Top = 49
  end
  object ColorDialogE: TColorDialog
    Left = 174
    Top = 81
  end
  object ColorDialogH: TColorDialog
    Color = clWhite
    Left = 182
    Top = 153
  end
  object ColorDialogM: TColorDialog
    Color = clGray
    Left = 174
    Top = 113
  end
  object ColorDialogAF: TColorDialog
    Color = clBlue
    Left = 350
    Top = 209
  end
  object ColorDialogAE: TColorDialog
    Color = clGreen
    Left = 358
    Top = 241
  end
  object ColorDialogF: TColorDialog
    Color = clWhite
    Left = 366
    Top = 153
  end
end
