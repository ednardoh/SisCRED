unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.Buttons, uDatamodulo, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, IPPeerClient, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, System.Net.HttpClient,
  REST.Types, System.Types, System.StrUtils, System.ImageList, Vcl.ImgList,
  Vcl.Imaging.pngimage, Datasnap.DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Json, Vcl.ComCtrls, Winapi.TlHelp32,
  ShellApi;

type
  TfrmCadCliente = class(TForm)
    pnl_Cadcli: TPanel;
    pnl_Client: TPanel;
    EDT_Nomecli: TEdit;
    Label1: TLabel;
    MKE_CEP: TMaskEdit;
    Btn_Cep: TButton;
    Label2: TLabel;
    Label3: TLabel;
    EDT_Logradouro: TEdit;
    EDT_Numero: TEdit;
    Label4: TLabel;
    EDT_Complemento: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    EDT_Cidade: TEdit;
    Label7: TLabel;
    EDT_IbgeCid: TEdit;
    Label8: TLabel;
    EDT_Uf: TEdit;
    Label9: TLabel;
    EDT_IbgeUF: TEdit;
    pnl_Botoes: TPanel;
    BTN_Inserir: TBitBtn;
    BTN_Editar: TBitBtn;
    BTN_Gravar: TBitBtn;
    BTN_Excluir: TBitBtn;
    BTN_Cancelar: TBitBtn;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    Label10: TLabel;
    EDT_Bairro: TEdit;
    pn_Contato: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    DBG_Contatos: TDBGrid;
    Panel3: TPanel;
    BTN_Contatos: TBitBtn;
    imgHorse: TImage;
    EDT_Pesquisacli: TEdit;
    BTN_Webapi: TBitBtn;
    Label11: TLabel;
    ds_Clientes: TDataSource;
    TBClientes: TFDMemTable;
    TBClientesid: TIntegerField;
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
    PGC_Clientes: TPageControl;
    TBS_Grdcliente: TTabSheet;
    TBS_Json: TTabSheet;
    DBG_CadCli: TDBGrid;
    MMO_Json: TMemo;
    pnl_Aguarde: TPanel;
    EDT_Cpf: TEdit;
    Label12: TLabel;
    TBClientescpf: TStringField;
    TBContatos: TFDMemTable;
    ds_Contatos: TDataSource;
    TBContatosid_cliente: TIntegerField;
    TBContatosid_contato: TIntegerField;
    TBContatosnome: TStringField;
    TBContatosdata_nasc: TStringField;
    TBContatosidade: TIntegerField;
    TBContatostelefone: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BTN_InserirClick(Sender: TObject);
    procedure BTN_EditarClick(Sender: TObject);
    procedure BTN_CancelarClick(Sender: TObject);
    procedure BTN_GravarClick(Sender: TObject);
    procedure BTN_ExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EDT_NomecliEnter(Sender: TObject);
    procedure EDT_NomecliExit(Sender: TObject);
    procedure MKE_CEPEnter(Sender: TObject);
    procedure MKE_CEPExit(Sender: TObject);
    procedure DBG_CadCliDblClick(Sender: TObject);
    procedure DBG_CadCliCellClick(Column: TColumn);
    procedure Btn_CepClick(Sender: TObject);
    procedure BTN_ContatosClick(Sender: TObject);
    procedure BTN_WebapiClick(Sender: TObject);
  private
    { Private declarations }
    strStatusCli: string;
    IntID: Integer;
    Objeto,
    Objt: TJsonObject;
    ParRows,
    PRows: TJsonPair;
    strApiDataSet: string;
    function FormatJson (InString: WideString): string;
    function ProcessExists(exeFileName: string): Boolean;
    function IsNumber(strVal: string): boolean;
    procedure DesabilitaBotao(bInserir,bEditar,bCancelar,bGravar,bExcluir: boolean);
    procedure LimpaCampos;
    procedure PreencheCampos;
    procedure GravaCliente;
    procedure ExcluiDados;
    procedure LeRegistros;
    procedure AtualizaCliente;
    procedure BuscaCep(strURL, strAText: string); //busca Cep
    procedure BuscaCLiente(strURL, strAText: string); //busca Clientes
    procedure BuscaContato(strURL, strAText: string); //busca Contatos
    procedure PreencheDataSetClientes(strJSONValue: string);
    procedure PreencheDataSetContatos(strJSONValue: string);
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}

