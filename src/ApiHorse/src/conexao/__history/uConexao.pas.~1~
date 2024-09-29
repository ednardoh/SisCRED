unit uConexao;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait, vcl.forms, UConecta;

type
  TConexao = class
  private
    FConn: TFDConnection;
    Connect: TConexaoDB;

    procedure ConfigurarConexao;
  public
    constructor Create;
    destructor Destroy; override;

    function GetConn: TFDConnection;
    function CriarQuery: TFDQuery;
  end;

implementation

{ TConexao }

procedure TConexao.ConfigurarConexao;
begin
  try
    Connect := TConexaoDB.Create(ExtractFilePath(Application.ExeName) + 'ConfigDB.ini', 'Conexao');
    Connect.LeINI;
    FConn.Params.DriverID := Connect.Driver;
    FConn.Params.Database := Connect.Database;
    FConn.Params.UserName := Connect.Usuario;
    FConn.Params.Password := Connect.Senha;
    FConn.Connected := True;
  finally
    Connect.Free;
  end;
end;

constructor TConexao.Create;
begin
  FConn := TFDConnection.Create(nil);
  Self.ConfigurarConexao();
end;

function TConexao.CriarQuery: TFDQuery;
var
  VQuery: TFDQuery;
begin
  VQuery := TFDQuery.Create(nil);
  VQuery.Connection := FConn;
  VQuery.CachedUpdates := False;
  Result := VQuery;
end;

destructor TConexao.Destroy;
begin
  FConn.Free;
  inherited;
end;

function TConexao.GetConn: TFDConnection;
begin
  Result := FConn;
end;

end.
