unit uCadCredor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadFormBase, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, Vcl.Mask,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Json, System.JSON;

type
  TfrmCadCredor = class(TfrmCadFormBase)
    pnl_Client: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    EDT_Nomecli: TEdit;
    MKE_CEP: TMaskEdit;
    Btn_Cep: TButton;
    EDT_Logradouro: TEdit;
    EDT_Numero: TEdit;
    EDT_Complemento: TEdit;
    EDT_Cidade: TEdit;
    EDT_IbgeCid: TEdit;
    EDT_Uf: TEdit;
    EDT_IbgeUF: TEdit;
    pnl_Botoes: TPanel;
    imgHorse: TImage;
    Label11: TLabel;
    EDT_Pesquisacli: TEdit;
    BTN_Webapi: TBitBtn;
    EDT_Bairro: TEdit;
    EDT_Cpf: TEdit;
    DBG_CadCli: TDBGrid;
    RESTResponse1: TRESTResponse;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    TBCredores: TFDMemTable;
    TBCredoresid: TIntegerField;
    TBCredorescpf: TStringField;
    TBCredoresnome: TWideStringField;
    TBCredoresCep: TWideStringField;
    TBCredoresLogradouro: TWideStringField;
    TBCredoresNumero: TWideStringField;
    TBCredoresBairro: TWideStringField;
    TBCredoresCidade: TWideStringField;
    TBCredoresSigla_uf: TWideStringField;
    TBCredoresComplemento: TWideStringField;
    TBCredoresIbge_cidade: TWideStringField;
    TBCredoresIbge_uf: TWideStringField;
    ds_Credores: TDataSource;
    BitBtn1: TBitBtn;
    Edt_ID: TEdit;
    Label13: TLabel;
    procedure EDT_CpfEnter(Sender: TObject);
    procedure EDT_CpfExit(Sender: TObject);
    procedure BTN_InserirClick(Sender: TObject);
    procedure BTN_EditarClick(Sender: TObject);
    procedure BTN_CancelarClick(Sender: TObject);
    procedure BTN_GravarClick(Sender: TObject);
    procedure BTN_WebapiClick(Sender: TObject);
    procedure DBG_CadCliDblClick(Sender: TObject);
    procedure DBG_CadCliCellClick(Column: TColumn);
    procedure BTN_ExcluirClick(Sender: TObject);
    procedure Btn_CepClick(Sender: TObject);
    procedure MKE_CEPEnter(Sender: TObject);
    procedure MKE_CEPExit(Sender: TObject);
  private
    { Private declarations }
    strStatusCli: string;
    IntID: Integer;
    Objeto,
    Objt: TJsonObject;
    ParRows,
    PRows: TJsonPair;
    strApiDataSet: string;
    function IsNumber(strVal: string): boolean;
    procedure BuscaCep(strURL, strAText: string); //busca Cep
    procedure LimpaCampos;
    procedure GravaCredor;
    procedure LeRegistros;
    procedure BuscaCredor(strURL, strAText: string);
    procedure PreencheDataSetCredores(strJSONValue: string);
    procedure PreencheCampos;
    procedure ExcluiDados;
  public
    { Public declarations }
  end;

var
  frmCadCredor: TfrmCadCredor;

implementation

{$R *.dfm}

uses uDatamodulo;

procedure TfrmCadCredor.BTN_CancelarClick(Sender: TObject);
begin
  strStatusCli :='';
  inherited;

end;

procedure TfrmCadCredor.Btn_CepClick(Sender: TObject);
begin
  inherited;
  BuscaCep('https://api.postmon.com.br/v1/cep/',MKE_CEP.Text);
end;

procedure TfrmCadCredor.BTN_EditarClick(Sender: TObject);
begin
  strStatusCli :='dsEditando';
  EDT_Nomecli.SetFocus;
  inherited;
end;

procedure TfrmCadCredor.BTN_ExcluirClick(Sender: TObject);
begin
  strStatusCli :='dsExcluindo';
  ExcluiDados;
  inherited;
  LeRegistros;
end;

