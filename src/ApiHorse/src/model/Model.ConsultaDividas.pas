unit Model.ConsultaDividas;

interface

uses
  FireDAC.Comp.Client, uConexao, System.SysUtils, System.JSON,
  Controllers.Conexao, System.Generics.Collections;

type TModelConsultaDividas = class
  private
    Fcpf                     : string;
    Fnomecliente             : string;
    Fcpf_cnpj                : string;
    Frazaosocialcredor       : string;
    Ftipopgto                : string;
    Fvalor_total             : string;
    Fdt_primeira_parcela     : string;
    Fqdiaspriparc            : integer;
    Fstatuspriparc           : string;
    Fvl_primeira_parcela     : string;
    Fdt_segunda_parcela      : string;
    Fqdiassegparc            : integer;
    Fstatussegparc           : string;
    Fvl_segunda_parcela      : string;
    Fdt_terceira_parcela     : string;
    Fqdiasterparc            : integer;
    Fstatusterparc           : string;
    Fvl_terceira_parcela     : string;
    Fdt_quarta_parcela       : string;
    Fqdiasquaparc            : integer;
    Fstatusquaparc           : string;
    Fvl_quarta_parcela       : string;

    procedure Setcpf(const Value: string);
    procedure Setnomecliente(const Value: string);
    procedure Setcpf_cnpj(const Value: string);
    procedure Setrazaosocialcredor(const Value: string);
    procedure Settipopgto(const Value: string);
    procedure Setvalor_total(const Value: string);
    procedure Setdt_primeira_parcela(const Value: string);
    procedure Setqdiaspriparc(const Value: integer);
    procedure Setstatuspriparc(const Value: string);
    procedure Setvl_primeira_parcela(const Value: string);
    procedure Setdt_segunda_parcela(const Value: string);
    procedure Setqdiassegparc(const Value: integer);
    procedure Setstatussegparc(const Value: string);
    procedure Setvl_segunda_parcela(const Value: string);
    procedure Setdt_terceira_parcela(const Value: string);
    procedure Setqdiasterparc(const Value: integer);
    procedure Setstatusterparc(const Value: string);
    procedure Setvl_terceira_parcela(const Value: string);
    procedure Setdt_quarta_parcela(const Value: string);
    procedure Setqdiasquaparc(const Value: integer);
    procedure Setstatusquaparc(const Value: string);
    procedure Setvl_quarta_parcela(const Value: string);

  public
    property cpf: string                 read Fcpf                 write Setcpf;
    property nomecliente: string         read Fnomecliente         write Setnomecliente;
    property cpf_cnpj: string            read Fcpf_cnpj            write Setcpf_cnpj;
    property razaosocialcredor: string   read Frazaosocialcredor   write Setrazaosocialcredor;
    property tipopgto: string            read Ftipopgto            write Settipopgto;
    property valor_total: string         read Fvalor_total         write Setvalor_total;
    property dt_primeira_parcela: string read Fdt_primeira_parcela write Setdt_primeira_parcela;
    property qdiaspriparc: integer       read Fqdiaspriparc        write Setqdiaspriparc;
    property statuspriparc: string       read Fstatuspriparc       write Setstatuspriparc;
    property vl_primeira_parcela: string read Fvl_primeira_parcela write Setvl_primeira_parcela;
    property dt_segunda_parcela: string  read Fdt_segunda_parcela  write Setdt_segunda_parcela;
    property qdiassegparc: integer       read Fqdiassegparc        write Setqdiassegparc;
    property statussegparc: string       read Fstatussegparc       write Setstatussegparc;
    property vl_segunda_parcela: string  read Fvl_segunda_parcela  write Setvl_segunda_parcela;
    property dt_terceira_parcela: string read Fdt_terceira_parcela write Setdt_terceira_parcela;
    property qdiasterparc: integer       read Fqdiasterparc        write Setqdiasterparc;
    property statusterparc: string       read Fstatusterparc       write Setstatusterparc;
    property vl_terceira_parcela: string read Fvl_terceira_parcela write Setvl_terceira_parcela;
    property dt_quarta_parcela: string   read Fdt_quarta_parcela   write Setdt_quarta_parcela;
    property qdiasquaparc: integer       read Fqdiasquaparc        write Setqdiasquaparc;
    property statusquaparc: string       read Fstatusquaparc       write Setstatusquaparc;
    property vl_quarta_parcela: string   read Fvl_quarta_parcela   write Setvl_quarta_parcela;

end;

implementation

{ TModelConsultaDividas }

procedure TModelConsultaDividas.Setcpf(const Value: string);
begin
 Fcpf := Value;
end;

procedure TModelConsultaDividas.Setcpf_cnpj(const Value: string);
begin
  Fcpf_cnpj := Value;
end;

procedure TModelConsultaDividas.Setdt_primeira_parcela(const Value: string);
begin
  Fdt_primeira_parcela := Value;
end;

procedure TModelConsultaDividas.Setdt_quarta_parcela(const Value: string);
begin
  Fdt_quarta_parcela := Value;
end;

procedure TModelConsultaDividas.Setdt_segunda_parcela(const Value: string);
begin
  Fdt_segunda_parcela := Value;
end;

procedure TModelConsultaDividas.Setdt_terceira_parcela(const Value: string);
begin
  Fdt_terceira_parcela := Value;
end;

procedure TModelConsultaDividas.Setnomecliente(const Value: string);
begin
  Fnomecliente := Value;
end;

procedure TModelConsultaDividas.Setqdiaspriparc(const Value: integer);
begin
  Fqdiaspriparc := Value;
end;

procedure TModelConsultaDividas.Setqdiasquaparc(const Value: integer);
begin
  Fqdiasquaparc := Value;
end;

procedure TModelConsultaDividas.Setqdiassegparc(const Value: integer);
begin
  Fqdiassegparc := Value;
end;

procedure TModelConsultaDividas.Setqdiasterparc(const Value: integer);
begin
  Fqdiasterparc := Value;
end;

procedure TModelConsultaDividas.Setrazaosocialcredor(const Value: string);
begin
  Frazaosocialcredor := Value;
end;

procedure TModelConsultaDividas.Setstatuspriparc(const Value: string);
begin
  Fstatuspriparc := Value;
end;

procedure TModelConsultaDividas.Setstatusquaparc(const Value: string);
begin
  Fstatusquaparc := Value;
end;

procedure TModelConsultaDividas.Setstatussegparc(const Value: string);
begin
  Fstatussegparc := Value;
end;

procedure TModelConsultaDividas.Setstatusterparc(const Value: string);
begin
  Fstatusterparc := Value;
end;

procedure TModelConsultaDividas.Settipopgto(const Value: string);
begin
  Ftipopgto := Value;
end;

procedure TModelConsultaDividas.Setvalor_total(const Value: string);
begin
  Fvalor_total := Value;
end;

procedure TModelConsultaDividas.Setvl_primeira_parcela(const Value: string);
begin
  Fvl_primeira_parcela := Value;
end;

procedure TModelConsultaDividas.Setvl_quarta_parcela(const Value: string);
begin
  Fvl_quarta_parcela := Value;
end;

procedure TModelConsultaDividas.Setvl_segunda_parcela(const Value: string);
begin
  Fvl_segunda_parcela := Value;
end;

procedure TModelConsultaDividas.Setvl_terceira_parcela(const Value: string);
begin
  Fvl_terceira_parcela := Value;
end;

end.
