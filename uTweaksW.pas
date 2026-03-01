unit uTweaksW;

interface

uses
  Winapi.Windows, System.SysUtils, Registry;

function EnableAutoLoginW(AOption: Boolean): Boolean;

implementation

function EnableAutoLoginW(AOption: Boolean): Boolean;
const
  ROOT1 = HKEY_LOCAL_MACHINE;
  PATH1 = 'Software\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device';
  VALUE1 = 'DevicePasswordLessBuildVersion';

  ROOT2  = HKEY_LOCAL_MACHINE;
  PATH2  = 'Software\Microsoft\Windows NT\CurrentVersion\Winlogon';
  VALUE2a = 'AutoAdminLogon';
  VALUE2b = 'DefaultUserName';
  VALUE2c = 'DefaultDomainName';
  VALUE2d = 'DefaultPassword'; // Windows 11에는 없음.
var
  Reg: TRegistry;
  Data: Cardinal;
begin
  Result := AOption;

  Reg := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_64KEY);
  try
    Reg.RootKey := ROOT1;
    if Reg.OpenKey(PATH1, True) then
    try
      try
        if AOption then
          Data := 0
        else
          Data := 2;
        Reg.WriteInteger(VALUE1, Integer(Data));
      except
        on E: Exception do
          OutputDebugString(PChar('WriteInteger failed at ' + PATH1 + '\' + VALUE1 + ': ' + E.Message));
      end;
    finally
      Reg.CloseKey;
    end
    else
      OutputDebugString(PChar('OpenKey failed: ' + PATH1 + ' (err=' + IntToStr(GetLastError) + ')'));
  finally
    Reg.Free;
  end;

  if not AOption then
  begin
    Reg := TRegistry.Create(KEY_ALL_ACCESS or KEY_WOW64_64KEY);
    try
      Reg.RootKey := ROOT2;
      if Reg.OpenKey(PATH2, False) then
      try
        if Reg.ValueExists(VALUE2a) then Reg.DeleteValue(VALUE2a);
        if Reg.ValueExists(VALUE2b) then Reg.DeleteValue(VALUE2b);
        if Reg.ValueExists(VALUE2c) then Reg.DeleteValue(VALUE2c);
        if Reg.ValueExists(VALUE2d) then Reg.DeleteValue(VALUE2d);
      finally
        Reg.CloseKey;
      end;
    finally
      Reg.Free;
    end;
    Result := False;
  end;
end;

end.