procedure TfrmCadCredor.BTN_GravarClick(Sender: TObject);
begin
  GravaCredor;
  strStatusCli :='';
  inherited;
  LeRegistros;
end;

procedure TfrmCadCredor.BTN_InserirClick(Sender: TObject);
begin
  strStatusCli :='dsInserindo';
  LimpaCampos;
  EDT_Cpf.SetFocus;
  inherited;
end;

procedure TfrmCadCredor.BTN_WebapiClick(Sender: TObject);
begin
  inherited;
  if Trim(EDT_Pesquisacli.Text) = '' then  //All
    BuscaCredor('http://localhost:9000/credoresall','')
  else if IsNumber(Trim(EDT_Pesquisacli.Text)) then
    BuscaCredor('http://localhost:9000/credoresbyid/',trim(EDT_Pesquisacli.Text))
  else
    BuscaCredor('http://localhost:9000/credoresbynome/',trim(EDT_Pesquisacli.Text))
end;

procedure TfrmCadCredor.BuscaCep(strURL, strAText: string);
begin
  RESTClient1.BaseURL := strURL + strAText;
  RESTRequest1.Method := rmGET;
  RESTRequest1.Execute;

  Objeto  := RESTResponse1.JSONValue as TJSONObject;

  //Bairro
  ParRows := Objeto.Get('bairro');
  EDT_Bairro.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

  //Cidade
  ParRows := Objeto.Get('cidade');
  EDT_Cidade.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

  //Logradouro
  ParRows := Objeto.Get('logradouro');
  EDT_Logradouro.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

  //Ibge estado
  ParRows := Objeto.Get('estado_info');
  Objt    := Objeto.Get('estado_info').JsonValue as TJSONObject;
  PRows   := Objt.Get('codigo_ibge');
  EDT_IbgeUF.Text :=frmDatamodulo.CharEspeciais(PRows.JsonValue.ToString);

  //CEP
  ParRows := Objeto.Get('cep');
  MKE_CEP.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

  //Ibge Cidade
  ParRows := Objeto.Get('cidade_info');
  Objt    := Objeto.Get('cidade_info').JsonValue as TJSONObject;
  PRows   := Objt.Get('codigo_ibge');
  EDT_IbgeCid.Text :=frmDatamodulo.CharEspeciais(PRows.JsonValue.ToString);

  //Estado
  ParRows := Objeto.Get('estado');
  EDT_Uf.Text :=frmDatamodulo.CharEspeciais(ParRows.JsonValue.ToString);

  EDT_Numero.SetFocus;
end;

procedure TfrmCadCredor.BuscaCredor(strURL, strAText: string);
var
  I: Integer;
  strJSON: string;
begin
  strApiDataSet := 'stAPI';
  TBCredores.Close;
  TBCredores.Open;
  TBCredores.EmptyDataSet;
  TBCredores.IndexFieldNames := 'id';   //s� para order por id
  DBG_CadCli.DataSource := Nil;
  DBG_CadCli.DataSource := ds_Credores;
  TBCredores.Close;
  TBCredores.Open;

  RESTClient1.BaseURL := strURL + strAText;
  RESTRequest1.Method := rmGET;
  RESTRequest1.Execute;

  if RESTResponse1.StatusCode in [200,201,204] then
    begin
      PreencheDataSetCredores(RESTResponse1.Content);  //processa o JSon
    end;
end;

procedure TfrmCadCredor.DBG_CadCliCellClick(Column: TColumn);
begin
  inherited;
  PreencheCampos;
end;

procedure TfrmCadCredor.DBG_CadCliDblClick(Sender: TObject);
begin
  inherited;
  PreencheCampos;
end;

