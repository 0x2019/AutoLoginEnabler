unit uMain.UI.Messages;

interface

uses
  Winapi.Windows, Winapi.Messages, Vcl.Forms;

procedure UI_ChangeMessageBoxPosition(AForm: TObject);

function UI_MessageBox(AForm: TObject; const Text: string; Flags: UINT; const Caption: string = ''): Integer;
function UI_ConfirmYesNo(AForm: TObject; const Text: string; const Caption: string = ''): Boolean;
function UI_ConfirmYesNoCancel(AForm: TObject; const Text: string; const Caption: string = ''): Integer;
function UI_ConfirmYesNoWarn(AForm: TObject; const Text: string; const Caption: string = ''): Boolean;

implementation

uses
  uMain;

var
  GCaption: string;
  xMsgCaption: PWideChar;

procedure UI_ChangeMessageBoxPosition(AForm: TObject);
var
  F: TfrmMain;
  mbHWND: HWND;
  mbRect: TRect;
  mbStyle: NativeInt;
  x, y, w, h: Integer;
begin
  if not (AForm is TfrmMain) then Exit;
  F := TfrmMain(AForm);

  mbHWND := FindWindow(MAKEINTRESOURCE(WC_DIALOG), xMsgCaption);
  if (mbHWND <> 0) then begin
    mbStyle := GetWindowLongPtr(mbHWND, GWL_STYLE);
    if (mbStyle and WS_SYSMENU) <> 0 then begin
      SetWindowLongPtr(mbHWND, GWL_STYLE, mbStyle and (not WS_SYSMENU));
      SetWindowPos(mbHWND, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER or SWP_NOACTIVATE);
    end;
    GetWindowRect(mbHWND, mbRect);
    with mbRect do begin
      w := Right - Left;
      h := Bottom - Top;
    end;
    x := F.Left + ((F.Width - w) div 2);
    if x < 0 then
      x := 0
    else if x + w > Screen.Width then x := Screen.Width - w;
    y := F.Top + ((F.Height - h) div 2);
    if y < 0 then y := 0
    else if y + h > Screen.Height then y := Screen.Height - h;
    SetWindowPos(mbHWND, 0, x, y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
  end;
end;

function UI_MessageBox(AForm: TObject; const Text: string; Flags: UINT; const Caption: string): Integer;
var
  F: TfrmMain;
begin
  Result := 0;
  if not (AForm is TfrmMain) then Exit;
  F := TfrmMain(AForm);

  PostMessage(F.Handle, mbMessage, 0, 0);

  GCaption := Caption;
  xMsgCaption := PWideChar(GCaption);

  Result := Application.MessageBox(PChar(Text), xMsgCaption, Flags);
end;

function UI_ConfirmYesNo(AForm: TObject; const Text: string; const Caption: string): Boolean;
begin
  Result := UI_MessageBox(AForm, Text, MB_ICONQUESTION or MB_YESNO or MB_DEFBUTTON2, Caption) = IDYES;
end;

function UI_ConfirmYesNoCancel(AForm: TObject; const Text: string; const Caption: string): Integer;
begin
  Result := UI_MessageBox(AForm, Text, MB_ICONQUESTION or MB_YESNOCANCEL or MB_DEFBUTTON1, Caption);
end;

function UI_ConfirmYesNoWarn(AForm: TObject; const Text: string; const Caption: string): Boolean;
begin
  Result := UI_MessageBox(AForm, Text, MB_ICONWARNING or MB_YESNO or MB_DEFBUTTON2, Caption) = IDYES;
end;

end.
