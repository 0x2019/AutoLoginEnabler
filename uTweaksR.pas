unit uTweaksR;

interface

uses
  Winapi.Windows, Registry;

function EnableAutoLoginR: Boolean;

implementation

function EnableAutoLoginR: Boolean;
const
  ROOT = HKEY_LOCAL_MACHINE;
  PATH = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device';
  VALUE = 'DevicePasswordLessBuildVersion';
var
  Reg: TRegistry;
begin
  Result := False;
  Reg := TRegistry.Create(KEY_READ or KEY_WOW64_64KEY);
  try
    Reg.RootKey := ROOT;
    if Reg.OpenKeyReadOnly(PATH) then
    try
      if Reg.ValueExists(VALUE) and (Reg.ReadInteger(VALUE) = 0) then
        Result := True;
    finally
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

end.
