unit uForms;

interface

uses
  Winapi.Windows, Winapi.Messages, Vcl.Controls, Vcl.Forms;

procedure UI_DragForm(AForm: TForm; Button: TMouseButton);
procedure UI_SetAlwaysOnTop(AForm: TForm; const IsAlwaysOnTop: Boolean);
procedure UI_SetMinConstraints(AForm: TForm);

implementation

procedure UI_DragForm(AForm: TForm; Button: TMouseButton);
begin
  if (AForm <> nil) and (Button = mbLeft) then
  begin
    ReleaseCapture;
    SendMessage(AForm.Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
  end;
end;

procedure UI_SetAlwaysOnTop(AForm: TForm; const IsAlwaysOnTop: Boolean);
begin
  if AForm = nil then Exit;

  if IsAlwaysOnTop then
    SetWindowPos(AForm.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE)
  else
    SetWindowPos(AForm.Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
end;

procedure UI_SetMinConstraints(AForm: TForm);
begin
  if AForm <> nil then
  begin
    AForm.Constraints.MinWidth := AForm.Width;
    AForm.Constraints.MinHeight := AForm.Height;
  end;
end;

end.
