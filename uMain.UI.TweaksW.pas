unit uMain.UI.TweaksW;

interface

uses
  Winapi.Windows, System.SysUtils, Registry;

function EnableAutoLoginW(Enable: Boolean): Boolean;

implementation

function EnableAutoLoginW(Enable: Boolean): Boolean;
const
  ROOT1   = HKEY_LOCAL_MACHINE;
  PATH1   = 'Software\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device';
  VALUE1  = 'DevicePasswordLessBuildVersion';

  ROOT2  = HKEY_LOCAL_MACHINE;
  PATH2  = 'Software\Microsoft\Windows NT\CurrentVersion\Winlogon';
  VALUE2a = 'AutoAdminLogon';
  VALUE2b = 'DefaultUserName';
  VALUE2c = 'DefaultDomainName';
  VALUE2d = 'DefaultPassword'; // Windows 11에는 없음.
var
  xReg: TRegistry;
  Data: Cardinal;
begin
  Result := Enable;

  xReg := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_64KEY);
  try
    xReg.RootKey := ROOT1;
    if xReg.OpenKey(PATH1, True) then
    try
      try
        if Enable then
          Data := 0
        else
          Data := 2;
        xReg.WriteInteger(VALUE1, Integer(Data));
      except
        on E: Exception do
          OutputDebugString(PChar('WriteInteger failed at ' + PATH1 + '\' + VALUE1 + ': ' + E.Message));
      end;
    finally
      xReg.CloseKey;
    end
    else
      OutputDebugString(PChar('OpenKey failed: ' + PATH1 + ' (err=' + IntToStr(GetLastError) + ')'));
  finally
    xReg.Free;
  end;

  if not Enable then
  begin
    xReg := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_64KEY);
    try
      xReg.RootKey := ROOT2;
      if xReg.OpenKey(PATH2, False) then
      try
        if xReg.ValueExists(VALUE2a) then xReg.DeleteValue(VALUE2a);
        if xReg.ValueExists(VALUE2b) then xReg.DeleteValue(VALUE2b);
        if xReg.ValueExists(VALUE2c) then xReg.DeleteValue(VALUE2c);
        if xReg.ValueExists(VALUE2d) then xReg.DeleteValue(VALUE2d);
      finally
        xReg.CloseKey;
      end;
    finally
      xReg.Free;
    end;
    Result := False;
  end;
end;

end.
