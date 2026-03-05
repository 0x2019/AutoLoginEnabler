unit uAppController;

interface

uses
  Winapi.Windows, System.SysUtils, ShellAPI, uMain;

procedure AppController_LoadTweaks(AForm: TfrmMain);
procedure AppController_OpenNetplwiz(AForm: TfrmMain);

procedure AppController_About(AForm: TfrmMain);
procedure AppController_Exit(AForm: TfrmMain);
procedure AppController_ToggleAutoLogin(AForm: TfrmMain);

implementation

uses
  uMessageBox, uOSUtils,
  uAppStrings, uTweaksR, uTweaksW;

procedure AppController_LoadTweaks(AForm: TfrmMain);
begin
  if AForm = nil then Exit;
  AForm.chkEAL.Checked := EnableAutoLoginR;
end;

procedure AppController_OpenNetplwiz(AForm: TfrmMain);
begin
  if AForm = nil then Exit;

  DisableWow64FsRedirection(
    procedure
    var
      R: NativeInt;
    begin
      R := NativeInt(ShellExecute(AForm.Handle, 'open', 'Netplwiz.exe', nil, nil, SW_SHOWNORMAL));

      if R <= 32 then
        UI_MessageBox(AForm, Format(SOpenNetplwizFailMsg, [R]), MB_ICONWARNING or MB_OK);
    end
  );
end;

procedure AppController_About(AForm: TfrmMain);
begin
  if AForm = nil then Exit;
  UI_MessageBox(AForm, Format(SAboutMsg, [APP_NAME, APP_VERSION, APP_RELEASE, APP_URL]), MB_ICONQUESTION or MB_OK);
end;

procedure AppController_Exit(AForm: TfrmMain);
begin
  if AForm = nil then Exit;
  AForm.Close;
end;

procedure AppController_ToggleAutoLogin(AForm: TfrmMain);
begin
  if AForm = nil then Exit;
  EnableAutoLoginW(AForm.chkEAL.Checked);
end;

end.
