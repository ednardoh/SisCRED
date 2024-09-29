unit Model.Contato;

interface

uses
  FireDAC.Comp.Client, uConexao, System.SysUtils, System.JSON,
  Controllers.Conexao, System.Generics.Collections;

type TModelContato = class
  private
    Fid_contato : integer;
    Fnome       : string;
    Fdata_nasc  : string;
    Fidade      : integer;
    Ftelefone   : string;
    Fid_cliente : integer;

    procedure Setid_contato(const Value: integer);
    procedure Setnome(const Value: string);
    procedure Setdata_nasc(const Value: string);
    procedure Setidade(const Value: integer);
    procedure Settelefone(const Value: string);
    procedure Setid_cliente(const Value: integer);
  public
    property id_contato : integer read Fid_contato write Setid_contato;
    property nome       : string  read Fnome       write Setnome;
    property data_nasc  : string  read Fdata_nasc  write Setdata_nasc;
    property idade      : integer read Fidade      write Setidade;
    property telefone   : string  read Ftelefone   write Settelefone;
    property id_cliente : integer read Fid_cliente write Setid_cliente;

end;

implementation

{ TModelContato }

procedure TModelContato.Setid_contato(const Value: integer);
begin
  Fid_contato := Value;
end;

procedure TModelContato.Setnome(const Value: string);
begin
  Fnome := Value;
end;

procedure TModelContato.Setdata_nasc(const Value: string);
begin
  Fdata_nasc := Value;
end;

procedure TModelContato.Setidade(const Value: integer);
begin
  Fidade := Value;
end;

procedure TModelContato.Settelefone(const Value: string);
begin
  Ftelefone := Value;
end;

procedure TModelContato.Setid_cliente(const Value: integer);
begin
  Fid_cliente := Value;
end;

end.