procedure TfrmCadCredor.EDT_CpfEnter(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Color := clYellow;
end;

procedure TfrmCadCredor.EDT_CpfExit(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Color := clWindow;
end;

procedure TfrmCadCredor.ExcluiDados;
begin
  if strStatusCli ='dsExcluindo' then
    begin
      if Application.messageBox('Deseja Realmente Apagar Esse Credor?',
        'Confirma��o',mb_YesNo+mb_IconInformation+mb_DefButton2) = IDYES then
        begin
          try
            RESTClient1.BaseURL := 'http://localhost:9000/credordelete/' + IntToStr(IntID);
            RESTRequest1.Method := rmDELETE;
            RESTRequest1.Execute;

            RESTClient1.BaseURL   :='';
            RESTRequest1.Resource :='';
            RESTRequest1.Method   := rmGET;
            RESTRequest1.AddBody('');
          finally
            RESTClient1.BaseURL   :='';
            RESTRequest1.Resource :='';
            RESTRequest1.Method   := rmGET;
            RESTRequest1.AddBody('');
          end;
        end;
    end;
end;

procedure TfrmCadCredor.GravaCredor;
var
  oJson: TJSONObject;
begin
  if strStatusCli ='dsInserindo' then
    begin
      try
        RESTClient1.BaseURL       := 'http://localhost:9000/';
        RESTRequest1.Resource     :='credorinsert';
        RESTRequest1.Method       := rmPOST;
        oJson := TJSONObject.Create;
        oJson.AddPair('cpfcnpj'   , EDT_Cpf.Text);
        oJson.AddPair('nome'       , EDT_Nomecli.Text);
        oJson.AddPair('cep'        , MKE_CEP.Text);
        oJson.AddPair('logradouro' , EDT_Logradouro.Text);
        oJson.AddPair('numero'     , EDT_Numero.Text);
        oJson.AddPair('complemento', EDT_Complemento.Text);
        oJson.AddPair('bairro'     , EDT_Bairro.Text);
        oJson.AddPair('cidade'     , EDT_Cidade.Text);
        oJson.AddPair('ibge_cidade', EDT_IbgeCid.Text);
        oJson.AddPair('sigla_uf'   , EDT_IbgeUF.Text);
        RESTRequest1.AddBody(oJson);
        RESTRequest1.Execute;
      finally
        oJson.Free;
        RESTClient1.BaseURL   :='';
        RESTRequest1.Resource :='';
        RESTRequest1.Method   := rmGET;
        RESTRequest1.AddBody('');
      end;
    end
  else
    if strStatusCli ='dsEditando' then
      begin
        try
          RESTClient1.BaseURL       := 'http://localhost:9000/';
          RESTRequest1.Resource     :='credorupdate';
          RESTRequest1.Method       := rmPUT;
          oJson := TJSONObject.Create;
          oJson.AddPair('id'         , TJSONNumber.Create(IntID));
          oJson.AddPair('cpfcnpj'   , EDT_Cpf.Text);
          oJson.AddPair('nome'       , EDT_Nomecli.Text);
          oJson.AddPair('cep'        , MKE_CEP.Text);
          oJson.AddPair('logradouro' , EDT_Logradouro.Text);
          oJson.AddPair('numero'     , EDT_Numero.Text);
          oJson.AddPair('complemento', EDT_Complemento.Text);
          oJson.AddPair('bairro'     , EDT_Bairro.Text);
          oJson.AddPair('cidade'     , EDT_Cidade.Text);
          oJson.AddPair('ibge_cidade', EDT_IbgeCid.Text);
          oJson.AddPair('sigla_uf'   , EDT_IbgeUF.Text);
          RESTRequest1.AddBody(oJson);
          RESTRequest1.Execute;
        finally
          oJson.Free;
          RESTClient1.BaseURL   :='';
          RESTRequest1.Resource :='';
          RESTRequest1.Method   := rmGET;
          RESTRequest1.AddBody('');
        end;
      end;
  strStatusCli :='';
end;

function TfrmCadCredor.IsNumber(strVal: string): boolean;
begin
  if StrToIntDef(strVal, 0) = 0 then
    Result := False
  else
    Result := True;
end;

procedure TfrmCadCredor.LeRegistros;
begin
  Refresh;
  BTN_WebapiClick(Self);
end;

procedure TfrmCadCredor.LimpaCampos;
begin
  Edt_ID.Clear;
  EDT_Cpf.Clear;
  EDT_Nomecli.Clear;
  MKE_CEP.Clear;
  EDT_Logradouro.Clear;
  EDT_Numero.Clear;
  EDT_Complemento.Clear;
  EDT_Bairro.Clear;
  EDT_Cidade.Clear;
  EDT_IbgeCid.Clear;
  EDT_Uf.Clear;
  EDT_IbgeUF.Clear;
  EDT_Cpf.SetFocus;
end;

procedure TfrmCadCredor.MKE_CEPEnter(Sender: TObject);
begin
  inherited;
  TMaskEdit(Sender).Color := clYellow;
end;

procedure TfrmCadCredor.MKE_CEPExit(Sender: TObject);
begin
  inherited;
  TMaskEdit(Sender).Color := clWindow;
end;

procedure TfrmCadCredor.PreencheCampos;
begin
  if strApiDataSet = 'stAPI' then  //consulta vem direto do banco
    begin  //consulta vem do consumo da API Horse
      IntID                := ds_Credores.DataSet.FieldByName('id').AsInteger;
      Edt_ID.Text          := ds_Credores.DataSet.FieldByName('id').AsString;
      EDT_Cpf.Text         := ds_Credores.DataSet.FieldByName('cpf').AsString;
      EDT_Nomecli.Text     := ds_Credores.DataSet.FieldByName('nome').AsString;
      MKE_CEP.Text         := ds_Credores.DataSet.FieldByName('cep').AsString;
      EDT_Logradouro.Text  := ds_Credores.DataSet.FieldByName('logradouro').AsString;
      EDT_Numero.Text      := ds_Credores.DataSet.FieldByName('numero').AsString;
      EDT_Complemento.Text := ds_Credores.DataSet.FieldByName('complemento').AsString;
      EDT_Bairro.Text      := ds_Credores.DataSet.FieldByName('bairro').AsString;
      EDT_Cidade.Text      := ds_Credores.DataSet.FieldByName('cidade').AsString;
      EDT_IbgeCid.Text     := ds_Credores.DataSet.FieldByName('ibge_cidade').AsString;
      EDT_Uf.Text          := ds_Credores.DataSet.FieldByName('sigla_uf').AsString;
      EDT_IbgeUF.Text      := ds_Credores.DataSet.FieldByName('sigla_uf').AsString;
    end;
end;

procedure TfrmCadCredor.PreencheDataSetCredores(strJSONValue: string);
var
  JsonObjArray: TJSONArray;
  JsonObjectJson: TJSONObject;
  strTOJSon: string;
  I: Integer;
begin
  //Processa o JSon para DataSet - Horse
  Application.ProcessMessages;

  JsonObjArray := TJSONObject.ParseJSONValue( strJSONValue ) as TJSONArray;

  for I := 0 to JsonObjArray.Count-1 do
    begin
      strTOJSon := JsonObjArray.Items[I].ToJSON;
      JsonObjectJson := TJSONObject.ParseJSONValue( strTOJSon ) as TJSONObject;

      TBCredores.Insert;
      TBCredoresid.AsString          := JsonObjectJson.GetValue('id').Value;
      TBCredorescpf.AsString         := JsonObjectJson.GetValue('cpf_cnpj').Value;
      TBCredoresnome.AsString        := JsonObjectJson.GetValue('nome').Value;
      TBCredoresCep.AsString         := JsonObjectJson.GetValue('cep').Value;
      TBCredoresLogradouro.AsString  := JsonObjectJson.GetValue('logradouro').Value;
      TBCredoresNumero.AsString      := JsonObjectJson.GetValue('numero').Value;
      TBCredoresComplemento.AsString := JsonObjectJson.GetValue('complemento').Value;
      TBCredoresBairro.AsString      := JsonObjectJson.GetValue('bairro').Value;
      TBCredoresCidade.AsString      := JsonObjectJson.GetValue('cidade').Value;
      TBCredoresSigla_uf.AsString    := JsonObjectJson.GetValue('sigla_uf').Value;
      TBCredoresIbge_cidade.AsString := JsonObjectJson.GetValue('ibge_cidade').Value;
      TBCredoresIbge_uf.AsString     := JsonObjectJson.GetValue('sigla_uf').Value;
      TBCredores.Post;
    end;
end;

end.
