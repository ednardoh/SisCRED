unit uPesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DB, FMTBcd, SqlExpr,
  Provider, DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.Intf, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.JSON, REST.Json;

type
  TFrmPesquisa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtNome: TEdit;
    btnPesquisar: TButton;
    btnSelecionar: TButton;
    btnCancelar: TButton;
    dbgPesquisa: TDBGrid;
    rdg_Ordenar: TRadioGroup;
    RESTResponse1: TRESTResponse;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    TBTipopgto: TFDMemTable;
    TBTipopgtoid: TIntegerField;
    TBTipopgtoTipopgto: TStringField;
    ds_Tipopgto: TDataSource;
    Label2: TLabel;
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
    TBClientes: TFDMemTable;
    TBClientesid: TIntegerField;
    TBClientescpf: TStringField;
    TBClientesnome: TWideStringField;
    TBClientesCep: TWideStringField;
    TBClientesLogradouro: TWideStringField;
    TBClientesNumero: TWideStringField;
    TBClientesBairro: TWideStringField;
    TBClientesCidade: TWideStringField;
    TBClientesSigla_uf: TWideStringField;
    TBClientesComplemento: TWideStringField;
    TBClientesIbge_cidade: TWideStringField;
    TBClientesIbge_uf: TWideStringField;
    ds_Clientes: TDataSource;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgPesquisaDblClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure dbgPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rdg_OrdenarClick(Sender: TObject);
  private
    { Private declarations }
    strApiDataSet: string;
    IntID: Integer;
    function IsNumber(strVal: string): boolean;
    procedure buscaRegistro;
    procedure BuscaTipopagto(strURL, strAText: string);
    procedure BuscaCredor(strURL, strAText: string);
    procedure BuscaCLiente(strURL, strAText: string); //busca Clientes
    procedure PreencheDataSetTipopgto(strJSONValue: string);
    procedure PreencheDataSetCredores(strJSONValue: string);
    procedure PreencheDataSetClientes(strJSONValue: string);
  public
    { Public declarations }
    gblNomeTabela,
    gblCodigo,
    gblNomepesquisa : String;
  end;

var
  FrmPesquisa: TFrmPesquisa;

implementation

{$R *.dfm}

Uses uDatamodulo;

procedure TFrmPesquisa.btnCancelarClick(Sender: TObject);
begin
  close;
end;

procedure TFrmPesquisa.btnSelecionarClick(Sender: TObject);
begin
  if gblNomeTabela = 'tb_tipopgto' then
  begin
    frmDatamodulo.gblValCodigo := dbgPesquisa.Columns.Grid.Fields[0].AsString;
    frmDatamodulo.gblValNome   := dbgPesquisa.Columns.Grid.Fields[1].AsString;
  end
  else if gblNomeTabela = 'tb_credores' then
       begin
         frmDatamodulo.gblValCodigo := dbgPesquisa.Columns.Grid.Fields[0].AsString;
         frmDatamodulo.gblValNome   := dbgPesquisa.Columns.Grid.Fields[2].AsString;
       end
  else if gblNomeTabela = 'tb_clientes' then
       begin
         frmDatamodulo.gblValCodigo := dbgPesquisa.Columns.Grid.Fields[0].AsString;
         frmDatamodulo.gblValNome   := dbgPesquisa.Columns.Grid.Fields[2].AsString;
       end;
  close;
end;

procedure TFrmPesquisa.BuscaCLiente(strURL, strAText: string);
var
  I: Integer;
  strJSON: string;
begin
  strApiDataSet := 'stAPI';
  TBClientes.Close;
  TBClientes.Open;
  TBClientes.EmptyDataSet;
  TBClientes.IndexFieldNames := 'id';   //s� para order por id
  dbgPesquisa.DataSource := Nil;
  dbgPesquisa.DataSource := ds_Clientes;
  TBClientes.Close;
  TBClientes.Open;

  RESTClient1.BaseURL := strURL + strAText;
  RESTRequest1.Method := rmGET;
  RESTRequest1.Execute;

  if RESTResponse1.StatusCode in [200,201,204] then
    begin
      PreencheDataSetClientes(RESTResponse1.Content);  //processa o JSon
    end;
end;

procedure TFrmPesquisa.BuscaCredor(strURL, strAText: string);
var
  I: Integer;
  strJSON: string;
begin
  strApiDataSet := 'stAPI';
  TBCredores.Close;
  TBCredores.Open;
  TBCredores.EmptyDataSet;
  TBCredores.IndexFieldNames := 'id';   //s� para order por id
  dbgPesquisa.DataSource := Nil;
  dbgPesquisa.DataSource := ds_Credores;
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

procedure TFrmPesquisa.buscaRegistro;
begin
  if gblNomeTabela = 'tb_tipopgto' then
    begin
      TBTipopgto.Close;
      TBTipopgto.Open;
      dbgPesquisa.DataSource := nil;
      dbgPesquisa.DataSource := ds_Tipopgto;
      Label1.Caption := 'Id :';
    end
  else
    if gblNomeTabela = 'tb_credores' then
      begin
        TBCredores.Close;
        TBCredores.Open;
        dbgPesquisa.DataSource := nil;
        dbgPesquisa.DataSource := ds_Credores;
        Label1.Caption := 'Valor :';
      end
  else
    if gblNomeTabela = 'tb_clientes' then
    begin
      TBClientes.Close;
      TBClientes.Open;
      dbgPesquisa.DataSource := nil;
      dbgPesquisa.DataSource := ds_Clientes;
      Label1.Caption := 'Valor :';
    end;
