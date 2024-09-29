unit uCadTipopgto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadFormBase, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.JSON, REST.Json;

type
  TfrmCadTipopgto = class(TfrmCadFormBase)
    TBTipopgto: TFDMemTable;
    TBTipopgtoid: TIntegerField;
    ds_Tipopgto: TDataSource;
    TBTipopgtoTipopgto: TStringField;
    pn_Grid: TPanel;
    DBG_Cadtipopgto: TDBGrid;
    EDT_Id: TEdit;
    Label12: TLabel;
    cbo_Tipopgto: TComboBox;
    Label1: TLabel;
    RESTResponse1: TRESTResponse;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    procedure EDT_IdEnter(Sender: TObject);
    procedure EDT_IdExit(Sender: TObject);
    procedure cbo_TipopgtoEnter(Sender: TObject);
    procedure cbo_TipopgtoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BTN_InserirClick(Sender: TObject);
    procedure BTN_EditarClick(Sender: TObject);
    procedure BTN_CancelarClick(Sender: TObject);
    procedure DBG_CadtipopgtoCellClick(Column: TColumn);
    procedure DBG_CadtipopgtoDblClick(Sender: TObject);
    procedure BTN_GravarClick(Sender: TObject);
    procedure BTN_ExcluirClick(Sender: TObject);
  private
    { Private declarations }
    strStatusCli: string;
    strApiDataSet: string;
    IntID: Integer;
    procedure Limpacampos;
    procedure GravaTipopgto;
    procedure BuscaTipopagto(strURL, strAText: string); //busca Clientes
    procedure PreencheDataSetTipopgto(strJSONValue: string);
    procedure PreencheCampos;
    procedure ExcluiDados;
  public
    { Public declarations }
  end;

var
  frmCadTipopgto: TfrmCadTipopgto;

implementation

{$R *.dfm}

procedure TfrmCadTipopgto.BTN_CancelarClick(Sender: TObject);
begin
  inherited;
  EDT_Id.SetFocus;
end;

procedure TfrmCadTipopgto.BTN_EditarClick(Sender: TObject);
begin
  inherited;
  strStatusCli:='dsEditando';
  cbo_Tipopgto.SetFocus;
end;

procedure TfrmCadTipopgto.BTN_ExcluirClick(Sender: TObject);
begin
  strStatusCli:='dsExcluindo';
  ExcluiDados;
  inherited;
  BuscaTipopagto('http://localhost:9000/tipopgtoall','');
end;

procedure TfrmCadTipopgto.BTN_GravarClick(Sender: TObject);
begin
  GravaTipopgto;
  inherited;
  BuscaTipopagto('http://localhost:9000/tipopgtoall','');
end;

procedure TfrmCadTipopgto.BTN_InserirClick(Sender: TObject);
begin
  inherited;
  strStatusCli :='dsInserindo';
  Limpacampos;
  cbo_Tipopgto.SetFocus;
end;

procedure TfrmCadTipopgto.BuscaTipopagto(strURL, strAText: string);
var
  I: Integer;
  strJSON: string;
begin
  try
    strApiDataSet := 'stAPI';
    TBTipopgto.Close;
    TBTipopgto.Open;
    TBTipopgto.EmptyDataSet;
    TBTipopgto.IndexFieldNames := 'id';   //s� para order por id
    DBG_Cadtipopgto.DataSource := Nil;
    DBG_Cadtipopgto.DataSource := ds_Tipopgto;
    TBTipopgto.Close;
    TBTipopgto.Open;

    RESTClient1.BaseURL := strURL + strAText;
    RESTRequest1.Method := rmGET;
    RESTRequest1.Execute;

    if RESTResponse1.StatusCode in [200,201,204] then
      begin
        PreencheDataSetTipopgto(RESTResponse1.Content);  //processa o JSon
      end;

  finally
    RESTClient1.BaseURL   :='';
    RESTRequest1.Resource :='';
    RESTRequest1.Method   := rmGET;
    RESTRequest1.AddBody('');
  end;
end;

procedure TfrmCadTipopgto.cbo_TipopgtoEnter(Sender: TObject);
begin
  inherited;
  TComboBox(Sender).Color := clYellow;
end;

procedure TfrmCadTipopgto.cbo_TipopgtoExit(Sender: TObject);
begin
  inherited;
  TComboBox(Sender).Color := clWindow;
end;

procedure TfrmCadTipopgto.DBG_CadtipopgtoCellClick(Column: TColumn);
begin
  inherited;
  PreencheCampos;
end;

