unit uTL4Delphi.Threads;

interface

uses
  Classes,
  SysUtils,
  SyncObjs;

type
  TThreadReadMessage = class(TThread)
  strict private
    FThreadProc: TProc;
    FTemporizador: TEvent;
    FTempoCiclo: Integer;
  protected
    procedure Execute; override;
    procedure TerminatedSet; override;
  public
    constructor Create(pThreadProc: TProc; const pTempoCiclo: Integer = 2000);
    destructor Destroy; override;
  end;

implementation

{ TThreadReadMessage }

constructor TThreadReadMessage.Create(pThreadProc: TProc; const pTempoCiclo: Integer);
begin
  inherited Create(True);

  FreeOnTerminate := False;
  Priority := tpLower;
  FThreadProc := pThreadProc;
  FTempoCiclo := pTempoCiclo;

  FTemporizador := TEvent.Create;
end;

destructor TThreadReadMessage.Destroy;
begin
  FTemporizador.Free;
  inherited;
end;

procedure TThreadReadMessage.Execute;
begin
  inherited;
  while not Terminated do
  begin
    FThreadProc;
    if not Terminated then
    begin
      FTemporizador.WaitFor(FTempoCiclo);
      FTemporizador.ResetEvent;
    end;
  end;
end;

procedure TThreadReadMessage.TerminatedSet;
begin
  inherited;

  FTemporizador.SetEvent;
end;

end.
