unit Controllers.Tipopgto;

interface

uses Horse, DataSet.Serialize, System.JSON, Data.DB,
     DAO.Tipopgto, System.SysUtils;

procedure Registry;
procedure ListById(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

Uses Model.Tipopgto;

procedure ListAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOTipopgto: TTipopgtoDAO;
  iId: Integer;
begin
  try
    LDAOTipopgto := TTipopgtoDAO.Create;
    Res.Send<TJSONArray>(LDAOTipopgto.ListAll());
  finally
    LDAOTipopgto.Free;
  end;
end;

procedure ListById(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOTipopgto: TTipopgtoDAO;
  iId: Integer;
begin
  try
    LDAOTipopgto := TTipopgtoDAO.Create;
    iId := StrToInt(Req.Params.Items['id']);
    Res.Send<TJSONArray>(LDAOTipopgto.ListById(iId));
  finally
    LDAOTipopgto.Free;
  end;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOTipopgto: TTipopgtoDAO;
  oJson: TJSONObject;
  TipopgtoModel: TModelTipopgto;
begin
  try
    if Req.Body.IsEmpty then
      raise Exception.Create('Dados do Tipopgto n�o encontrado.');
    LDAOTipopgto  := TTipopgtoDAO.Create;
    TipopgtoModel := TModelTipopgto.Create;
    oJson := Req.Body<TJSONObject>;
    TipopgtoModel.id       := 0;
    TipopgtoModel.tipopgto := oJson.GetValue<string>('tipopgto');
    LDAOTipopgto.Insert(TipopgtoModel);
    Res.Send<TJSONObject>(oJson).Status(THTTPStatus.Created);
  finally
    LDAOTipopgto.Free;
    TipopgtoModel.Free;
  end;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOTipopgto: TTipopgtoDAO;
  oJson: TJSONObject;
  TipopgtoModel: TModelTipopgto;
begin
  try
    if Req.Body.IsEmpty then
      raise Exception.Create('Dados do Tipopgto n�o encontrado.');
    LDAOTipopgto  := TTipopgtoDAO.Create;
    TipopgtoModel := TModelTipopgto.Create;
    oJson := Req.Body<TJSONObject>;
    TipopgtoModel.id       := oJson.GetValue<integer>('id');
    TipopgtoModel.tipopgto := oJson.GetValue<string>('tipopgto');
    LDAOTipopgto.Update(TipopgtoModel);
    Res.Send<TJSONObject>(oJson).Status(THTTPStatus.OK);
  finally
    LDAOTipopgto.Free;
    TipopgtoModel.Free;
  end;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOTipopgto: TTipopgtoDAO;
  iId: Integer;
begin
  if Req.Params.Count = 0 then
    raise Exception.Create('id n�o encontrado.');
  try
    LDAOTipopgto := TTipopgtoDAO.Create;
    iId := StrToInt(Req.Params.Items['id']);
    LDAOTipopgto.Delete(iId);
    Res.Send<TJSONObject>(TJSONObject.Create.AddPair('message', 'Tipopgto deletado com sucesso.'));
  finally
    LDAOTipopgto.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/tipopgtoall', ListAll);
  THorse.Get('/tipopgtobyid/:id', ListById);
  THorse.Post('/tipopgtoinsert', Insert);
  THorse.Put('/tipopgtoupdate', Update);
  THorse.Delete('/tipopgtodelete/:id', Delete);
end;


end.
