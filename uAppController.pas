unit uAppController;

interface

uses
  Winapi.Windows, System.SysUtils, ShellAPI;

procedure App_LoadTweaks(AForm: TObject);
procedure App_OpenNetplwiz(AForm: TObject);

implementation

uses
  uAppStrings, uMain, uTweaksR,
  uMessageBox, uOSUtils;

procedure App_LoadTweaks(AForm: TObject);
var
  F: TfrmMain;
begin
  if not (AForm is TfrmMain) then Exit;
  F := TfrmMain(AForm);

  F.chkEAL.Checked := EnableAutoLoginR;
end;

procedure App_OpenNetplwiz(AForm: TObject);
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
