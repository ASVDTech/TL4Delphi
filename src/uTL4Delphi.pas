unit uTL4Delphi;

interface

uses
  System.SysUtils,
  System.Classes,
  uTL4Delphi.Config,
  uTL4Delphi.Constant,
  uTL4Delphi.Return.Clasess,
  uTL4Delphi.Threads;

type
  TOnGetNewMessageResponse = procedure(const pRetornoMensagem: TResponseMessagePooling) of object;
  TOnGetError = procedure(const pError: string) of object;

  TTL4Delphi = class(TComponent)
  private
    { Private declarations }
    FTL4DelphiConfig: TTL4DelphiConfig;
    FOnGetError: TOnGetError;
    FOnGetNewMessageResponse: TOnGetNewMessageResponse;

    FThreadMensagem: TThreadReadMessage;
    procedure OnThreadReadMensageTerminate(Sender: TObject);
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure SendMessage(const pChatID: string; pMessage: string);
    procedure StartTelegram;
    procedure StopTelegram;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property Config: TTL4DelphiConfig read FTL4DelphiConfig write FTL4DelphiConfig;
    property OnGetError: TOnGetError read FOnGetError write FOnGetError;
    property OnGetNewMessageResponse: TOnGetNewMessageResponse read FOnGetNewMessageResponse write FOnGetNewMessageResponse;
  end;

procedure Register;

implementation

uses
  uTL4Delphi.Requests;

procedure Register;
begin
  RegisterComponents('ASVD Technology', [TTL4Delphi]);
end;

{ TTL4Delphi }

constructor TTL4Delphi.Create(AOwner: TComponent);
begin
  inherited;
  FTL4DelphiConfig := TTL4DelphiConfig.Create;
  FTL4DelphiConfig.TempoCiclo := 2000;
end;

destructor TTL4Delphi.Destroy;
begin
  FTL4DelphiConfig.Free;
  inherited;
end;

procedure TTL4Delphi.OnThreadReadMensageTerminate(Sender: TObject);
begin
  if Sender is TThread then
    if Assigned(TThread(Sender).FatalException) then
    begin
      FOnGetError(Exception(TThread(Sender).FatalException).Message);
      Exit;
    end;
end;

procedure TTL4Delphi.SendMessage(const pChatID: string; pMessage: string);
begin
  try
    TL4DelphiRequests.SendMessage(FTL4DelphiConfig.TokenBot, pChatID, pMessage);
  except
    on E: Exception do
      FOnGetError(E.Message);
  end;
end;

procedure TTL4Delphi.StartTelegram;
begin
  if FTL4DelphiConfig.TokenBot = string.Empty then
  begin
    FOnGetError('Preencha o token antes de iniciar o telegram!');
    Exit;
  end;

  FThreadMensagem := TThreadReadMessage.Create(
    procedure
    var
      lReturnMessage: TResponseMessagePooling;
      lI: Integer;
    begin
      if FThreadMensagem.CheckTerminated then
        Exit;

      lReturnMessage := TL4DelphiRequests.GetUpdate(FTL4DelphiConfig.TokenBot);

      if Length(lReturnMessage.ReturnMessagePooling.Result) > 0 then
      begin
        if Assigned(FOnGetNewMessageResponse) then
          FOnGetNewMessageResponse(lReturnMessage);

        for lI := Low(lReturnMessage.ReturnMessagePooling.Result) to High(lReturnMessage.ReturnMessagePooling.Result) do
        begin
          TL4DelphiRequests.ReadMessage(FTL4DelphiConfig.TokenBot, lReturnMessage.ReturnMessagePooling.Result[lI].UpdateId);
        end;
      end;
    end, FTL4DelphiConfig.TempoCiclo);
  FThreadMensagem.OnTerminate := OnThreadReadMensageTerminate;
  FThreadMensagem.Start;
end;

procedure TTL4Delphi.StopTelegram;
begin
  if not Assigned(FThreadMensagem) then
    Exit;

  FThreadMensagem.Terminate;
  FThreadMensagem.WaitFor;
  FreeAndNil(FThreadMensagem);
end;

end.
