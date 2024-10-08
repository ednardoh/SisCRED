unit Controllers.Contato;

interface

uses Horse, DataSet.Serialize, System.JSON, Data.DB,
     DAO.Contato, System.SysUtils;

procedure Registry;
procedure ListByIdCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure DeleteById(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure DeleteByIdCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

Uses Model.Contato;

procedure ListByIdCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOContato: TContatoDAO;
  iId: Integer;
begin
  try
    LDAOContato := TContatoDAO.Create;
    iId := StrToInt(Req.Params.Items['id']);
    Res.Send<TJSONArray>(LDAOContato.ListByIdCliente(iId));
  finally
    LDAOContato.Free;
  end;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOContato: TContatoDAO;
  oJson: TJSONObject;
  ContatoModel: TModelContato;
begin
  try
    if Req.Body.IsEmpty then
      raise Exception.Create('Dados do Contato n�o encontrado.');
    LDAOContato := TContatoDAO.Create;
    ContatoModel := TModelContato.Create;
    oJson := Req.Body<TJSONObject>;
    ContatoModel.id_contato  := 0;
    ContatoModel.nome        := oJson.GetValue<string>('nome');
    ContatoModel.data_nasc   := oJson.GetValue<string>('data_nasc');
    ContatoModel.idade       := oJson.GetValue<integer>('idade');
    ContatoModel.telefone    := oJson.GetValue<string>('telefone');
    ContatoModel.id_cliente  := oJson.GetValue<integer>('id_cliente');
    LDAOContato.Insert(ContatoModel);
    Res.Send<TJSONObject>(oJson).Status(THTTPStatus.Created);
  finally
    LDAOContato.Free;
    ContatoModel.Free;
  end;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOContato: TContatoDAO;
  oJson: TJSONObject;
  ContatoModel: TModelContato;
begin
  try
    if Req.Body.IsEmpty then
      raise Exception.Create('Dados do Contato n�o encontrado.');
    LDAOContato := TContatoDAO.Create;
    ContatoModel := TModelContato.Create;
    oJson := Req.Body<TJSONObject>;
    ContatoModel.id_contato  := oJson.GetValue<integer>('id_contato');
    ContatoModel.nome        := oJson.GetValue<string>('nome');
    ContatoModel.data_nasc   := oJson.GetValue<string>('data_nasc');
    ContatoModel.idade       := oJson.GetValue<integer>('idade');
    ContatoModel.telefone    := oJson.GetValue<string>('telefone');
    LDAOContato.Update(ContatoModel);
    Res.Send<TJSONObject>(oJson).Status(THTTPStatus.OK);
  finally
    LDAOContato.Free;
    ContatoModel.Free;
  end;
end;

procedure DeleteById(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOContato: TContatoDAO;
  iId: Integer;
begin
  if Req.Params.Count = 0 then
    raise Exception.Create('id n�o encontrado.');
  try
    LDAOContato := TContatoDAO.Create;
    iId := StrToInt(Req.Params.Items['id']);
    LDAOContato.DeleteById(iId);
    Res.Send<TJSONObject>(TJSONObject.Create.AddPair('message', 'Contato deletado com sucesso.'));
  finally
    LDAOContato.Free;
  end;
end;

procedure DeleteByIdCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOContato: TContatoDAO;
  iId: Integer;
begin
  if Req.Params.Count = 0 then
    raise Exception.Create('id n�o encontrado.');
  try
    LDAOContato := TContatoDAO.Create;
    iId := StrToInt(Req.Params.Items['id']);
    LDAOContato.DeleteByIdCliente(iId);
    Res.Send<TJSONObject>(TJSONObject.Create.AddPair('message', 'Contato deletado com sucesso.'));
  finally
    LDAOContato.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/contatobyidcliente/:id', ListByIdCliente);
  THorse.Post('/contatoinsert', Insert);
  THorse.Put('/contatoupdate', Update);
  THorse.Delete('/contatodeletebyid/:id', DeleteById);
  THorse.Delete('/contatodeletebyidcliente/:id', DeleteByIdCliente);
end;

end.
