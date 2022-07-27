unit Einstellungen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ColorGrd, Buttons, ActnMan, ActnColorMaps;

type
  TEinstellungensFRM = class(TForm)
    FarbenPanel: TPanel;
    ColorDialogV: TColorDialog;
    ImageVor: TImage;
    Label4: TLabel;
    Label3: TLabel;
    ButtonV: TButton;
    ButtonE: TButton;
    ButtonH: TButton;
    ImageV: TImage;
    ImageE: TImage;
    ImageF: TImage;
    ColorDialogE: TColorDialog;
    ColorDialogH: TColorDialog;
    ButtonM: TButton;
    ColorDialogM: TColorDialog;
    ImageM: TImage;
    Label5: TLabel;
    ButtonAE: TButton;
    ButtonAF: TButton;
    ImageAE: TImage;
    ImageAF: TImage;
    ColorDialogAF: TColorDialog;
    ColorDialogAE: TColorDialog;
    ButtonF: TButton;
    ImageH: TImage;
    ColorDialogF: TColorDialog;
    procedure FormCreate(Sender: TObject);
    procedure ButtonVClick(Sender: TObject);
    procedure ButtonEClick(Sender: TObject);
    procedure ButtonHClick(Sender: TObject);
    procedure ImageFarbenAktualisieren;
    procedure ButtonMClick(Sender: TObject);
    procedure ButtonAFClick(Sender: TObject);
    procedure ButtonAEClick(Sender: TObject);
    procedure ButtonFClick(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EinstellungensFRM: TEinstellungensFRM;

implementation
uses Haupt;
{$R *.dfm}

procedure TEinstellungensFRM.ImageFarbenAktualisieren;
begin
  with ImageVor.Canvas do
  begin
    Brush.Color := HauptForm.HColor;
    Brush.Style := bssolid;
    Pen.Color := HauptForm.HColor;
    Rectangle(0, 0, Width, Height);
    Pen.Color := ((not HauptForm.HColor) and $00FFFFFF) or (HauptForm.HColor and $FF000000); //http://www.delphipraxis.net/234840-post.html#271833
    MoveTo(60, 0);
    LineTo(60, 60);
    Font.Name := 'Courier New';
    Font.Size := 40;
    Font.Style := [fsBold];
    Font.Color := HauptForm.VColor;
    TextOut(10, 0, 'V');
    Font.Color := HauptForm.EColor;
    TextOut(70, 0, 'E');
    Font.Size := 17;
    Font.Color := HauptForm.MColor;
    TextOut(40, 37, 'M');
    Pen.Color := HauptForm.FColor;
    Brush.Color := HauptForm.FColor;
    Brush.Style := bsBDiagonal;
    Rectangle(61, 1, 120, 60);
    Rectangle(62, 2, 119, 59);
    Rectangle(63, 3, 118, 58);
    Rectangle(64, 4, 117, 57);
    Rectangle(65, 5, 116, 56);
  end;

  with ImageV.Canvas do
  begin
    Brush.Color := HauptForm.VColor;
    Brush.Style := bssolid;
    Pen.Color := HauptForm.VColor;
    Rectangle(0, 0, Width, Height);
  end;

  with ImageE.Canvas do
  begin
    Brush.Color := HauptForm.EColor;
    Brush.Style := bssolid;
    Pen.Color := HauptForm.EColor;
    Rectangle(0, 0, Width, Height);
  end;

  with ImageH.Canvas do
  begin
    Brush.Color := HauptForm.HColor;
    Brush.Style := bssolid;
    Pen.Color := HauptForm.HColor;
    Rectangle(0, 0, Width, Height);
  end;

  with ImageM.Canvas do
  begin
    Brush.Color := HauptForm.MColor;
    Brush.Style := bssolid;
    Pen.Color := HauptForm.MColor;
    Rectangle(0, 0, Width, Height);
  end;

  with ImageAE.Canvas do
  begin
    Brush.Color := HauptForm.AEColor;
    Brush.Style := bssolid;
    Pen.Color := HauptForm.AEColor;
    Rectangle(0, 0, Width, Height);
  end;

  with ImageAF.Canvas do
  begin
    Brush.Color := HauptForm.AFColor;
    Brush.Style := bssolid;
    Pen.Color := HauptForm.AFColor;
    Rectangle(0, 0, Width, Height);
  end;

  with ImageAE.Canvas do
  begin
    Brush.Color := HauptForm.AEColor;
    Brush.Style := bssolid;
    Pen.Color := HauptForm.AEColor;
    Rectangle(0, 0, Width, Height);
  end;

    with ImageF.Canvas do
  begin
    Brush.Color := HauptForm.FColor;
    Brush.Style := bssolid;
    Pen.Color := HauptForm.FColor;
    Rectangle(0, 0, Width, Height);
  end;

    HauptForm.SpielfeldZeichnen;
end;



procedure TEinstellungensFRM.ButtonVClick(Sender: TObject);
begin
  if ColorDialogV.Execute then
  begin
    HauptForm.VColor := ColorDialogV.Color;
    ImageFarbenAktualisieren;
  end;
end;

procedure TEinstellungensFRM.ButtonEClick(Sender: TObject);
begin
  if ColorDialogE.Execute then
  begin
    HauptForm.EColor := ColorDialogE.Color;
    ImageFarbenAktualisieren;
  end;
end;

procedure TEinstellungensFRM.ButtonFClick(Sender: TObject);
begin
  if ColorDialogF.Execute then
  begin
    HauptForm.FColor := ColorDialogF.Color;
    ImageFarbenAktualisieren;
  end;
end;

procedure TEinstellungensFRM.ButtonHClick(Sender: TObject);
begin
  if ColorDialogH.Execute then
  begin
    HauptForm.HColor := ColorDialogH.Color;
    ImageFarbenAktualisieren;
  end;
end;

procedure TEinstellungensFRM.ButtonMClick(Sender: TObject);
begin
  if ColorDialogM.Execute then
  begin
    HauptForm.MColor := ColorDialogM.Color;
    ImageFarbenAktualisieren;
  end;
end;

procedure TEinstellungensFRM.ButtonAFClick(Sender: TObject);
begin
  if ColorDialogAF.Execute then
  begin
    HauptForm.AFColor := ColorDialogAF.Color;
    ImageFarbenAktualisieren;
  end;
end;


procedure TEinstellungensFRM.ButtonAEClick(Sender: TObject);
begin
  if ColorDialogAE.Execute then
  begin
    HauptForm.AEColor := ColorDialogAE.Color;
    ImageFarbenAktualisieren;
  end;
end;


procedure TEinstellungensFRM.FormCreate(Sender: TObject);
begin
  ImageFarbenAktualisieren;
end;

end.

