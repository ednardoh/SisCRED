program ChatBotVATD;

uses
  Vcl.Forms,
  Windows,
  uTInject.ConfigCEF,
  u_principal in 'u_principal.pas' {frmPrincipal};

{$R *.res}


begin

  If not GlobalCEFApp.StartMainProcess then
     Exit;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;

end.
