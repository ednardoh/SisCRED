object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Prova Tecnica'
  ClientHeight = 588
  ClientWidth = 1031
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MMEPrincipal
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object stbPrincipal: TStatusBar
    Left = 0
    Top = 564
    Width = 1031
    Height = 24
    Panels = <
      item
        Text = 'Data Hora :'
        Width = 450
      end
      item
        Text = 'Prova Tecnica'
        Width = 600
      end>
  end
  object TTPrincipal: TTimer
    OnTimer = TTPrincipalTimer
    Left = 66
    Top = 20
  end
  object MMEPrincipal: TMainMenu
    Left = 108
    Top = 20
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Clientes1: TMenuItem
        Caption = 'Clientes'
        ShortCut = 16451
        OnClick = Clientes1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object ipodePagto1: TMenuItem
        Caption = 'Tipo de Pagto'
        ShortCut = 16468
        OnClick = ipodePagto1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Credores1: TMenuItem
        Caption = 'Credores'
        ShortCut = 16452
        OnClick = Credores1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Parcelas1: TMenuItem
        Caption = 'Parcelas'
        ShortCut = 16464
        OnClick = Parcelas1Click
      end
    end
    object Parametros1: TMenuItem
      Caption = 'Parametros'
      object ConfigurarBanco1: TMenuItem
        Caption = 'Configurar Banco'
        OnClick = ConfigurarBanco1Click
      end
    end
    object Sair1: TMenuItem
      Caption = '&Sair'
      OnClick = Sair1Click
    end
  end
end
