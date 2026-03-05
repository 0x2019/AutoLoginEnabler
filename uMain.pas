unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, System.SysUtils, Vcl.Buttons,
  Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, Vcl.Graphics, Vcl.ImgList, Vcl.StdCtrls,
  sSkinManager, sSkinProvider, sCheckBox, sPanel, acAlphaImageList, sBitBtn,
  acAlphaHints, System.ImageList,

  uForms, uMessageBox;

type
  TfrmMain = class(TForm)
    sAlphaHints: TsAlphaHints;
    sAlphaImageList: TsAlphaImageList;
    sCharImageList: TsCharImageList;
    sSkinManager: TsSkinManager;
    sSkinProvider: TsSkinProvider;
    btnExit: TsBitBtn;
    btnAbout: TsBitBtn;
    pnlALE: TsPanel;
    chkEAL: TsCheckBox;
    btnOpenNetplwiz: TsBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure chkEALClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnOpenNetplwizClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ChangeMessageBoxPosition(var Msg: TMessage); message mbMessage;
    procedure DragForm(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uAppController, uAppStrings;

procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  AppController_About(Self);
end;

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
  AppController_Exit(Self);
end;

procedure TfrmMain.ChangeMessageBoxPosition(var Msg: TMessage);
begin
  UI_ChangeMessageBoxPosition(Self);
end;

procedure TfrmMain.chkEALClick(Sender: TObject);
begin
  AppController_ToggleAutoLogin(Self);
end;

procedure TfrmMain.DragForm(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  UI_DragForm(Self, Button);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  UI_SetMinConstraints(Self);
  UI_SetAlwaysOnTop(Self, True);

  pnlALE.OnMouseDown := DragForm;

  AppController_LoadTweaks(Self);
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    AppController_Exit(Self);
end;

procedure TfrmMain.btnOpenNetplwizClick(Sender: TObject);
begin
  AppController_OpenNetplwiz(Self);
end;

end.
