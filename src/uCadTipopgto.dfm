inherited frmCadTipopgto: TfrmCadTipopgto
  Caption = 'Cadastro de Tipo de Pagamento'
  ClientHeight = 310
  ExplicitHeight = 349
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Bottom: TPanel
    Top = 257
    ExplicitTop = 257
  end
  inherited pnl_Contato: TPanel
    Height = 105
    Align = alTop
    BevelOuter = bvNone
    ExplicitHeight = 105
    object Label12: TLabel [0]
      Left = 22
      Top = 35
      Width = 14
      Height = 13
      Caption = 'Id:'
    end
    object Label1: TLabel [1]
      Left = 104
      Top = 32
      Width = 49
      Height = 13
      Caption = 'Tipo Pgto:'
    end
    inherited pnl_Cliente: TPanel
      Left = 0
      Top = 0
      Width = 553
      Caption = 'Cadastro de Tipo de Pagamento '
      TabOrder = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 553
    end
    object EDT_Id: TEdit
      Left = 17
      Top = 51
      Width = 77
      Height = 21
      TabOrder = 0
      OnEnter = EDT_IdEnter
      OnExit = EDT_IdExit
    end
    object cbo_Tipopgto: TComboBox
      Left = 104
      Top = 51
      Width = 433
      Height = 21
      TabOrder = 1
      OnEnter = cbo_TipopgtoEnter
      OnExit = cbo_TipopgtoExit
      Items.Strings = (
        'A VISTA'
        '1 + 1'
        '1 + 2'
        '1 + 3')
    end
  end
  object pn_Grid: TPanel
    Left = 0
    Top = 105
    Width = 553
    Height = 152
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object DBG_Cadtipopgto: TDBGrid
      Left = 0
      Top = 0
      Width = 553
      Height = 152
      Align = alClient
      DataSource = ds_Tipopgto
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = DBG_CadtipopgtoCellClick
      OnDblClick = DBG_CadtipopgtoDblClick
    end
  end
  object TBTipopgto: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 445
    Top = 178
    object TBTipopgtoid: TIntegerField
      DisplayLabel = 'Id.'
      DisplayWidth = 10
      FieldName = 'id'
    end
    object TBTipopgtoTipopgto: TStringField
      DisplayLabel = 'Tipo de Pagto'
      DisplayWidth = 74
      FieldName = 'Tipopgto'
      Size = 50
    end
  end
  object ds_Tipopgto: TDataSource
    DataSet = TBTipopgto
    Left = 493
    Top = 178
  end
  object RESTResponse1: TRESTResponse
    Left = 389
    Top = 80
  end
  object RESTClient1: TRESTClient
    Params = <>
    Left = 461
    Top = 80
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 509
    Top = 80
  end
end
