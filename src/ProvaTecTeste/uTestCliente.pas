unit uTestCliente;

interface
uses
  TestFramework, FireDAC.Comp.Client, System.SysUtils,
  Vcl.Forms, DUnitX.TestFramework, REST.Response.Adapter,
  REST.Client, REST.Types, REST.Json, System.JSON;

type

  [TestFixture]
  TestTestProvatecCliente = class(TTestCase)
  strict private
    FRESTClient1: TRESTClient;
    FRESTRequest1: TRESTRequest;
    FRESTResponse1: TRESTResponse;
    FRESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
  public
    [Setup]
    procedure SetUp; override;
    [TearDown]
    procedure TearDown; override;

  published
    procedure TestIncluir;
    procedure TesteAlterar;
    procedure TesteExcluir;

  end;

implementation

procedure TestTestProvatecCliente.SetUp;
begin
  FRESTClient1  := TRESTClient.Create(nil);
  FRESTRequest1 := TRESTRequest.Create(nil);
  FRESTResponse1:= TRESTResponse.Create(nil);
  FRESTResponseDataSetAdapter := TRESTResponseDataSetAdapter.Create(nil);

  {SETUP}
  FRESTRequest1.Client:= FRESTClient1;
end;

procedure TestTestProvatecCliente.TearDown;
begin
  FRESTClient1.Free;
  FRESTRequest1.Free;
  FRESTResponse1.Free;
  FRESTResponseDataSetAdapter.Free;
end;

procedure TestTestProvatecCliente.TesteAlterar;
var
  oJson: TJSONObject;
begin
  try
    FRESTClient1.BaseURL       := 'http://localhost:9000/';
    FRESTRequest1.Resource     := 'clienteupdate';
    FRESTRequest1.Method       := rmPUT;
    oJson := TJSONObject.Create;
    oJson.AddPair('id'        , '15');
    oJson.AddPair('cpf'        , '71279094079');
    oJson.AddPair('nome'       , 'TESTE DE TESTE UNITARIO ALTERANDO');
    oJson.AddPair('cep'        , '99.999-999');
    oJson.AddPair('logradouro' , 'RUA TESTE DE TESTE UNITARIO ALTERANDO');
    oJson.AddPair('numero'     , '9999');
    oJson.AddPair('complemento', 'COMPL. DE ALTERANDO');
    oJson.AddPair('bairro'     , 'BAIRRO');
    oJson.AddPair('cidade'     , 'CIDADE');
    oJson.AddPair('ibge_cidade', '999999');
    oJson.AddPair('sigla_uf'   , 'AA');
    FRESTRequest1.AddBody(oJson);
    FRESTRequest1.Execute;
  finally
    oJson.Free;
    FRESTClient1.BaseURL   :='';
    FRESTRequest1.Resource :='';
    FRESTRequest1.Method   := rmGET;
    FRESTRequest1.AddBody('');
  end;
end;

procedure TestTestProvatecCliente.TesteExcluir;
begin
  FRESTClient1.BaseURL := 'http://localhost:9000/clientedelete/' + IntToStr(15);
  FRESTRequest1.Method := rmDELETE;
  FRESTRequest1.Execute;
end;

procedure TestTestProvatecCliente.TestIncluir;
var
  oJson: TJSONObject;
begin
  try
    FRESTClient1.BaseURL       := 'http://localhost:9000/';
    FRESTRequest1.Resource     :='clienteinsert';
    FRESTRequest1.Method       := rmPOST;
    oJson := TJSONObject.Create;
    oJson.AddPair('cpf'        , '71279094079');
    oJson.AddPair('nome'       , 'TESTE DE TESTE UNITARIO');
    oJson.AddPair('cep'        , '99.999-999');
    oJson.AddPair('logradouro' , 'RUA TESTE DE TESTE UNITARIO');
    oJson.AddPair('numero'     , '9999');
    oJson.AddPair('complemento', 'COMPL. DE TESTE');
    oJson.AddPair('bairro'     , 'BAIRRO');
    oJson.AddPair('cidade'     , 'CIDADE');
    oJson.AddPair('ibge_cidade', '999999');
    oJson.AddPair('sigla_uf'   , 'AA');
    FRESTRequest1.AddBody(oJson);
    FRESTRequest1.Execute;
  finally
    oJson.Free;
    FRESTClient1.BaseURL   :='';
    FRESTRequest1.Resource :='';
    FRESTRequest1.Method   := rmGET;
    FRESTRequest1.AddBody('');
  end;
end;

initialization
  RegisterTest(TestTestProvatecCliente.Suite);

end.
