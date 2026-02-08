unit uMain.UI;

interface

uses
  Winapi.Windows, System.SysUtils, ShellAPI;

procedure UI_Init(AForm: TObject);
procedure UI_About(AForm: TObject);
procedure UI_Exit(AForm: TObject);

procedure UI_LoadTweaks(AForm: TObject);
procedure UI_OpenNetplwiz(AForm: TObject);

implementation

uses
  uExt, uMain, uMain.UI.Messages, uMain.UI.Strings, uMain.UI.TweaksR;

procedure UI_Init(AForm: TObject);
var
  F: TfrmMain;
begin
  if not (AForm is TfrmMain) then Exit;
  F := TfrmMain(AForm);

  F.Constraints.MinWidth := F.Width;
  F.Constraints.MinHeight := F.Height;

  F.pnlALE.OnMouseDown := F.DragForm;
  SetWindowPos(F.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
end;

procedure UI_About(AForm: TObject);
var
  F: TfrmMain;
begin
  if not (AForm is TfrmMain) then Exit;
  F := TfrmMain(AForm);

  UI_MessageBox(F, Format(SAboutMsg, [APP_NAME, APP_VERSION, APP_RELEASE, APP_URL]), MB_ICONQUESTION or MB_OK);
end;

procedure UI_Exit(AForm: TObject);
var
  F: TfrmMain;
begin
  if not (AForm is TfrmMain) then Exit;
  F := TfrmMain(AForm);

  F.Close;
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
begin
  if not (AForm is TfrmMain) then Exit;
  F := TfrmMain(AForm);

  DisableWow64FsRedirection(
    procedure
    var
      R: HINST;
    begin
      R := ShellExecute(F.Handle, 'open', 'Netplwiz.exe', nil, nil, SW_SHOWNORMAL);

      if NativeInt(R) <= 32 then
        UI_MessageBox(F, Format(SOpenNetplwizFailMsg, [NativeInt(R)]), MB_ICONWARNING or MB_OK);
    end
  );
end;

end.
