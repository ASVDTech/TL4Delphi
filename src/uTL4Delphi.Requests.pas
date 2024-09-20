unit uTL4Delphi.Requests;

interface

uses
  SysUtils,
  JSON,
  REST.Json,
  RESTRequest4D,
  uTL4Delphi.Constant,
  uTL4Delphi.Return.Clasess;

type
  TL4DelphiRequests = class
  strict private
    class function MontarURLToken(const pURL: string; const pTokenBot: string): string;
  public
    class function GetUpdate(const pTokenBot: string): TResponseMessagePooling;
    class procedure SetWebhook(const pTokenBot: string; const pURLWebhook: string);
    class function GetInfoWebhook(const pTokenBot: string): Boolean;
    class procedure DeleteWebhook(const pTokenBot: string);
    class procedure SendMessage(const pTokenBot: string; const pChatID: string; pMessage: string);
    class procedure ReadMessage(const pTokenBot: string; const pUpdateId: Integer);
  end;

implementation

{ TL4DelphiRequests }

class procedure TL4DelphiRequests.DeleteWebhook(const pTokenBot: string);
var
  lResponse: IResponse;
  lURLRequest: string;
begin
  lURLRequest := MontarURLToken(DELETE_WEBHOOK, pTokenBot);

  lResponse := TRequest.New.BaseURL(lURLRequest)
    .Accept('application/json')
    .Get;
end;

class function TL4DelphiRequests.GetInfoWebhook(const pTokenBot: string): Boolean;
var
  lResponse: IResponse;
  lURLRequest: string;
  lJSONResponse: TJSONObject;
  lJSONValueResult: TJSONValue;
begin
  Result := False;

  lURLRequest := MontarURLToken(INFO_WEBHOOK, pTokenBot);

  lResponse := TRequest.New.BaseURL(lURLRequest)
    .Accept('application/json')
    .Get;

  if lResponse.StatusCode = 200 then
  begin
    lJSONResponse := TJSONObject.ParseJSONValue(lResponse.Content) AS TJSONObject;
    try
      if Assigned(lJSONResponse) then
      begin
        if lJSONResponse.TryGetValue('result', lJSONValueResult) then
        begin
          Result := TJSONObject(lJSONValueResult).GetValue('url') <> nil;
        end;
      end;
    finally
      lJSONResponse.Free;
    end;
  end;
end;

class function TL4DelphiRequests.GetUpdate(const pTokenBot: string): TResponseMessagePooling;
var
  lResponse: IResponse;
  lURLRequest: string;
  lJSONResponse: TJSONObject;
begin
  Result := TResponseMessagePooling.Create;
  Result.ReturnType := rtNull;
  lURLRequest := MontarURLToken(GET_UPDATE, pTokenBot);

  lResponse := TRequest.New.BaseURL(lURLRequest)
    .AddParam('timeout', '100')
    .Accept('application/json')
    .Get;

  if lResponse.StatusCode = 200 then
  begin
    lJSONResponse := TJSONObject.ParseJSONValue(lResponse.Content) as TJSONObject;
    try
      if Pos('callback_query', lJSONResponse.ToString) = 0 then
      begin
        if (lJSONResponse.GetValue('result') as TJSONArray).Count > 0 then
        begin
          Result.ReturnType := rtNormal;
          Result.ReturnMessagePooling := TJson.JsonToObject<TRetMessagePooling>(lJSONResponse);
          Result := Result;
        end;
      end else
      begin
        if (lJSONResponse.GetValue('result') as TJSONArray).Count > 0 then
        begin
          Result.ReturnType := rtCallback;
          Result.ReturnMessagePooling := TJson.JsonToObject<TRetMessagePooling>(lJSONResponse);
          Result := Result;
        end;
      end;
    finally
      lJSONResponse.Free;
    end;
  end;
end;

class function TL4DelphiRequests.MontarURLToken(const pURL, pTokenBot: string): string;
begin
  Result := StringReplace(pURL, '<token>', pTokenBot, [rfReplaceAll]);
end;

class procedure TL4DelphiRequests.ReadMessage(const pTokenBot: string; const pUpdateId: Integer);
var
  lResponse: IResponse;
  lURLRequest: string;
begin
  var UpdateNew := pUpdateId + 1;
  lURLRequest := MontarURLToken(GET_UPDATE, pTokenBot);

  lResponse := TRequest.New.BaseURL(lURLRequest)
   .AddParam('offset', IntToStr(UpdateNew))
   .Accept('application/json')
   .Get;
end;

class procedure TL4DelphiRequests.SendMessage(const pTokenBot, pChatID: string; pMessage: string);
var
  lResponse: IResponse;
  lURLRequest: string;
begin
  lURLRequest := MontarURLToken(SEND_MESSAGE, pTokenBot);
  lResponse := TRequest.New.BaseURL(lURLRequest)
    .AddParam('chat_id', pChatID)
    .AddParam('text', pMessage)
    .AddParam('parse_mode','markdown')
    .Accept('application/json')
    .Get;
end;

class procedure TL4DelphiRequests.SetWebhook(const pTokenBot, pURLWebhook: string);
var
  lResponse: IResponse;
  lURLRequest: string;
begin
  lURLRequest := MontarURLToken(SET_WEBHOOK, pTokenBot);

  lResponse := TRequest.New.BaseURL(lURLRequest)
    .AddParam('url', pURLWebhook)
    .Accept('application/json')
    .Get;
end;

end.
