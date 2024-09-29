unit uDatamodulo;

interface

uses
  System.SysUtils, System.Classes, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, Vcl.Forms;

type
  TfrmDatamodulo = class(TDataModule)
    DBConect: TZConnection;
    QryAux: TZQuery;
    dsPesquisa: TDataSource;
    dsClientes: TDataSource;
    dsContatos: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    gblValCodigo,
    gblValNome  : string;
    function CharEspeciais(Texto:String):String;
  end;

var
  frmDatamodulo: TfrmDatamodulo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TfrmDatamodulo.CharEspeciais(Texto: String): String;
var
  i,t:integer;
begin
  t:=length(texto);
  i:=1;
  While i <= t do
    begin
     if texto[i] in ['0'..'9','a'..'z','A'..'Z',#32] Then
       result:=result+Texto[i];
     i:=i+1;
    end;
end;

procedure TfrmDatamodulo.DataModuleCreate(Sender: TObject);
begin
  DBConect.LibraryLocation := ExtractFilePath(Application.ExeName)+'ntwdblib.dll';
end;

end.
