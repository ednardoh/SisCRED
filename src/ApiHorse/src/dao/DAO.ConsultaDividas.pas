unit DAO.ConsultaDividas;

interface

uses
  FireDAC.Comp.Client, uConexao, System.SysUtils, System.JSON,
  Controllers.Conexao, System.Generics.Collections, Model.Cliente;

type TConsultaDividasDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function ListDividasByCPF(ACPF: string) : TJSONArray;

end;

implementation

{ ConsultaDividasDAO }

constructor TConsultaDividasDAO.Create;
begin
  FConexao := TControllersConexao.GetInstance().Conexao;
end;

function TConsultaDividasDAO.ListDividasByCPF(ACPF: string): TJSONArray;
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
    vQry.SQL.Add(
    '  select c.CPF,                                                                                '+
    '     c.nome as NomeCLiente,                                                                    '+
    '     cr.cpf_cnpj,                                                                              '+
    '     cr.nome as RazaoSocialcredor,                                                             '+
    '     tp.tipopgto,                                                                              '+
    '     p.valor_total,                                                                            '+
    '     p.dt_primeira_parcela,                                                                    '+
    '     case when tp.tipopgto <> ''A VISTA'' then                                                 '+
    '       (CURRENT_DATE-TO_DATE(p.dt_primeira_parcela,''dd/mm/yyyy''))                            '+
    '     else                                                                                      '+
    '       0                                                                                       '+
    '     end AS Qdiaspriparc,                                                                      '+
    '     case when (case when (tp.tipopgto <> ''A VISTA'' and p.dt_primeira_parcela <> '''') then  '+
    '        (CURRENT_DATE-TO_DATE(p.dt_primeira_parcela,''dd/mm/yyyy''))                           '+
    '     else                                                                                      '+
    '      0                                                                                        '+
    '     end) > 0 then  ''Em Atraso''                                                              '+
    '     else ''Em Dia''                                                                           '+
    '     end as Statuspriparc,                                                                     '+
    '     p.vl_primeira_parcela,                                                                    '+
    '     p.dt_segunda_parcela,                                                                     '+
    '     case when (tp.tipopgto <> ''A VISTA'' and p.dt_segunda_parcela <> '''') then              '+
    '       (CURRENT_DATE-TO_DATE(p.dt_segunda_parcela,''dd/mm/yyyy''))                             '+
    '     else                                                                                      '+
    '      0                                                                                        '+
    '     end AS Qdiassegparc,                                                                      '+
    '     case when (case when (tp.tipopgto <> ''A VISTA'' and p.dt_segunda_parcela <> '''') then   '+
    '         (CURRENT_DATE-TO_DATE(p.dt_segunda_parcela,''dd/mm/yyyy''))                           '+
    '     else                                                                                      '+
    '       0                                                                                       '+
    '     end) > 0 then ''Em Atraso''                                                               '+
    '     else ''Em Dia''                                                                           '+
    '     end as Statussegparc,                                                                     '+
    '     p.vl_segunda_parcela,                                                                     '+
    '     p.dt_terceira_parcela,                                                                    '+
    '     case when (tp.tipopgto <> ''A VISTA'' and p.dt_terceira_parcela <> '''') then             '+
    '      (CURRENT_DATE-TO_DATE(p.dt_terceira_parcela,''dd/mm/yyyy''))                             '+
    '     else                                                                                      '+
    '       0                                                                                       '+
    '     end AS Qdiasterparc,                                                                      '+
    '     case when (case when (tp.tipopgto <> ''A VISTA'' and p.dt_terceira_parcela <> '''') then  '+
    '         (CURRENT_DATE-TO_DATE(p.dt_terceira_parcela,''dd/mm/yyyy''))                          '+
    '         else                                                                                  '+
    '         0                                                                                     '+
    '         end) > 0 then ''Em Atraso''                                                           '+
    '     else ''Em Dia''                                                                           '+
    '     end as Statusterparc,                                                                     '+
    '     p.vl_terceira_parcela,                                                                    '+
    '     p.dt_quarta_parcela,                                                                      '+
    '     case when (tp.tipopgto <> ''A VISTA'' and p.dt_quarta_parcela <> '''') then               '+
    '       (CURRENT_DATE-TO_DATE(p.dt_quarta_parcela,''dd/mm/yyyy''))                              '+
    '     else                                                                                      '+
    '      0                                                                                        '+
    '     end AS Qdiasquaparc,                                                                      '+
    '     case when (case when (tp.tipopgto <> ''A VISTA'' and p.dt_quarta_parcela <> '''') then    '+
    '         (CURRENT_DATE-TO_DATE(p.dt_quarta_parcela,''dd/mm/yyyy''))                            '+
    '     else                                                                                      '+
    '      0                                                                                        '+
    '     end) > 0 then ''Em Atraso''                                                               '+
    '     else ''Em Dia''                                                                           '+
    '     end as Statusquaparc,                                                                     '+
    '     p.vl_quarta_parcela                                                                       '+
    '  from tb_parcelas p                                                                           '+
    '  inner join tb_clientes c on c.id = p.id_cliente                                              '+
    '  inner join tb_credores cr on cr.id = p.id_credor                                             '+
    '  inner join tb_tipopgto tp on tp.id = p.id_tipo_pgto                                          '+
    '  where tp.tipopgto <> ''A VISTA''                                                             '+
    '    and c.cpf =:cpf                                                                            ');
    vQry.ParamByName('cpf').AsString :=ACPF;
    vQry.Open;
    while not vQry.Eof do
      begin
        oJson := TJSONObject.Create;
        oJson.AddPair('cpf'                  , vQry.FieldByName('cpf').AsString);
        oJson.AddPair('nomecliente'          , vQry.FieldByName('nomecliente').AsString);
        oJson.AddPair('cpf_cnpj'             , vQry.FieldByName('cpf_cnpj').AsString);
        oJson.AddPair('razaosocialcredor'    , vQry.FieldByName('razaosocialcredor').AsString);
        oJson.AddPair('tipopgto'             , vQry.FieldByName('tipopgto').AsString);
        oJson.AddPair('valor_total'          , vQry.FieldByName('valor_total').AsString);
        oJson.AddPair('dt_primeira_parcela'  , vQry.FieldByName('dt_primeira_parcela').AsString);
        oJson.AddPair('qdiaspriparc'         , TJSONNumber.Create(vQry.FieldByName('qdiaspriparc').AsInteger));
        oJson.AddPair('statuspriparc'        , vQry.FieldByName('statuspriparc').AsString);
        oJson.AddPair('vl_primeira_parcela'  , vQry.FieldByName('vl_primeira_parcela').AsString);
        oJson.AddPair('dt_segunda_parcela'   , vQry.FieldByName('dt_segunda_parcela').AsString);
        oJson.AddPair('qdiassegparc'         , TJSONNumber.Create(vQry.FieldByName('qdiassegparc').AsInteger));
        oJson.AddPair('statussegparc'        , vQry.FieldByName('statussegparc').AsString);
        oJson.AddPair('vl_segunda_parcela'   , vQry.FieldByName('vl_segunda_parcela').AsString);
        oJson.AddPair('dt_terceira_parcela'  , vQry.FieldByName('dt_terceira_parcela').AsString);
        oJson.AddPair('qdiasterparc'         , TJSONNumber.Create(vQry.FieldByName('qdiasterparc').AsInteger));
        oJson.AddPair('statusterparc'        , vQry.FieldByName('statusterparc').AsString);
        oJson.AddPair('vl_terceira_parcela'  , vQry.FieldByName('vl_terceira_parcela').AsString);
        oJson.AddPair('dt_quarta_parcela'    , vQry.FieldByName('dt_quarta_parcela').AsString);
        oJson.AddPair('qdiasquaparc'         , TJSONNumber.Create(vQry.FieldByName('qdiasquaparc').AsInteger));
        oJson.AddPair('statusquaparc'        , vQry.FieldByName('statusquaparc').AsString);
        oJson.AddPair('vl_quarta_parcela'    , vQry.FieldByName('vl_quarta_parcela').AsString);
        aJson.AddElement(oJson);
        vQry.Next;
      end;
      Result:=aJson;
  finally
    vQry.Free;
  end;
end;

end.
