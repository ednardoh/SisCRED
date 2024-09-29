unit Model.Parcela;

interface

uses
  FireDAC.Comp.Client, uConexao, System.SysUtils, System.JSON,
  Controllers.Conexao, System.Generics.Collections;

type TParcelaModel = class
  private
    Fid_parcelas         : integer;
    Fid_tipo_pgto        : integer;
    Fid_credor           : integer;
    Fid_cliente          : integer;
    Fvalor_total         : string;
    Fdt_primeira_parcela : string;
    Fvl_primeira_parcela : string;
    Fdt_segunda_parcela  : string;
    Fvl_segunda_parcela  : string;
    Fdt_terceira_parcela : string;
    Fvl_terceira_parcela : string;
    Fdt_quarta_parcela   : string;
    Fvl_quarta_parcela   : string;
    Fstatus              : integer;

    procedure Setid_parcelas(const Value: integer);
    procedure Setid_tipo_pgto(const Value: integer);
    procedure Setid_credor(const Value: integer);
    procedure Setid_cliente(const Value: integer);
    procedure Setvalor_total(const Value: string);
    procedure Setdt_primeira_parcela(const Value: string);
    procedure Setvl_primeira_parcela(const Value: string);
    procedure Setdt_segunda_parcela(const Value: string);
    procedure Setvl_segunda_parcela(const Value: string);
    procedure Setdt_terceira_parcela(const Value: string);
    procedure Setvl_terceira_parcela(const Value: string);
    procedure Setdt_quarta_parcela(const Value: string);
    procedure Setvl_quarta_parcela(const Value: string);
    procedure Setstatus(const Value: integer);
  public
    property id_parcelas         : integer read Fid_parcelas write Setid_parcelas;
    property id_tipo_pgto        : integer read Fid_tipo_pgto write Setid_tipo_pgto;
    property id_credor           : integer read Fid_credor write Setid_credor;
    property id_cliente          : integer read Fid_cliente write Setid_cliente;
    property valor_total         : string  read Fvalor_total write Setvalor_total;
    property dt_primeira_parcela : string  read Fdt_primeira_parcela write Setdt_primeira_parcela;
    property vl_primeira_parcela : string  read Fvl_primeira_parcela write Setvl_primeira_parcela;
    property dt_segunda_parcela  : string  read Fdt_segunda_parcela write Setdt_segunda_parcela;
    property vl_segunda_parcela  : string  read Fvl_segunda_parcela write Setvl_segunda_parcela;
    property dt_terceira_parcela : string  read Fdt_terceira_parcela write Setdt_terceira_parcela;
    property vl_terceira_parcela : string  read Fvl_terceira_parcela write Setvl_terceira_parcela;
    property dt_quarta_parcela   : string  read Fdt_quarta_parcela write Setdt_quarta_parcela;
    property vl_quarta_parcela   : string  read Fvl_quarta_parcela write Setvl_quarta_parcela;
    property status              : integer read Fstatus write Setstatus;

end;

implementation

{ TParcelaModel }

procedure TParcelaModel.Setid_parcelas(const Value: integer);
begin
  Fid_parcelas:=Value;
end;

procedure TParcelaModel.Setid_tipo_pgto(const Value: integer);
begin
  Fid_tipo_pgto:=Value;
end;

procedure TParcelaModel.Setid_credor(const Value: integer);
begin
  Fid_credor:=Value;
end;

procedure TParcelaModel.Setid_cliente(const Value: integer);
begin
  Fid_cliente:=Value;
end;

procedure TParcelaModel.Setvalor_total(const Value: string);
begin
  Fvalor_total:=Value;
end;

procedure TParcelaModel.Setdt_primeira_parcela(const Value: string);
begin
  Fdt_primeira_parcela:=Value;
end;

procedure TParcelaModel.Setvl_primeira_parcela(const Value: string);
begin
  Fvl_primeira_parcela:=Value;
end;

procedure TParcelaModel.Setdt_segunda_parcela(const Value: string);
begin
  Fdt_segunda_parcela:=Value;
end;

procedure TParcelaModel.Setvl_segunda_parcela(const Value: string);
begin
  Fvl_segunda_parcela:=Value;
end;

procedure TParcelaModel.Setdt_terceira_parcela(const Value: string);
begin
  Fdt_terceira_parcela:=Value;
end;

procedure TParcelaModel.Setvl_terceira_parcela(const Value: string);
begin
  Fvl_terceira_parcela:=Value;
end;

procedure TParcelaModel.Setdt_quarta_parcela(const Value: string);
begin
  Fdt_quarta_parcela:=Value;
end;

procedure TParcelaModel.Setvl_quarta_parcela(const Value: string);
begin
  Fvl_quarta_parcela:=Value;
end;

procedure TParcelaModel.Setstatus(const Value: integer);
begin
  Fstatus := Value;
end;

end.
