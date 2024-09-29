unit Model.Credor;

interface

uses
  FireDAC.Comp.Client, uConexao, System.SysUtils, System.JSON,
  Controllers.Conexao, System.Generics.Collections;

type TModelCredor = class
  private
    Fid         : integer;
    Fcpfcnpj    : string;
    Fnome       : string;
    Fcep        : string;
    Flogradouro : string;
    Fnumero     : string;
    Fcomplemento: string;
    Fbairro     : string;
    Fcidade     : string;
    Fibge_cidade: string;
    Fsigla_uf   : string;

    procedure Setid(const Value: integer);
    procedure Setcpfcnpj(const Value: string);
    procedure Setnome(const Value: string);
    procedure Setcep(const Value: string);
    procedure Setlogradouro(const Value: string);
    procedure Setnumero(const Value: string);
    procedure Setcomplemento(const Value: string);
    procedure Setbairro(const Value: string);
    procedure Setcidade(const Value: string);
    procedure Setibge_cidade(const Value: string);
    procedure Setsigla_uf(const Value: string);
  public
    property id:          integer read Fid          write Setid;
    property cpfcnpj:     string  read Fcpfcnpj     write Setcpfcnpj;
    property nome:        string  read Fnome        write Setnome;
    property cep:         string  read Fcep         write Setcep;
    property logradouro:  string  read Flogradouro  write Setlogradouro;
    property numero:      string  read Fnumero      write Setnumero;
    property complemento: string  read Fcomplemento write Setcomplemento;
    property bairro:      string  read Fbairro      write Setbairro;
    property cidade:      string  read Fcidade      write Setcidade;
    property ibge_cidade: string  read Fibge_cidade write Setibge_cidade;
    property sigla_uf:    string  read Fsigla_uf    write Setsigla_uf;

end;

implementation

{ TModelCredor }

procedure TModelCredor.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TModelCredor.Setcpfcnpj(const Value: string);
begin
  Fcpfcnpj := Value;
end;

procedure TModelCredor.Setnome(const Value: string);
begin
  Fnome := Value;
end;

procedure TModelCredor.Setcep(const Value: string);
begin
  Fcep := Value;
end;

procedure TModelCredor.Setlogradouro(const Value: string);
begin
  Flogradouro := Value;
end;

procedure TModelCredor.Setnumero(const Value: string);
begin
  Fnumero := Value;
end;

procedure TModelCredor.Setcomplemento(const Value: string);
begin
  Fcomplemento := Value;
end;

procedure TModelCredor.Setbairro(const Value: string);
begin
  Fbairro := Value;
end;

procedure TModelCredor.Setcidade(const Value: string);
begin
  Fcidade := Value;
end;

procedure TModelCredor.Setibge_cidade(const Value: string);
begin
  Fibge_cidade := Value;
end;

procedure TModelCredor.Setsigla_uf(const Value: string);
begin
  Fsigla_uf := Value;
end;

end.
