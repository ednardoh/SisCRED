unit DAO.Cliente;

interface

uses
  FireDAC.Comp.Client, uConexao, System.SysUtils, System.JSON,
  Controllers.Conexao, System.Generics.Collections, Model.Cliente;

type
  TClienteDAO = class
    private
      FConexao: TConexao;
    public
      constructor Create;

      function ListByNome(ANome: string) : TJSONArray;
      function ListById(AId: Integer)    : TJSONArray;
      function ListAll()                 : TJSONArray;
      procedure Insert(AClienteModel: TModelCliente);
      procedure Update(AClienteModel: TModelCliente);
      procedure Delete(AId: Integer);

  end;

implementation

{ TClienteDAO }

constructor TClienteDAO.Create;
begin
  FConexao := TControllersConexao.GetInstance().Conexao;
end;

procedure TClienteDAO.Insert(AClienteModel: TModelCliente);
var
  vQry: TFDQuery;
begin
  try
    vQry:= FConexao.CriarQuery();
    try
      vQry.Connection.StartTransaction;
      vQry.ExecSQL('insert into tb_clientes(cpf,          '+
                   '                        nome,         '+
                   '                        cep,          '+
                   '                        logradouro,   '+
                   '                        numero,       '+
                   '                        complemento,  '+
                   '                        bairro,       '+
                   '                        cidade,       '+
                   '                        ibge_cidade,  '+
                   '                        sigla_uf)     '+
                   'values (                              '+
                   '                        :cpf,         '+
                   '                        :nome,        '+
                   '                        :cep,         '+
                   '                        :logradouro,  '+
                   '                        :numero,      '+
                   '                        :complemento, '+
                   '                        :bairro,      '+
                   '                        :cidade,      '+
                   '                        :ibge_cidade, '+
                   '                        :sigla_uf)    ',
      [AClienteModel.cpf,
       AClienteModel.Nome,
       AClienteModel.cep,
       AClienteModel.logradouro,
       AClienteModel.numero,
       AClienteModel.complemento,
       AClienteModel.bairro,
       AClienteModel.cidade,
       AClienteModel.ibge_cidade,
       AClienteModel.sigla_uf]);
      vQry.Connection.Commit;
    except
    on E: Exception do
      begin
        VQry.Connection.Rollback;  //desfaz a transa��o
      end;
    end;
  finally
    VQry.Free;
  end;
end;

procedure TClienteDAO.Update(AClienteModel: TModelCliente);
var
  vQry: TFDQuery;
begin
  try
    vQry:= FConexao.CriarQuery();
    try
      vQry.Connection.StartTransaction;
      vQry.close;
      vQry.SQL.Clear;
      vQry.SQL.Add('update tb_clientes set  cpf        =:cpf,          '+
                   '                        nome       =:nome,         '+
                   '                        cep        =:cep,          '+
                   '                        logradouro =:logradouro,   '+
                   '                        numero     =:numero,       '+
                   '                        complemento=:complemento,  '+
                   '                        bairro     =:bairro,       '+
                   '                        cidade     =:cidade,       '+
                   '                        ibge_cidade=:ibge_cidade,  '+
                   '                        sigla_uf   =:sigla_uf      '+
                   ' where id=:id                                      ');

      vQry.ParamByName('id').AsInteger         := AClienteModel.id;
      vQry.ParamByName('cpf').AsString         := AClienteModel.cpf;
      vQry.ParamByName('Nome').AsString        := AClienteModel.Nome;
      vQry.ParamByName('cep').AsString         := AClienteModel.cep;
      vQry.ParamByName('logradouro').AsString  := AClienteModel.logradouro;
      vQry.ParamByName('numero').AsString      := AClienteModel.numero;
      vQry.ParamByName('complemento').AsString := AClienteModel.complemento;
      vQry.ParamByName('bairro').AsString      := AClienteModel.bairro;
      vQry.ParamByName('cidade').AsString      := AClienteModel.cidade;
      vQry.ParamByName('ibge_cidade').AsString := AClienteModel.ibge_cidade;
      vQry.ParamByName('sigla_uf').AsString    := AClienteModel.sigla_uf;

      vQry.ExecSQL;
      vQry.Connection.Commit;
    except
    on E: Exception do
      begin
        VQry.Connection.Rollback;  //desfaz a transa��o
      end;
    end;
  finally
    VQry.Free;
  end;
end;

procedure TClienteDAO.Delete(AId: Integer);
var
  vQry: TFDQuery;
begin
  try
    vQry:= FConexao.CriarQuery();
    try
      vQry.Connection.StartTransaction;
      vQry.close;
      vQry.SQL.Clear;
      vQry.SQL.Add('delete from tb_clientes where id=:id ');
      vQry.ParamByName('id').AsInteger := AId;
      vQry.ExecSQL;
      vQry.Connection.Commit;
    except
    on E: Exception do
      begin
        VQry.Connection.Rollback;  //desfaz a transa��o
      end;
    end;
  finally
    vQry.Free;
  end;
end;

function TClienteDAO.ListById(AId: Integer): TJSONArray;
var
  vQry: TFDQuery;
  aJson: TJSONArray;
  oJson: TJSONObject;