uses uCadContato, superobject, supertypes, superdate;

procedure TfrmCadCliente.AtualizaCliente;
begin
  DesabilitaBotao(True, True, False, False, True);
end;

procedure TfrmCadCliente.BTN_CancelarClick(Sender: TObject);
begin
  DesabilitaBotao(True, True, False, False, True);
  strStatusCli :='';
end;

procedure TfrmCadCliente.Btn_CepClick(Sender: TObject);
begin
  BuscaCep('https://api.postmon.com.br/v1/cep/',MKE_CEP.Text);
end;

procedure TfrmCadCliente.BTN_ContatosClick(Sender: TObject);
begin
  frmCadContato :=TfrmCadContato.create(Self);
  frmCadContato.glbValIDCliente   := TBClientesid.AsString;
  frmCadContato.glbValNomeCliente := TBClientesnome.AsString;
  if TBContatosid_contato.AsInteger > 0 then
    begin //pode alterar os dados
      frmCadContato.gblID                   := TBContatosid_contato.AsString;  //id do contato
      frmCadContato.EDT_LNomeContato.Text   := TBContatosnome.AsString;
      frmCadContato.DTP_Nascimento.DateTime := TBContatosdata_nasc.AsDateTime;
      frmCadContato.EDT_Idade.Text          := TBContatosidade.AsString;
      frmCadContato.MKE_Telefone.Text       := TBContatostelefone.AsString;
    end;
  frmCadContato.ShowModal;
  AtualizaCliente; //Atualiza grid de contatos e clientes
end;

procedure TfrmCadCliente.BTN_EditarClick(Sender: TObject);
begin
  strStatusCli :='dsEditando';
  DesabilitaBotao(False, False, True, True, False);
  EDT_Nomecli.SetFocus;
end;

procedure TfrmCadCliente.BTN_ExcluirClick(Sender: TObject);
begin
  strStatusCli :='dsExcluindo';
  DesabilitaBotao(True, True, False, False, True);
  ExcluiDados;
  LeRegistros;
end;

procedure TfrmCadCliente.BTN_GravarClick(Sender: TObject);
begin
  DesabilitaBotao(True, True, False, False, True);
  GravaCliente;
  strStatusCli :='';
  ShowMessage('Dados foram gravados com exito.');
  LeRegistros;
end;

procedure TfrmCadCliente.BTN_InserirClick(Sender: TObject);
begin
  strStatusCli :='dsInserindo';
  DesabilitaBotao(False, False, True, True, False);
  LimpaCampos;
  EDT_Cpf.SetFocus;
end;

procedure TfrmCadCliente.BTN_WebapiClick(Sender: TObject);
begin
  if EDT_Pesquisacli.Text = '' then
    BuscaCLiente('http://localhost:9000/clientesall','')
  else
    if IsNumber(Trim(EDT_Pesquisacli.Text)) then
      BuscaCLiente('http://localhost:9000/clientesbyid/',trim(EDT_Pesquisacli.Text))
  else
    BuscaCLiente('http://localhost:9000/clientesbynome/',UpperCase(EDT_Pesquisacli.Text));
end;

procedure TfrmCadCliente.BuscaCep(strURL, strAText: string);
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

procedure TfrmCadCliente.BuscaCLiente(strURL, strAText: string);
var
  I: Integer;
  strJSON: string;
begin
  pnl_Aguarde.Visible := True;
  strApiDataSet := 'stAPI';
  TBClientes.Close;
  TBClientes.Open;
  TBClientes.EmptyDataSet;
  TBClientes.IndexFieldNames := 'id';   //só para order por id
  DBG_CadCli.DataSource := Nil;
  DBG_CadCli.DataSource := ds_Clientes;
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

procedure TfrmCadCliente.BuscaContato(strURL, strAText: string);
var
  I: Integer;
  strJSON: string;
begin
  pnl_Aguarde.Visible := True;
  strApiDataSet := 'stAPI';
  TBContatos.Close;
  TBContatos.Open;
  TBContatos.EmptyDataSet;
  TBContatos.IndexFieldNames := 'id_contato';   //só para order por id
  DBG_Contatos.DataSource := Nil;
  DBG_Contatos.DataSource := ds_Contatos;
  TBContatos.Close;
  TBContatos.Open;

  RESTClient1.BaseURL := strURL + strAText;
  RESTRequest1.Method := rmGET;
  RESTRequest1.Execute;

  if RESTResponse1.StatusCode in [200,201,204] then
    begin
      PreencheDataSetContatos(RESTResponse1.Content);  //processa o JSon
    end;
