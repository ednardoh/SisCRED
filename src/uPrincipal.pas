unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ComCtrls, Vcl.ExtCtrls, UConecta, Vcl.Menus;

type
  TfrmPrincipal = class(TForm)
    stbPrincipal: TStatusBar;
    TTPrincipal: TTimer;
    MMEPrincipal: TMainMenu;
    Cadastros1: TMenuItem;
    Parametros1: TMenuItem;
    Sair1: TMenuItem;
    Clientes1: TMenuItem;
    ConfigurarBanco1: TMenuItem;
    ipodePagto1: TMenuItem;
    Credores1: TMenuItem;
    Parcelas1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure TTPrincipalTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ConfigurarBanco1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sair1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure ipodePagto1Click(Sender: TObject);
    procedure Credores1Click(Sender: TObject);
    procedure Parcelas1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    conexaoClass : TConexao;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses UConexaoBDpas, uDatamodulo, uCadCliente, uCadTipopgto, uCadCredor,
  uCadParcela;

procedure TfrmPrincipal.Clientes1Click(Sender: TObject);
begin
  frmCadCliente := TfrmCadCliente.create(Self);
  frmCadCliente.ShowModal;
end;

procedure TfrmPrincipal.ConfigurarBanco1Click(Sender: TObject);
begin
  frmConectaDB :=TfrmConectaDB.Create(Self);
  frmConectaDB.ShowModal;
end;

procedure TfrmPrincipal.Credores1Click(Sender: TObject);
begin
  frmCadCredor :=TfrmCadCredor.create(self);
  frmCadCredor.showmodal;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.messageBox('Deseja Realmente Sair do Sistema?',
    'Confirma��o',mb_YesNo+mb_IconInformation+mb_DefButton2) = IDYES then
    Action:=cafree
  else
    Action:=canone;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  conexaoClass := TConexao.Create(ExtractFilePath(Application.ExeName) + 'ConfigDB.ini', 'Conexao');
  if not conexaoClass.ConectouBanco then
    begin
      frmConectaDB :=TfrmConectaDB.Create(Self);
      frmConectaDB.ShowModal;
    end
  else
    begin
      conexaoClass.LeINI;
      conexaoClass.Conectar(frmDatamodulo.DBConect);
    end;
end;

procedure TfrmPrincipal.ipodePagto1Click(Sender: TObject);
begin
  frmCadTipopgto := TfrmCadTipopgto.create(Self);
  frmCadTipopgto.ShowModal;
end;

procedure TfrmPrincipal.Parcelas1Click(Sender: TObject);
begin
  frmCadParcela :=TfrmCadParcela.create(Self);
  frmCadParcela.ShowModal;
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.TTPrincipalTimer(Sender: TObject);
begin
  Application.ProcessMessages;
  stbPrincipal.Panels[0].Text := 'Data Hora : ' + FormatDateTime('DD/MM/YYYY HH:MM:SS', Now());
end;

end.