procedure TfrmCadTipopgto.DBG_CadtipopgtoDblClick(Sender: TObject);
begin
  inherited;
  PreencheCampos;
end;

procedure TfrmCadTipopgto.EDT_IdEnter(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Color := clYellow;
end;

procedure TfrmCadTipopgto.EDT_IdExit(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Color := clWindow;
end;

procedure TfrmCadTipopgto.ExcluiDados;
begin
  if strStatusCli ='dsExcluindo' then
    begin
      if Application.messageBox('Deseja Realmente Apagar Esse Tipo de Pagamento?',
        'Confirma��o',mb_YesNo+mb_IconInformation+mb_DefButton2) = IDYES then
        begin
          try
            RESTClient1.BaseURL := 'http://localhost:9000/tipopgtodelete/' + IntToStr(IntID);
            RESTRequest1.Method := rmDELETE;
            RESTRequest1.Execute;
          finally
            RESTClient1.BaseURL   :='';
            RESTRequest1.Resource :='';
            RESTRequest1.Method   := rmGET;
            RESTRequest1.AddBody('');
          end;
        end;
    end;
end;

procedure TfrmCadTipopgto.FormShow(Sender: TObject);
begin
  inherited;
  TBTipopgto.Close;
  TBTipopgto.Open;
  BuscaTipopagto('http://localhost:9000/tipopgtoall','');
end;

procedure TfrmCadTipopgto.GravaTipopgto;
var
  oJson: TJSONObject;
begin
  if strStatusCli ='dsInserindo' then
    begin
      try
        RESTClient1.BaseURL       := 'http://localhost:9000/';
        RESTRequest1.Resource     := 'tipopgtoinsert';
        RESTRequest1.Method       := rmPOST;
        oJson := TJSONObject.Create;
        oJson.AddPair('tipopgto' , cbo_Tipopgto.Text);
        RESTRequest1.AddBody(oJson);
        RESTRequest1.Execute;
      finally
        oJson.Free;
        RESTClient1.BaseURL   :='';
        RESTRequest1.Resource :='';
        RESTRequest1.Method   := rmGET;
        RESTRequest1.AddBody('');
      end;
    end
  else
    if strStatusCli ='dsEditando' then
      begin
        try
          RESTClient1.BaseURL       := 'http://localhost:9000/';
          RESTRequest1.Resource     :='tipopgtoupdate';
          RESTRequest1.Method       := rmPUT;
          oJson := TJSONObject.Create;
          oJson.AddPair('id'         , TJSONNumber.Create(IntID));
          oJson.AddPair('tipopgto'   , cbo_Tipopgto.Text);
          RESTRequest1.AddBody(oJson);
          RESTRequest1.Execute;
        finally
          oJson.Free;
          RESTClient1.BaseURL   :='';
          RESTRequest1.Resource :='';
          RESTRequest1.Method   := rmGET;
          RESTRequest1.AddBody('');
        end;
      end;
  strStatusCli :='';
end;

procedure TfrmCadTipopgto.Limpacampos;
begin
  EDT_Id.Clear;
  cbo_Tipopgto.Text :='';
end;

procedure TfrmCadTipopgto.PreencheCampos;
begin
  if strApiDataSet = 'stAPI' then  //consulta vem direto do banco
    begin  //consulta vem do consumo da API Horse
      IntID                := TBTipopgto.FieldByName('id').AsInteger;
      EDT_Id.Text          := TBTipopgto.FieldByName('id').AsString;
      cbo_Tipopgto.Text    := TBTipopgto.FieldByName('tipopgto').AsString;
    end;
end;

procedure TfrmCadTipopgto.PreencheDataSetTipopgto(strJSONValue: string);
var
  JsonObjArray: TJSONArray;
  JsonObjectJson: TJSONObject;
  strTOJSon: string;
  I: Integer;
begin
  //Processa o JSon para DataSet - Horse
  Application.ProcessMessages;

  JsonObjArray := TJSONObject.ParseJSONValue( strJSONValue ) as TJSONArray;

  for I := 0 to JsonObjArray.Count-1 do
    begin
      strTOJSon := JsonObjArray.Items[I].ToJSON;
      JsonObjectJson := TJSONObject.ParseJSONValue( strTOJSon ) as TJSONObject;

      TBTipopgto.Insert;
      TBTipopgtoid.AsString          := JsonObjectJson.GetValue('id').Value;
      TBTipopgtoTipopgto.AsString    := JsonObjectJson.GetValue('tipopgto').Value;
      TBTipopgto.Post;
    end;
end;

end.
