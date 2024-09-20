unit uTL4Delphi.Config;

interface

uses
  System.Classes;

type
  TTL4DelphiWebhook = class
  strict private
    FHost: string;
    FPort: Integer;
  strict protected
    function GetHost: string;
    procedure SetHost(const pValor: string);
    function GetPort: Integer;
    procedure SetPort(const pValor: Integer);
  published
    property Host: string read GetHost write SetHost;
    property Port: Integer read GetPort write SetPort;
  end;

  TTL4DelphiConfig = class(TPersistent)
  strict private
    FTokenBot: string;
    FTempoCiclo: Integer;
    FWebhook: TTL4DelphiWebhook;
  strict protected
    function GetTokenBot: string;
    procedure SetTokenBot(const pValor: string);
    function GetTempoCiclo: Integer;
    procedure SetTempoCiclo(const pValor: Integer);
    function GetWebhook: TTL4DelphiWebhook;
    procedure SetWebhook(const pValor: TTL4DelphiWebhook);
  public
    constructor Create;
  published
    property TokenBot: string read GetTokenBot write SetTokenBot;
    property TempoCiclo: Integer read GetTempoCiclo write SetTempoCiclo;
  end;

implementation

{ TTL4DelphiConfig }

constructor TTL4DelphiConfig.Create;
begin
  inherited Create;
  FWebhook := TTL4DelphiWebhook.Create;
end;

function TTL4DelphiConfig.GetTempoCiclo: Integer;
begin
  Result := FTempoCiclo;
end;

function TTL4DelphiConfig.GetTokenBot: string;
begin
  Result := FTokenBot;
end;

function TTL4DelphiConfig.GetWebhook: TTL4DelphiWebhook;
begin
  Result := FWebhook;
end;

procedure TTL4DelphiConfig.SetTempoCiclo(const pValor: Integer);
begin
  FTempoCiclo := pValor;
end;

procedure TTL4DelphiConfig.SetTokenBot(const pValor: string);
begin
  FTokenBot := pValor;
end;

procedure TTL4DelphiConfig.SetWebhook(const pValor: TTL4DelphiWebhook);
begin
  FWebhook := pValor;
end;

{ TTL4DelphiWebhook }

function TTL4DelphiWebhook.GetHost: string;
begin
  Result := FHost;
end;

function TTL4DelphiWebhook.GetPort: Integer;
begin
  Result := FPort;
end;

procedure TTL4DelphiWebhook.SetHost(const pValor: string);
begin
  FHost := pValor;
end;

procedure TTL4DelphiWebhook.SetPort(const pValor: Integer);
begin
  FPort := pValor;
end;

end.
