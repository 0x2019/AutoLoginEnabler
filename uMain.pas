unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, System.SysUtils, Vcl.Buttons,
  Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, Vcl.Graphics, Vcl.ImgList, Vcl.StdCtrls,
  sSkinManager, sSkinProvider, sCheckBox, sPanel, acAlphaImageList, sBitBtn,
  acAlphaHints, System.ImageList;

const
  mbMessage = WM_USER + 1024;

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
    procedure ChangeMessageBoxPosition(var Msg: TMessage); message mbMessage;
  public
    procedure DragForm(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uMain.UI, uMain.UI.Messages, uMain.UI.TweaksW;

procedure TfrmMain.btnAboutClick(Sender: TObject);
begin
  UI_About(Self);
end;

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
  UI_Exit(Self);
end;

procedure TfrmMain.ChangeMessageBoxPosition(var Msg: TMessage);
begin
  UI_ChangeMessageBoxPosition(Self);
end;

procedure TfrmMain.chkEALClick(Sender: TObject);
begin
  EnableAutoLoginW(chkEAL.Checked);
end;

procedure TfrmMain.DragForm(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    SendMessage(Handle, WM_NCLBUTTONDOWN, HTCAPTION, 0);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  UI_Init(Self);
  UI_LoadTweaks(Self);
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TfrmMain.btnOpenNetplwizClick(Sender: TObject);
begin
  UI_OpenNetplwiz(Self);
end;

end.