end;

procedure TFrmPesquisa.BuscaTipopagto(strURL, strAText: string);
var
  I: Integer;
  strJSON: string;
begin
  try
    strApiDataSet := 'stAPI';
    TBTipopgto.Close;
    TBTipopgto.Open;
    TBTipopgto.EmptyDataSet;
    TBTipopgto.IndexFieldNames := 'id';   //s� para order por id
    dbgPesquisa.DataSource := Nil;
    dbgPesquisa.DataSource := ds_Tipopgto;
    TBTipopgto.Close;
    TBTipopgto.Open;

    RESTClient1.BaseURL := strURL + strAText;
    RESTRequest1.Method := rmGET;
    RESTRequest1.Execute;

    if RESTResponse1.StatusCode in [200,201,204] then
      begin
        PreencheDataSetTipopgto(RESTResponse1.Content);  //processa o JSon
      end;

  finally
    RESTClient1.BaseURL   :='';
    RESTRequest1.Resource :='';
    RESTRequest1.Method   := rmGET;
    RESTRequest1.AddBody('');
  end;
end;

procedure TFrmPesquisa.FormShow(Sender: TObject);
begin
  buscaRegistro;
end;

function TFrmPesquisa.IsNumber(strVal: string): boolean;
begin
  if StrToIntDef(strVal, 0) = 0 then
    Result := False
  else
    Result := True;
end;

procedure TFrmPesquisa.PreencheDataSetClientes(strJSONValue: string);
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

      TBClientes.Insert;
      TBClientesid.AsString          := JsonObjectJson.GetValue('id').Value;
      TBClientescpf.AsString         := JsonObjectJson.GetValue('cpf').Value;
      TBClientesnome.AsString        := JsonObjectJson.GetValue('nome').Value;
      TBClientesCep.AsString         := JsonObjectJson.GetValue('cep').Value;
      TBClientesLogradouro.AsString  := JsonObjectJson.GetValue('logradouro').Value;
      TBClientesNumero.AsString      := JsonObjectJson.GetValue('numero').Value;
      TBClientesComplemento.AsString := JsonObjectJson.GetValue('complemento').Value;
      TBClientesBairro.AsString      := JsonObjectJson.GetValue('bairro').Value;
      TBClientesCidade.AsString      := JsonObjectJson.GetValue('cidade').Value;
      TBClientesSigla_uf.AsString    := JsonObjectJson.GetValue('sigla_uf').Value;
      TBClientesIbge_cidade.AsString := JsonObjectJson.GetValue('ibge_cidade').Value;
      TBClientesIbge_uf.AsString     := JsonObjectJson.GetValue('sigla_uf').Value;
      TBClientes.Post;
    end;
end;

procedure TFrmPesquisa.PreencheDataSetCredores(strJSONValue: string);
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

procedure TFrmPesquisa.PreencheDataSetTipopgto(strJSONValue: string);
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

      TBTipopgto.Insert;
      TBTipopgtoid.AsString          := JsonObjectJson.GetValue('id').Value;
      TBTipopgtoTipopgto.AsString    := JsonObjectJson.GetValue('tipopgto').Value;
      TBTipopgto.Post;
    end;
end;

procedure TFrmPesquisa.rdg_OrdenarClick(Sender: TObject);
begin
  buscaRegistro;
end;

procedure TFrmPesquisa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  Action := cafree;

end;

procedure TFrmPesquisa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_f3 then btnPesquisarClick(Self);
  if key = vk_f5 then btnSelecionarClick(Self);
  if key = vk_escape then btnCancelarClick(Self);
end;

procedure TFrmPesquisa.dbgPesquisaDblClick(Sender: TObject);
begin
  btnSelecionarClick(Self);
end;

procedure TFrmPesquisa.btnPesquisarClick(Sender: TObject);
begin
  if gblNomeTabela = 'tb_tipopgto' then
  begin
    if edtNome.Text = '' then
      BuscaTipopagto('http://localhost:9000/tipopgtoall','')
    else
      BuscaTipopagto('http://localhost:9000/tipopgtobyid/',Trim(edtNome.Text));
  end
  else if gblNomeTabela = 'tb_credores' then
       begin
         if edtNome.Text = '' then
           BuscaCredor('http://localhost:9000/credoresall','')
         else
           BuscaCredor('http://localhost:9000/credoresbyid/',trim(edtNome.Text));
       end
  else if gblNomeTabela = 'tb_clientes' then
       begin
         if edtNome.Text = '' then
           BuscaCLiente('http://localhost:9000/clientesall','')
         else
           if IsNumber(Trim(edtNome.Text)) then
             BuscaCLiente('http://localhost:9000/clientesbyid/',trim(edtNome.Text))
         else
           BuscaCLiente('http://localhost:9000/clientesbynome/',UpperCase(edtNome.Text));
       end;
end;

procedure TFrmPesquisa.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      dbgPesquisa.SetFocus;
    end;
end;

procedure TFrmPesquisa.dbgPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then btnSelecionarClick(Self);
end;

end.
