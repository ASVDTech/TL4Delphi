unit TL4Delphi.Principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  uTL4Delphi,
  uTL4Delphi.Return.Clasess;

type
  TFPrincipal = class(TForm)
    mmLog: TMemo;
    Button1: TButton;
    Button2: TButton;
    edtChatID: TEdit;
    edtMensagem: TEdit;
    Button3: TButton;
    TL4Delphi: TTL4Delphi;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TL4DelphiGetError(const pError: string);
    procedure TL4DelphiGetNewMessageResponse(const pRetornoMensagem: TResponseMessagePooling);
    procedure FormDestroy(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

procedure TFPrincipal.Button1Click(Sender: TObject);
begin
  TL4Delphi.StartTelegram;
end;

procedure TFPrincipal.Button2Click(Sender: TObject);
begin
  TL4Delphi.StopTelegram;
end;

procedure TFPrincipal.Button3Click(Sender: TObject);
begin
  TL4Delphi.SendMessage(edtChatID.Text, edtMensagem.Text);
end;

procedure TFPrincipal.FormDestroy(Sender: TObject);
begin
  TL4Delphi.StopTelegram;
end;

procedure TFPrincipal.TL4DelphiGetError(const pError: string);
begin
  raise Exception.Create(pError);
end;

procedure TFPrincipal.TL4DelphiGetNewMessageResponse(const pRetornoMensagem: TResponseMessagePooling);
var
  lI: Integer;
begin
  for lI := 0 to High(pRetornoMensagem.ReturnMessagePooling.Result) do
  begin
    mmLog.Lines.Add('ChatID: ' + pRetornoMensagem.ReturnMessagePooling.Result[lI].Message.Chat.Id.ToString +
      sLineBreak + 'Mensagem: ' + pRetornoMensagem.ReturnMessagePooling.Result[lI].Message.Text);
  end;
end;

end.
