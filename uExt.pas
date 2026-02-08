unit uExt;

interface

uses
  Winapi.Windows, System.SysUtils;

function RtlGetVersion(var RTL_OSVERSIONINFOEXW): LONG; stdcall; external 'ntdll.dll' Name 'RtlGetVersion';

function Wow64DisableWow64FsRedirection(var OldValue: Pointer): BOOL; stdcall; external 'kernel32.dll';
function Wow64RevertWow64FsRedirection(OldValue: Pointer): BOOL; stdcall; external 'kernel32.dll';

procedure DisableWow64FsRedirection(const Proc: TProc);

function IsWindowsVersionOrGreater(Major, Minor, Build: DWORD): Boolean;

implementation

procedure DisableWow64FsRedirection(const Proc: TProc);
var
  OldState: Pointer;
  FsRedirDisabled: BOOL;
begin
  if not Assigned(Proc) then Exit;

  FsRedirDisabled := Wow64DisableWow64FsRedirection(OldState);
  try
    Proc();
  finally
    if FsRedirDisabled then
      Wow64RevertWow64FsRedirection(OldState);
  end;
end;

function IsWindowsVersionOrGreater(Major, Minor, Build: DWORD): Boolean;
var
  winver: RTL_OSVERSIONINFOEXW;
begin
  FillChar(winver, SizeOf(winver), 0);
  winver.dwOSVersionInfoSize := SizeOf(winver);
  Result := False;
  if RtlGetVersion(winver) = 0 then
  begin
    if winver.dwMajorVersion > Major then
      Exit(True);
    if winver.dwMajorVersion = Major then
    begin
      if winver.dwMinorVersion > Minor then
        Exit(True);
      if winver.dwMinorVersion = Minor then
        Exit(winver.dwBuildNumber >= Build);
    end;
  end;
end;

end.
