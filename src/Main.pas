unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus;

type
  TMainForm = class(TForm)
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    Quit1: TMenuItem;
    CodeFumbleSfxdubmoodRazor19111: TMenuItem;
    SpaceInvadersv101: TMenuItem;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Quit1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses xmfile, uFMOD;

const
  W: Integer = 7;
  H: Integer = 6;
  BLANK: Integer = 4;
  SHAPE: Integer = 50;
  MAX_X: Integer = 378;
  MAX_Y: Integer = 324;

var
  invader: array [0 .. 5, 0 .. 6] of Integer = // w * h
    ((0, 0, 1, 0, 1, 0, 0), (0, 1, 1, 1, 1, 1, 0), (0, 1, 2, 1, 2, 1, 0),
    (0, 1, 0, 1, 0, 1, 0), (1, 1, 1, 1, 1, 1, 1), (1, 0, 1, 0, 1, 0, 1));

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  uFMOD_StopSong;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  color := clWhite;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  uFMOD_PlaySong(@xm, Length(xm), XM_MEMORY)
end;

procedure TMainForm.Quit1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    Close;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  i, j, x, y: Integer;
  rndX, rndEye: Integer;
  col: TColor;
begin
  Canvas.Brush.color := RGB(255, 255, 255);
  Canvas.FillRect(Canvas.ClipRect);
  rndX := Random(Width - MAX_X);
  rndEye := Random(4);
  case rndEye of
    0:
      begin
        invader[2, 2] := 2;
        invader[2, 4] := 2;
        invader[3, 2] := 0;
        invader[3, 4] := 0;
      end;
    1:
      begin
        invader[2, 2] := 2;
        invader[2, 4] := 0;
        invader[3, 2] := 0;
        invader[3, 4] := 2;
      end;
    2:
      begin
        invader[2, 2] := 0;
        invader[2, 4] := 0;
        invader[3, 2] := 2;
        invader[3, 4] := 2;
      end;
    3:
      begin
        invader[2, 2] := 0;
        invader[2, 4] := 2;
        invader[3, 2] := 2;
        invader[3, 4] := 0;
      end;
  end;

  x := rndX;
  y := Random(Height - MAX_Y);
  col := RGB(Random(256), Random(256), Random(256));
  Canvas.Brush.color := col;

  for i := 0 to W do
  begin
    for j := 0 to H do
    begin
      if invader[i, j] = 1 then
        Canvas.Rectangle(x, y, x + SHAPE, y + SHAPE)
      else if invader[i, j] = 2 then
      begin
        Canvas.Brush.color := RGB(0, 0, 0);
        Canvas.Rectangle(x, y, x + SHAPE, y + SHAPE);
        Canvas.Brush.color := col;
      end;
      x := x + SHAPE + BLANK;
    end;
    y := y + SHAPE + BLANK;
    x := rndX;
  end;
end;

end.
