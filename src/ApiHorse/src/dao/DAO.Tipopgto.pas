unit DAO.Tipopgto;

interface

uses
  FireDAC.Comp.Client, uConexao, System.SysUtils, System.JSON,
  Controllers.Conexao, System.Generics.Collections, Model.Tipopgto;

type TTipopgtoDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;

  function ListAll()  : TJSONArray;
  function ListById(AId: Integer): TJSONArray;
  procedure Insert(ATipopgtoModel: TModelTipopgto);
  procedure Update(ATipopgtoModel: TModelTipopgto);
  procedure Delete(AId: Integer);

end;

implementation

{ TDAOTipopgto }

constructor TTipopgtoDAO.Create;
begin
  FConexao := TControllersConexao.GetInstance().Conexao;
end;

function TTipopgtoDAO.ListAll: TJSONArray;
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
    vQry.SQL.Add('select c.id,        ' +
                 '       c.tipopgto   ' +
                 'from tb_tipopgto c  ');
    vQry.Open;
    while not vQry.Eof do
      begin
        oJson := TJSONObject.Create;
        oJson.AddPair('id'       , TJSONNumber.Create(vQry.FieldByName('id').AsInteger));
        oJson.AddPair('tipopgto' , vQry.FieldByName('tipopgto').AsString);
        aJson.AddElement(oJson);
        vQry.Next;
      end;
      Result:=aJson;
  finally
    vQry.Free;
  end;
end;

function TTipopgtoDAO.ListById(AId: Integer): TJSONArray;
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
    vQry.SQL.Add('select c.id,        ' +
                 '       c.tipopgto   ' +
                 'from tb_tipopgto c  ' +
                 ' where c.id=:id ');
    vQry.ParamByName('id').AsInteger := AId;
    vQry.Open;
    while not vQry.Eof do
      begin
        oJson := TJSONObject.Create;
        oJson.AddPair('id'       , TJSONNumber.Create(vQry.FieldByName('id').AsInteger));
        oJson.AddPair('tipopgto' , vQry.FieldByName('tipopgto').AsString);
        aJson.AddElement(oJson);
        vQry.Next;
      end;
      Result:=aJson;
  finally
    vQry.Free;
  end;
end;

procedure TTipopgtoDAO.Insert(ATipopgtoModel: TModelTipopgto);
var
  vQry: TFDQuery;
begin
  try
    vQry:= FConexao.CriarQuery();
    try
      vQry.Connection.StartTransaction;
      vQry.close;
      vQry.SQL.Clear;
      vQry.SQL.Add('insert into tb_tipopgto( tipopgto )   '+
                   'values (                :tipopgto )   ');
      vQry.ParamByName('tipopgto').AsString    := ATipopgtoModel.tipopgto;
      vQry.ExecSQL;
      vQry.Connection.Commit;
    except
    on E: Exception do
      begin
        VQry.Connection.Rollback;  //desfaz a transação
      end;
    end;
  finally
    VQry.Free;
  end;
end;

procedure TTipopgtoDAO.Update(ATipopgtoModel: TModelTipopgto);
var
  vQry: TFDQuery;
begin
  try
    vQry:= FConexao.CriarQuery();
    try
      vQry.Connection.StartTransaction;
      vQry.close;
      vQry.SQL.Clear;
      vQry.SQL.Add('update tb_tipopgto set tipopgto =:tipopgto '+
                   ' where id=:id ');
      vQry.ParamByName('id').AsInteger      := ATipopgtoModel.id;
      vQry.ParamByName('tipopgto').AsString := ATipopgtoModel.tipopgto;
      vQry.ExecSQL;
      vQry.Connection.Commit;
    except
    on E: Exception do
      begin
        VQry.Connection.Rollback;  //desfaz a transação
      end;
    end;
  finally
    VQry.Free;
  end;
end;

procedure TTipopgtoDAO.Delete(AId: Integer);
var
  vQry: TFDQuery;
begin
  try
    vQry:= FConexao.CriarQuery();
    try
      vQry.Connection.StartTransaction;
      vQry.close;
      vQry.SQL.Clear;
      vQry.SQL.Add('delete from tb_tipopgto where id=:id ');
      vQry.ParamByName('id').AsInteger := AId;
      vQry.ExecSQL;
      vQry.Connection.Commit;
    except
    on E: Exception do
      begin
        VQry.Connection.Rollback;  //desfaz a transação
      end;
    end;
  finally
    VQry.Free;
  end;
end;

end.
