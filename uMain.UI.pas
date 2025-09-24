unit uMain.UI;

interface

uses
  Winapi.Windows, System.SysUtils, Vcl.Forms, ShellAPI;

procedure UI_Init(AForm: TObject);

procedure UI_LoadTweaks(AForm: TObject);
procedure UI_OpenNetplwiz(AForm: TObject);

implementation

uses
  uExt, uMain, uMain.UI.TweaksR;

procedure UI_Init(AForm: TObject);
var
  F: TfrmMain;
begin
  if not (AForm is TfrmMain) then Exit;
  F := TfrmMain(AForm);

  F.pnlALE.OnMouseDown := F.DragForm;
  SetWindowPos(F.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
end;

procedure UI_LoadTweaks(AForm: TObject);
var
  F: TfrmMain;
begin
  if not (AForm is TfrmMain) then Exit;
  F := TfrmMain(AForm);

  F.chkEAL.Checked := EnableAutoLoginR;
end;

procedure UI_OpenNetplwiz(AForm: TObject);
var
  F: TfrmMain;
  OldFsRedirState: Pointer;
  FsRedirDisabled: BOOL;
begin
  if not (AForm is TfrmMain) then Exit;
  F := TfrmMain(AForm);

  FsRedirDisabled := Wow64DisableWow64FsRedirection(OldFsRedirState);
  try
    ShellExecute(F.Handle, nil, 'Netplwiz.exe', nil, nil, SW_SHOWNORMAL);
  finally
    if FsRedirDisabled then
      Wow64RevertWow64FsRedirection(OldFsRedirState);
  end;
end;

end.
