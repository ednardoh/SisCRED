unit Model.Tipopgto;

interface

uses
  FireDAC.Comp.Client, uConexao, System.SysUtils, System.JSON,
  Controllers.Conexao, System.Generics.Collections;

type TModelTipopgto = class
  private
    Fid       : integer;
    Ftipopgto : string;

    procedure Setid(const Value: integer);
    procedure Settipopgto(const Value: string);

  public
    property id       : integer read Fid       write Setid;
    property tipopgto : string  read Ftipopgto write Settipopgto;

end;

implementation

{ TModelTipopgto }

procedure TModelTipopgto.Setid(const Value: integer);
begin
  Fid := Value;
end;

procedure TModelTipopgto.Settipopgto(const Value: string);
begin
  Ftipopgto := Value;
end;

end.
