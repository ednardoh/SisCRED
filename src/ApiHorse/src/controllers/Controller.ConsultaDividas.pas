unit Controller.ConsultaDividas;

interface

uses Horse, DataSet.Serialize, System.JSON, Data.DB,
     DAO.ConsultaDividas, System.SysUtils;


procedure Registry;
procedure ListDividasByCPF(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

Uses Model.ConsultaDividas;

procedure ListDividasByCPF(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LDAOConsultaDividas: TConsultaDividasDAO;
  strCPF: string;
begin
  try
    LDAOConsultaDividas := TConsultaDividasDAO.Create;
    strCPF := Req.Params.Items['CPF'];
    Res.Send<TJSONArray>(LDAOConsultaDividas.ListDividasByCPF(strCPF));
  finally
    LDAOConsultaDividas.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/consultardividas/:CPF', ListDividasByCPF);
end;

end.
