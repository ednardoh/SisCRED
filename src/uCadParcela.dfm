inherited frmCadParcela: TfrmCadParcela
  Caption = 'Cadastro de Parcelas'
  ClientHeight = 496
  ClientWidth = 993
  ExplicitWidth = 1009
  ExplicitHeight = 535
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_Contato: TPanel [0]
    Width = 993
    Height = 217
    Align = alTop
    BevelOuter = bvNone
    ExplicitWidth = 993
    ExplicitHeight = 217
    object Label13: TLabel [0]
      Left = 9
      Top = 32
      Width = 14
      Height = 13
      Caption = 'Id:'
    end
    object Label1: TLabel [1]
      Left = 9
      Top = 74
      Width = 81
      Height = 13
      Caption = 'Tipo pagamento:'
    end
    object Label2: TLabel [2]
      Left = 9
      Top = 115
      Width = 49
      Height = 13
      Caption = 'Crededor:'
    end
    object Label3: TLabel [3]
      Left = 9
      Top = 162
      Width = 37
      Height = 13
      Caption = 'Cliente:'
    end
    inherited pnl_Cliente: TPanel
      Left = 0
      Top = 0
      Width = 993
      Caption = 'Cadastro de Parcelas'
      TabOrder = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 993
    end
    object Edt_ID: TEdit
      Left = 7
      Top = 48
      Width = 80
      Height = 21
      TabOrder = 0
      OnEnter = Edt_IDEnter
      OnExit = Edt_IDExit
    end
    object Edt_Tipopgto: TEdit
      Left = 7
      Top = 90
      Width = 80
      Height = 21
      TabOrder = 1
      OnEnter = Edt_IDEnter
      OnExit = Edt_IDExit
    end
    object btnConsultaTPGTO: TBitBtn
      Left = 88
      Top = 89
      Width = 23
      Height = 22
      Caption = '...'
      TabOrder = 6
      OnClick = btnConsultaTPGTOClick
    end
    object Edt_Descr_Tipopgto: TEdit
      Left = 111
      Top = 89
      Width = 367
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 7
    end
    object Edt_Credor: TEdit
      Left = 7
      Top = 131
      Width = 80
      Height = 21
      TabOrder = 2
      OnEnter = Edt_IDEnter
      OnExit = Edt_IDExit
    end
    object btnConsultaCREDOR: TBitBtn
      Left = 88
      Top = 130
      Width = 23
      Height = 22
      Caption = '...'
      TabOrder = 8
      OnClick = btnConsultaCREDORClick
    end
    object Edt_Descr_Credor: TEdit
      Left = 111
      Top = 130
      Width = 367
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 9
    end
    object Edt_Cliente: TEdit
      Left = 7
      Top = 178
      Width = 80
      Height = 21
      TabOrder = 3
      OnEnter = Edt_IDEnter
      OnExit = Edt_IDExit
    end
    object btnConsultaCLIENTE: TBitBtn
      Left = 88
      Top = 177
      Width = 23
      Height = 22
      Caption = '...'
      TabOrder = 10
      OnClick = btnConsultaCLIENTEClick
    end
    object Edt_Descr_Cliente: TEdit
      Left = 111
      Top = 177
      Width = 367
      Height = 21
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 11
    end
    object GroupBox1: TGroupBox
      Left = 484
      Top = 47
      Width = 499
      Height = 158
      Caption = 'Parcelas :'
      TabOrder = 4
      object Label5: TLabel
        Left = 11
        Top = 70
        Width = 106
        Height = 13
        Caption = 'Data primeira parcela:'
      end
      object Label6: TLabel
        Left = 130
        Top = 70
        Width = 107
        Height = 13
        Caption = 'Valor primeira parcela:'
      end
      object Label7: TLabel
        Left = 254
        Top = 70
        Width = 109
        Height = 13
        Caption = 'Data segunda parcela:'
      end
      object Label8: TLabel
        Left = 373
        Top = 70
        Width = 110
        Height = 13
        Caption = 'Valor segunda parcela:'
      end
      object Label9: TLabel
        Left = 11
        Top = 110
        Width = 105
        Height = 13
        Caption = 'Data terceira parcela:'
      end
      object Label10: TLabel
        Left = 130
        Top = 110
        Width = 106
        Height = 13
        Caption = 'Valor terceira parcela:'
      end
      object Label11: TLabel
        Left = 254
        Top = 110
        Width = 100
        Height = 13
        Caption = 'Data quarta parcela:'
      end
      object Label12: TLabel
        Left = 373
        Top = 110
        Width = 101
        Height = 13
        Caption = 'Valor quarta parcela:'
      end
      object Label4: TLabel
        Left = 12
        Top = 26
        Width = 55
        Height = 13
        Caption = 'Valor Total:'
      end
      object MKE_primeira_Parc: TMaskEdit
        Left = 9
        Top = 84
        Width = 106
        Height = 21
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        OnEnter = MKE_primeira_ParcEnter
        OnExit = MKE_primeira_ParcExit
      end
      object MKE_terceira_Parc: TMaskEdit
        Left = 10
        Top = 128
        Width = 106
        Height = 21
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 5
        Text = '  /  /    '
        OnEnter = MKE_primeira_ParcEnter
        OnExit = MKE_primeira_ParcExit
      end
      object MKE_segunda_Parc: TMaskEdit
        Left = 254
        Top = 84
        Width = 106
        Height = 21
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 3
        Text = '  /  /    '
        OnEnter = MKE_primeira_ParcEnter
        OnExit = MKE_primeira_ParcExit
      end
      object MKE_quarta_Parc: TMaskEdit
        Left = 254
        Top = 128
        Width = 106
        Height = 21
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 7
        Text = '  /  /    '
        OnEnter = MKE_primeira_ParcEnter
        OnExit = MKE_primeira_ParcExit
      end
      object Edt_Valortot: TcxCurrencyEdit
        Left = 10
        Top = 43
        TabOrder = 0
        OnEnter = Edt_Valor_primeira_parcEnter
        OnExit = Edt_Valor_primeira_parcExit
        Width = 103
      end
      object Edt_Valor_primeira_parc: TcxCurrencyEdit
        Left = 128
        Top = 83
        TabOrder = 2
        OnEnter = Edt_Valor_primeira_parcEnter
        OnExit = Edt_Valor_primeira_parcExit
        Width = 120
      end
      object Edt_Valor_segunda_parc: TcxCurrencyEdit
        Left = 369
        Top = 84
        TabOrder = 4
        OnEnter = Edt_Valor_primeira_parcEnter
        OnExit = Edt_Valor_primeira_parcExit
        Width = 120
      end
      object Edt_Valor_terceira_parc: TcxCurrencyEdit
        Left = 128
        Top = 128
        TabOrder = 6
        OnEnter = Edt_Valor_primeira_parcEnter
        OnExit = Edt_Valor_primeira_parcExit
        Width = 120
      end
      object Edt_Valor_quarta_parc: TcxCurrencyEdit
        Left = 366
        Top = 129
        TabOrder = 8
        OnEnter = Edt_Valor_primeira_parcEnter
        OnExit = Edt_Valor_primeira_parcExit
        Width = 120
      end
    end
  end
  inherited pnl_Bottom: TPanel [1]
    Top = 443
    Width = 993
    ExplicitTop = 443
    ExplicitWidth = 993
  end
  object pn_Grid: TPanel
    Left = 0
    Top = 217
    Width = 993
    Height = 226
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object DBG_CadCli: TDBGrid
      Left = 0
      Top = 0
      Width = 993
      Height = 226
      Align = alClient
      DataSource = ds_Parcelas
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = DBG_CadCliCellClick
      OnDblClick = DBG_CadCliDblClick
    end
  end
  object TBParcelas: TFDMemTable
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
    Left = 502
    Top = 285
    object TBParcelasid_parcelas: TIntegerField
      DisplayLabel = 'Id. Parcelas'
      FieldName = 'id_parcelas'
    end
    object TBParcelasid_tipo_pgto: TIntegerField
      DisplayLabel = 'Tipopgto'
      FieldName = 'id_tipo_pgto'
    end
    object TBParcelasid_credor: TIntegerField
      DisplayLabel = 'Credor'
      FieldName = 'id_credor'
    end
    object TBParcelasid_cliente: TIntegerField
      DisplayLabel = 'Cliente'
      FieldName = 'id_cliente'
    end
    object TBParcelasvalor_total: TCurrencyField
      DisplayLabel = 'Valor Total'
      FieldName = 'valor_total'
      DisplayFormat = ',0.00'
      currency = False
    end
    object TBParcelasdt_primeira_parcela: TStringField
      DisplayLabel = 'Dt. Primeira Parcela'
      FieldName = 'dt_primeira_parcela'
      Size = 10
    end
    object TBParcelasvl_primeira_parcela: TCurrencyField
      DisplayLabel = 'Vlr. Primeira Parcela'
      FieldName = 'vl_primeira_parcela'
      DisplayFormat = ',0.00'
      currency = False
    end
    object TBParcelasdt_segunda_parcela: TStringField
      DisplayLabel = 'Dt. Segunda Parcela'
      FieldName = 'dt_segunda_parcela'
      Size = 10
    end
    object TBParcelasvl_segunda_parcela: TCurrencyField
      DisplayLabel = 'Vlr. Segunda Parcela'
      FieldName = 'vl_segunda_parcela'
      DisplayFormat = ',0.00'
      currency = False
    end
    object TBParcelasdt_terceira_parcela: TStringField
      DisplayLabel = 'Dt. Terceira Parcela'
      FieldName = 'dt_terceira_parcela'
      Size = 10
    end
    object TBParcelasvl_terceira_parcela: TCurrencyField
      DisplayLabel = 'Vlr. Terceira Parcela'
      FieldName = 'vl_terceira_parcela'
      DisplayFormat = ',0.00'
      currency = False
    end
    object TBParcelasdt_quarta_parcela: TStringField
      DisplayLabel = 'Dt. Quarta Parcela'
      FieldName = 'dt_quarta_parcela'
      Size = 10
    end
    object TBParcelasvl_quarta_parcela: TCurrencyField
      DisplayLabel = 'Vlr. Quarta Parcela'
      FieldName = 'vl_quarta_parcela'
      DisplayFormat = ',0.00'
      currency = False
    end
    object TBParcelasstatus: TIntegerField
      DisplayLabel = 'Status'
      FieldName = 'status'
    end
  end
  object ds_Parcelas: TDataSource
    DataSet = TBParcelas
    Left = 550
    Top = 287
  end
  object RESTResponse1: TRESTResponse
    Left = 629
    Top = 288
  end
  object RESTClient1: TRESTClient
    Params = <>
    Left = 701
    Top = 288
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 757
    Top = 296
  end
end