end;

procedure TfrmCadCliente.DBG_CadCliCellClick(Column: TColumn);
begin
  PreencheCampos;
end;

procedure TfrmCadCliente.DBG_CadCliDblClick(Sender: TObject);
begin
  PreencheCampos;
end;

procedure TfrmCadCliente.DesabilitaBotao(bInserir, bEditar, bCancelar, bGravar, bExcluir: boolean);
begin
  BTN_Inserir.Enabled  :=bInserir;
  BTN_Editar.Enabled   :=bEditar;
  BTN_Cancelar.Enabled :=bCancelar;
  BTN_Gravar.Enabled   :=bGravar;
  BTN_Excluir.Enabled  :=bExcluir;
end;

procedure TfrmCadCliente.EDT_NomecliEnter(Sender: TObject);
begin
  TEdit(Sender).Color := clYellow;
end;

procedure TfrmCadCliente.EDT_NomecliExit(Sender: TObject);
begin
  TEdit(Sender).Color := clWindow;
end;

procedure TfrmCadCliente.ExcluiDados;
begin
  if strStatusCli ='dsExcluindo' then
    begin
      if Application.messageBox('Deseja Realmente Apagar Esse Cliente?',
        'Confirmação',mb_YesNo+mb_IconInformation+mb_DefButton2) = IDYES then
        begin
          try
            Showmessage('Atenção! Os Contatos tabém serão excluidos.');
            RESTClient1.BaseURL := 'http://localhost:9000/contatodeletebyidcliente/' + IntToStr(IntID);
            RESTRequest1.Method := rmDELETE;
            RESTRequest1.Execute;

            RESTClient1.BaseURL   :='';
            RESTRequest1.Resource :='';
            RESTRequest1.Method   := rmGET;
            RESTRequest1.AddBody('');
          finally
            RESTClient1.BaseURL := 'http://localhost:9000/clientedelete/' + IntToStr(IntID);
            RESTRequest1.Method := rmDELETE;
            RESTRequest1.Execute;

            RESTClient1.BaseURL   :='';
            RESTRequest1.Resource :='';
            RESTRequest1.Method   := rmGET;
            RESTRequest1.AddBody('');
          end;
        end;
    end;
end;

function TfrmCadCliente.FormatJson(InString: WideString): string;
var
  Json : ISuperObject;
begin
  Json := TSuperObject.ParseString(PWideChar(InString), True);
  Result := Json.AsJson(true, false);
end;

procedure TfrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TfrmCadCliente.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key=vk_return then
     Perform(WM_nextdlgctl,0,0)
  else if Key=vk_escape then
     Perform(WM_nextdlgctl,1,0);
end;

procedure TfrmCadCliente.FormShow(Sender: TObject);
begin
  DesabilitaBotao(True, True, False, False, True);
  strApiDataSet := 'stDataSet';
  DBG_CadCli.DataSource := Nil;
  DBG_CadCli.DataSource := ds_Clientes;
  TBClientes.Open;
  TBContatos.Open;
  if not ProcessExists('ApiHorse.exe') then
    ShellExecute(handle,'open',PChar(ExtractFilepath(Application.ExeName)+'ApiHorse.exe'), '','',SW_SHOWMINIMIZED);
end;

procedure TfrmCadCliente.GravaCliente;
var
  oJson: TJSONObject;
begin
  if strStatusCli ='dsInserindo' then
    begin
      try
        RESTClient1.BaseURL       := 'http://localhost:9000/';
        RESTRequest1.Resource     :='clienteinsert';
        RESTRequest1.Method       := rmPOST;
        oJson := TJSONObject.Create;
        oJson.AddPair('cpf'        , EDT_Cpf.Text);
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
          RESTRequest1.Resource     :='clienteupdate';
          RESTRequest1.Method       := rmPUT;
          oJson := TJSONObject.Create;
          oJson.AddPair('id'         , TJSONNumber.Create(IntID));
          oJson.AddPair('cpf'        , EDT_Cpf.Text);
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

function TfrmCadCliente.IsNumber(strVal: string): boolean;
begin
  if StrToIntDef(strVal, 0) = 0 then
    Result := False
  else
    Result := True;
