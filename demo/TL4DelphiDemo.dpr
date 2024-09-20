program TL4DelphiDemo;

uses
  Vcl.Forms,
  TL4Delphi.Principal in 'TL4Delphi.Principal.pas' {FPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.
