unit uTL4Delphi.Constant;

interface

const
  GET_UPDATE     = 'https://api.telegram.org/bot<token>/getUpdates';
  SET_WEBHOOK    = 'https://api.telegram.org/bot<token>/setWebhook';
  INFO_WEBHOOK   = 'https://api.telegram.org/bot<token>/getWebhookInfo';
  DELETE_WEBHOOK = 'https://api.telegram.org/bot<token>/deleteWebhook';
  SEND_MESSAGE   = 'https://api.telegram.org/bot<token>/sendMessage';
  SEND_POLL      = 'https://api.telegram.org/bot<token>/sendPoll';
  SEND_PHOTO     = 'https://api.telegram.org/bot<token>/sendPhoto';
  SEND_DOCUMENT  = 'https://api.telegram.org/bot<token>/sendDocument';
  SEND_LOCATION  = 'https://api.telegram.org/bot<token>/sendLocation';

type
  TMetodoRecebimentoMensagem = (mrmPooling, mrmWebhook);
  TReplyMarkupType = (rmInline, rmKeyboard);
  TReturnType = (rtNull, rtNormal, rtCallback);

implementation

end.
