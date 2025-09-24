unit uMain.UI.TweaksR;

interface

uses
  Winapi.Windows, System.SysUtils, Registry;

function EnableAutoLoginR: Boolean;

implementation

function EnableAutoLoginR: Boolean;
const
  ROOT   = HKEY_LOCAL_MACHINE;
  PATH   = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device';
  VALUE  = 'DevicePasswordLessBuildVersion';
var
  xReg: TRegistry;
begin
  Result := False;
  xReg := TRegistry.Create(KEY_READ or KEY_WOW64_64KEY);
  try
    xReg.RootKey := ROOT;
    if xReg.OpenKeyReadOnly(PATH) then
    try
      if xReg.ValueExists(VALUE) and (xReg.ReadInteger(VALUE) = 0) then
        Result := True;
    finally
      xReg.CloseKey;
    end;
  finally
    xReg.Free;
  end;
end;

end.
