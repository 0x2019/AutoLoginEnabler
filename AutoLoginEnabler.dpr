program AutoLoginEnabler;

uses
  Winapi.Windows, Vcl.Forms,
  uMain in 'uMain.pas' {frmMain},
  uMain.UI in 'uMain.UI.pas',
  uMain.UI.TweaksR in 'uMain.UI.TweaksR.pas',
  uMain.UI.TweaksW in 'uMain.UI.TweaksW.pas',
  uExt in 'uExt.pas';

var
  uMutex: THandle;

{$O+} {$SetPEFlags IMAGE_FILE_RELOCS_STRIPPED}
{$R *.res}

begin
  if not IsWindows10_20H2_Or_Later then
  begin
    MessageBox(0, 'This program requires Windows 10 20H2 or later.' + sLineBreak +
                  'Please upgrade your operating system.', 'Error', MB_ICONERROR or MB_OK);
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