end;

procedure TfrmCadCliente.LeRegistros;
begin
  Refresh;
  BTN_WebapiClick(Self);
end;

procedure TfrmCadCliente.LimpaCampos;
begin
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

procedure TfrmCadCliente.MKE_CEPEnter(Sender: TObject);
begin
  TMaskEdit(Sender).Color := clYellow;
end;

procedure TfrmCadCliente.MKE_CEPExit(Sender: TObject);
begin
  TMaskEdit(Sender).Color := clWindow;
end;

procedure TfrmCadCliente.PreencheCampos;
begin
  if strApiDataSet = 'stAPI' then  //consulta vem direto do banco
    begin  //consulta vem do consumo da API Horse
      IntID                := ds_Clientes.DataSet.FieldByName('id').AsInteger;
      EDT_Cpf.Text         := ds_Clientes.DataSet.FieldByName('cpf').AsString;
      EDT_Nomecli.Text     := ds_Clientes.DataSet.FieldByName('nome').AsString;
      MKE_CEP.Text         := ds_Clientes.DataSet.FieldByName('cep').AsString;
      EDT_Logradouro.Text  := ds_Clientes.DataSet.FieldByName('logradouro').AsString;
      EDT_Numero.Text      := ds_Clientes.DataSet.FieldByName('numero').AsString;
      EDT_Complemento.Text := ds_Clientes.DataSet.FieldByName('complemento').AsString;
      EDT_Bairro.Text      := ds_Clientes.DataSet.FieldByName('bairro').AsString;
      EDT_Cidade.Text      := ds_Clientes.DataSet.FieldByName('cidade').AsString;
      EDT_IbgeCid.Text     := ds_Clientes.DataSet.FieldByName('ibge_cidade').AsString;
      EDT_Uf.Text          := ds_Clientes.DataSet.FieldByName('sigla_uf').AsString;
      EDT_IbgeUF.Text      := ds_Clientes.DataSet.FieldByName('sigla_uf').AsString;
    end;
    BTN_Contatos.Enabled := IntID > 0;
    if IntID > 0 then
    begin
      BuscaContato('http://localhost:9000/contatobyidcliente/',IntID.ToString);
    end;
end;

procedure TfrmCadCliente.PreencheDataSetClientes(strJSONValue: string);
var
  JsonObjArray: TJSONArray;
  JsonObjectJson: TJSONObject;
  strTOJSon: string;
  I: Integer;
begin
  //Processa o JSon para DataSet - Horse
  Application.ProcessMessages;
  MMO_Json.Lines.Clear;
  MMO_Json.Lines.Add(FormatJson(strJSONValue));

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
   pnl_Aguarde.Visible := False;
end;

procedure TfrmCadCliente.PreencheDataSetContatos(strJSONValue: string);
var
  JsonObjArray: TJSONArray;
  JsonObjectJson: TJSONObject;
  strTOJSon: string;
  I: Integer;
begin
  //Processa o JSon para DataSet - Horse
  Application.ProcessMessages;
  MMO_Json.Lines.Clear;
  MMO_Json.Lines.Add(FormatJson(strJSONValue));

  JsonObjArray := TJSONObject.ParseJSONValue( strJSONValue ) as TJSONArray;

  for I := 0 to JsonObjArray.Count-1 do
    begin
      strTOJSon := JsonObjArray.Items[I].ToJSON;
      JsonObjectJson := TJSONObject.ParseJSONValue( strTOJSon ) as TJSONObject;

      TBContatos.Insert;
      TBContatosid_contato.AsString  := JsonObjectJson.GetValue('id_contato').Value;
      TBContatosnome.AsString        := JsonObjectJson.GetValue('nome').Value;
      TBContatosdata_nasc.AsString   := JsonObjectJson.GetValue('data_nasc').Value;
      TBContatosidade.AsString       := JsonObjectJson.GetValue('idade').Value;
      TBContatostelefone.AsString    := JsonObjectJson.GetValue('telefone').Value;
      TBContatosid_cliente.AsString  := JsonObjectJson.GetValue('id_cliente').Value;
      TBContatos.Post;
    end;
   pnl_Aguarde.Visible := False;
end;

function TfrmCadCliente.ProcessExists(exeFileName: string): Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
    begin
      Result := True;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

end.
