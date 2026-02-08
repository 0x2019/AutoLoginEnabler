program AutoLoginEnabler;

uses
  Winapi.Windows,
  Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uMain.UI in 'uMain.UI.pas',
  uMain.UI.TweaksR in 'uMain.UI.TweaksR.pas',
  uMain.UI.TweaksW in 'uMain.UI.TweaksW.pas',
  uExt in 'uExt.pas',
  uMain.UI.Messages in 'uMain.UI.Messages.pas',
  uMain.UI.Strings in 'uMain.UI.Strings.pas';

var
  uMutex: THandle;

{$O+} {$SetPEFlags IMAGE_FILE_RELOCS_STRIPPED}
{$R *.res}

begin
  if not IsWindowsVersionOrGreater(10, 0, 19042) then
  begin
    MessageBox(0, PChar(SWin10_20H2_RequiredMsg), PChar(SWin10_20H2_RequiredTitle), MB_ICONERROR or MB_OK);
    Halt(1);
  end;

  uMutex := CreateMutex(nil, True, 'ALE!');
  if (uMutex <> 0 ) and (GetLastError = 0) then begin

    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TfrmMain, frmMain);
    Application.Run;

  if uMutex <> 0 then
    CloseHandle(uMutex);
  end;
end.
