unit uExt;

interface

uses
  Winapi.Windows, System.SysUtils;

const
  WIN10_20H2 = 19042;

function Wow64DisableWow64FsRedirection(var OldValue: Pointer): BOOL; stdcall; external 'kernel32.dll';
function Wow64RevertWow64FsRedirection(OldValue: Pointer): BOOL; stdcall; external 'kernel32.dll';

function RtlGetVersion(var RTL_OSVERSIONINFOEXW): LONG; stdcall; external 'ntdll.dll' Name 'RtlGetVersion';

function IsWindowsVersionOrHigher(Major, Minor, Build: DWORD): Boolean;
function IsWindows10_20H2_Or_Later: Boolean; inline;

implementation

function IsWindowsVersionOrHigher(Major, Minor, Build: DWORD): Boolean;
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

function IsWindows10_20H2_Or_Later: Boolean; inline;
begin
  Result := IsWindowsVersionOrHigher(10, 0, WIN10_20H2);
end;

end.
