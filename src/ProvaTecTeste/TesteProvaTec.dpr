program TesteProvaTec;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  uTestCliente in 'uTestCliente.pas',
  uTestContato in 'uTestContato.pas',
  uTestTipopgto in 'uTestTipopgto.pas',
  uTestCredores in 'uTestCredores.pas',
  uTestParcelas in 'uTestParcelas.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.
