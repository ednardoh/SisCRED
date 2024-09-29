object FrmPesquisa: TFrmPesquisa
  Left = 467
  Top = 285
  BorderStyle = bsSingle
  Caption = 'Pesquisa'
  ClientHeight = 348
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 666
    Height = 81
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 755
    object Label1: TLabel
      Left = 24
      Top = 32
      Width = 34
      Height = 13
      Caption = 'Nome :'
    end
    object Label2: TLabel
      Left = 64
      Top = 8
      Width = 306
      Height = 13
      Caption = 'Tecle <ENTER> para selecionar no grid o resgistro ...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtNome: TEdit
      Left = 64
      Top = 27
      Width = 306
      Height = 21
      TabOrder = 0
      OnKeyPress = edtNomeKeyPress
    end
    object btnPesquisar: TButton
      Left = 382
      Top = 25
      Width = 108
      Height = 25
      Caption = 'Pesquisar - F3'
      TabOrder = 1
      OnClick = btnPesquisarClick
    end
    object rdg_Ordenar: TRadioGroup
      Left = 496
      Top = 13
      Width = 152
      Height = 46
      Caption = 'Ordenar Por :'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        '&C'#243'digo'
        '&Descri'#231#227'o')
      TabOrder = 2
      OnClick = rdg_OrdenarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 307
    Width = 666
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 370
    ExplicitWidth = 755
    object btnSelecionar: TButton
      Left = 384
      Top = 6
      Width = 137
      Height = 25
      Caption = 'Selecionar - F5'
      TabOrder = 0
      OnClick = btnSelecionarClick
    end
    object btnCancelar: TButton
      Left = 527
      Top = 6
      Width = 129
      Height = 25
      Caption = 'Cancelar <ESC>'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object dbgPesquisa: TDBGrid
    Left = 0
    Top = 81
    Width = 666
    Height = 226
    Align = alClient
    DataSource = frmDatamodulo.dsPesquisa
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbgPesquisaDblClick
    OnKeyPress = dbgPesquisaKeyPress
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
    Left = 517
    Top = 138
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
    Left = 565
    Top = 138
  end
  object TBCredores: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftInteger
      end
      item
        Name = 'cpf'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'nome'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Cep'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 8
      end
      item
        Name = 'Logradouro'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Numero'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 10
      end
      item
        Name = 'Bairro'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'Cidade'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Sigla_uf'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 2
      end
      item
        Name = 'Complemento'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'Ibge_cidade'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 7
      end
      item
        Name = 'Ibge_uf'
        Attributes = [faRequired]
        DataType = ftWideString
        Size = 2
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 510
    Top = 197
    object TBCredoresid: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'id'
    end
    object TBCredorescpf: TStringField
      DisplayLabel = 'CPF/CNPJ'
      FieldName = 'cpf'
    end
    object TBCredoresnome: TWideStringField
      DisplayLabel = 'Nome do Credor'
      DisplayWidth = 100
      FieldName = 'nome'
      Required = True
      Size = 100
    end
    object TBCredoresCep: TWideStringField
      DisplayLabel = 'CEP'
      FieldName = 'Cep'
      Required = True
      Size = 8
    end
    object TBCredoresLogradouro: TWideStringField
      DisplayLabel = 'Logradouro(Endere'#231'o)'
      FieldName = 'Logradouro'
      Required = True
      Size = 100
    end
    object TBCredoresNumero: TWideStringField
      FieldName = 'Numero'
      Required = True
      Size = 10
    end
    object TBCredoresBairro: TWideStringField
      FieldName = 'Bairro'
      Size = 40
    end
    object TBCredoresCidade: TWideStringField
      FieldName = 'Cidade'
      Required = True
      Size = 100
    end
    object TBCredoresSigla_uf: TWideStringField
      DisplayLabel = 'UF'
      FieldName = 'Sigla_uf'
      Required = True
      Size = 2
    end
    object TBCredoresComplemento: TWideStringField
      FieldName = 'Complemento'
      Size = 100
    end
    object TBCredoresIbge_cidade: TWideStringField
      FieldName = 'Ibge_cidade'
      Required = True
      Size = 7
    end
    object TBCredoresIbge_uf: TWideStringField
      FieldName = 'Ibge_uf'
      Required = True
      Visible = False
      Size = 2
    end
  end
  object ds_Credores: TDataSource
    DataSet = TBCredores
    Left = 566
    Top = 199
  end
  object TBClientes: TFDMemTable
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
    Left = 510
    Top = 253
    object TBClientesid: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'id'
    end
    object TBClientescpf: TStringField
      DisplayLabel = 'CPF'
      FieldName = 'cpf'
    end
    object TBClientesnome: TWideStringField
      DisplayLabel = 'Nome do Cliente'
      DisplayWidth = 100
      FieldName = 'nome'
      Required = True
      Size = 100
    end
    object TBClientesCep: TWideStringField
      DisplayLabel = 'CEP'
      FieldName = 'Cep'
      Required = True
      Size = 8
    end
    object TBClientesLogradouro: TWideStringField
      DisplayLabel = 'Logradouro(Endere'#231'o)'
      FieldName = 'Logradouro'
      Required = True
      Size = 100
    end
    object TBClientesNumero: TWideStringField
      FieldName = 'Numero'
      Required = True
      Size = 10
    end
    object TBClientesBairro: TWideStringField
      FieldName = 'Bairro'
      Size = 40
    end
    object TBClientesCidade: TWideStringField
      FieldName = 'Cidade'
      Required = True
      Size = 100
    end
    object TBClientesSigla_uf: TWideStringField
      DisplayLabel = 'UF'
      FieldName = 'Sigla_uf'
      Required = True
      Size = 2
    end
    object TBClientesComplemento: TWideStringField
      FieldName = 'Complemento'
      Size = 100
    end
    object TBClientesIbge_cidade: TWideStringField
      FieldName = 'Ibge_cidade'
      Required = True
      Size = 7
    end
    object TBClientesIbge_uf: TWideStringField
      FieldName = 'Ibge_uf'
      Required = True
      Visible = False
      Size = 2
    end
  end
  object ds_Clientes: TDataSource
    DataSet = TBClientes
    Left = 558
    Top = 255
  end
end
