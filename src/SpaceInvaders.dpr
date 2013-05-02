program SpaceInvaders;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  uFMOD in 'uFMOD.pas',
  xmfile in 'xmfile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