begin
  vQry:= FConexao.CriarQuery();
  aJson := TJSONArray.Create;
  try
    vQry.close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select c.id,           ' +
                 '       c.cpf,          ' +
                 '       c.nome,         ' +
                 '       c.cep,          ' +
                 '       c.logradouro,   ' +
                 '       c.numero,       ' +
                 '       c.complemento,  ' +
                 '       c.bairro,       ' +
                 '       c.cidade,       ' +
                 '       c.ibge_cidade,  ' +
                 '       c.sigla_uf      ' +
                 'from tb_clientes c     ' +
                 ' where c.id=:id        ');
    vQry.ParamByName('id').AsInteger := AId;
    vQry.Open;
    while not vQry.Eof do
      begin
        oJson := TJSONObject.Create;
        oJson.AddPair('id'         , TJSONNumber.Create(vQry.FieldByName('id').AsInteger));
        oJson.AddPair('cpf'        , vQry.FieldByName('cpf').AsString);
        oJson.AddPair('nome'       , vQry.FieldByName('nome').AsString);
        oJson.AddPair('cep'        , vQry.FieldByName('cep').AsString);
        oJson.AddPair('logradouro' , vQry.FieldByName('logradouro').AsString);
        oJson.AddPair('numero'     , vQry.FieldByName('numero').AsString);
        oJson.AddPair('complemento', vQry.FieldByName('complemento').AsString);
        oJson.AddPair('bairro'     , vQry.FieldByName('bairro').AsString);
        oJson.AddPair('cidade'     , vQry.FieldByName('cidade').AsString);
        oJson.AddPair('ibge_cidade', vQry.FieldByName('ibge_cidade').AsString);
        oJson.AddPair('sigla_uf'   , vQry.FieldByName('sigla_uf').AsString);
        aJson.AddElement(oJson);
        vQry.Next;
      end;
      Result:=aJson;
  finally
    vQry.Free;
  end;
end;

function TClienteDAO.ListByNome(ANome: string): TJSONArray;
var
  vQry: TFDQuery;
  aJson: TJSONArray;
  oJson: TJSONObject;
begin
  vQry  := FConexao.CriarQuery();
  aJson := TJSONArray.Create;
  try
    vQry.close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select c.id,           ' +
                 '       c.cpf,          ' +
                 '       c.nome,         ' +
                 '       c.cep,          ' +
                 '       c.logradouro,   ' +
                 '       c.numero,       ' +
                 '       c.complemento,  ' +
                 '       c.bairro,       ' +
                 '       c.cidade,       ' +
                 '       c.ibge_cidade,  ' +
                 '       c.sigla_uf      ' +
                 'from tb_clientes c     ' +
                 ' where Nome Like :Nome ');
    vQry.ParamByName('nome').AsString := '%'+ANome+'%';
    vQry.Open;
    while not vQry.Eof do
      begin
        oJson := TJSONObject.Create;
        oJson.AddPair('id'         , TJSONNumber.Create(vQry.FieldByName('id').AsInteger));
        oJson.AddPair('cpf'        , vQry.FieldByName('cpf').AsString);
        oJson.AddPair('nome'       , vQry.FieldByName('nome').AsString);
        oJson.AddPair('cep'        , vQry.FieldByName('cep').AsString);
        oJson.AddPair('logradouro' , vQry.FieldByName('logradouro').AsString);
        oJson.AddPair('numero'     , vQry.FieldByName('numero').AsString);
        oJson.AddPair('complemento', vQry.FieldByName('complemento').AsString);
        oJson.AddPair('bairro'     , vQry.FieldByName('bairro').AsString);
        oJson.AddPair('cidade'     , vQry.FieldByName('cidade').AsString);
        oJson.AddPair('ibge_cidade', vQry.FieldByName('ibge_cidade').AsString);
        oJson.AddPair('sigla_uf'   , vQry.FieldByName('sigla_uf').AsString);
        aJson.AddElement(oJson);
        vQry.Next;
      end;
      Result:=aJson;
  finally
    vQry.Free;
  end;
end;

function TClienteDAO.ListAll: TJSONArray;
var
  vQry: TFDQuery;
  aJson: TJSONArray;
  oJson: TJSONObject;
begin
  vQry:= FConexao.CriarQuery();
  aJson := TJSONArray.Create;
  try
    vQry.close;
    vQry.SQL.Clear;
    vQry.SQL.Add('select c.id,           ' +
                 '       c.cpf,          ' +
                 '       c.nome,         ' +
                 '       c.cep,          ' +
                 '       c.logradouro,   ' +
                 '       c.numero,       ' +
                 '       c.complemento,  ' +
                 '       c.bairro,       ' +
                 '       c.cidade,       ' +
                 '       c.ibge_cidade,  ' +
                 '       c.sigla_uf      ' +
                 'from tb_clientes c     ');
    vQry.Open;
    while not vQry.Eof do
      begin
        oJson := TJSONObject.Create;
        oJson.AddPair('id'         , TJSONNumber.Create(vQry.FieldByName('id').AsInteger));
        oJson.AddPair('cpf'        , vQry.FieldByName('cpf').AsString);
        oJson.AddPair('nome'       , vQry.FieldByName('nome').AsString);
        oJson.AddPair('cep'        , vQry.FieldByName('cep').AsString);
        oJson.AddPair('logradouro' , vQry.FieldByName('logradouro').AsString);
        oJson.AddPair('numero'     , vQry.FieldByName('numero').AsString);
        oJson.AddPair('complemento', vQry.FieldByName('complemento').AsString);
        oJson.AddPair('bairro'     , vQry.FieldByName('bairro').AsString);
        oJson.AddPair('cidade'     , vQry.FieldByName('cidade').AsString);
        oJson.AddPair('ibge_cidade', vQry.FieldByName('ibge_cidade').AsString);
        oJson.AddPair('sigla_uf'   , vQry.FieldByName('sigla_uf').AsString);
        aJson.AddElement(oJson);
        vQry.Next;
      end;
      Result:=aJson;
  finally
    vQry.Free;
  end;
end;

end.
