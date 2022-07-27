unit Haupt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, jpeg, DBCtrls, StdCtrls, Menus, FileCtrl,
  IniFiles, XPMan, hh, hh_funcs, D6OnHelpFix;

type
  TMoeglichkeiten = array of integer;
  THauptForm = class(TForm)
    MainMenu1: TMainMenu;
    Spiel1: TMenuItem;
    Spielstarten1: TMenuItem;
    sehreinfach1: TMenuItem;
    einfach1: TMenuItem;
    mittel1: TMenuItem;
    schwer1: TMenuItem;
    sehrschwer1: TMenuItem;
    Spielspeichern1: TMenuItem;
    Spielladen1: TMenuItem;
    Beenden1: TMenuItem;
    aktuellesSpiel1: TMenuItem;
    Pause1: TMenuItem;
    Fortsetzen1: TMenuItem;
    Aufgeben1: TMenuItem;
    Fehleranzeigen1: TMenuItem;
    Hilfe1: TMenuItem;
    Hilfe2: TMenuItem;
    berHexaDoku1: TMenuItem;
    Einstellungen1: TMenuItem;
    Normal1: TMenuItem;
    Timer1: TTimer;
    XPManifest1: TXPManifest;
    Zeit: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    HighScores1: TMenuItem;
    Wiebeginneich1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ImageArMouseEnter(Sender: TObject);
    procedure ImageArMouseLeave(Sender: TObject);
    procedure Markieren;
    procedure UnMarkieren;
    procedure ColMarkieren;
    procedure RowMarkieren;
    procedure ColUnMarkieren;
    procedure RowUnMarkieren;
    procedure BlockMarkieren;
    procedure BlockUnMarkieren;
    procedure Einstellungen1Click(Sender: TObject);
    procedure SpielfeldZeichnen;
    function Moegliche(const ACol, ARow: integer): TMoeglichkeiten;
    function HexaToInter(var Wert: char): Integer;
    function InterToHexa(var Wert: Integer): Char;
    procedure sehreinfach1Click(Sender: TObject);
    function DateienZaehlen(DateiPfad: string): Integer;
    procedure FeldZeichnen(Col, Row: Integer);
    procedure Timer1Timer(Sender: TObject);
    function ZeitUmrechnen(SekundenEin: Integer): string;
    procedure ZeitClick(Sender: TObject);
    function MenuItemRightJustify(MenuItem: TMenuItem): Boolean;
    procedure Beenden1Click(Sender: TObject);
    procedure AppMinimize(Sender: TObject);
    function FehlerSuchen(Zeichnen: Boolean): Boolean;
    procedure Fehleranzeigen1Click(Sender: TObject);
    procedure Pause1Click(Sender: TObject);
    procedure Fortsetzen1Click(Sender: TObject);
    procedure Aufgeben1Click(Sender: TObject);
    procedure LoesungAnzeigen;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Spielspeichern1Click(Sender: TObject);
    procedure Laden(DateiName: string);
    procedure Speichern(DateiName: string);
    procedure Spielladen1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure einfach1Click(Sender: TObject);
    procedure Normal1Click(Sender: TObject);
    procedure mittel1Click(Sender: TObject);
    procedure schwer1Click(Sender: TObject);
    procedure sehrschwer1Click(Sender: TObject);
    procedure HighScores1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure Hilfe2Click(Sender: TObject);
    procedure berHexaDoku1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Wiebeginneich1Click(Sender: TObject);
  private
    { Private declarations }
  public
    function GetUsername: string;
  var aktuelleSchwierigkeit: string;
    Aufloesung, aktuelleSek: Integer;
    VColor, EColor, HColor, MColor, AEColor, AFColor, FColor: TColor;
    virAr, LoesungAr: array[0..15, 0..15] of Integer;
    { Public declarations }
  end;

var
  HauptForm: THauptForm;
  AKTIV: Integer;
  ImageAr: array[0..15, 0..15] of TImage;
  Groese: Integer;
  MoeglicheAr: array[0..15, 0..15, 0..16] of Boolean;
  VorgabenAr: array[0..15, 0..15] of Boolean;
  PauseAktiv, SpielAktiv: Boolean;
  PauseBild: TImage;
  mHHelp: THookHelpSystem;

implementation
uses Einstellungen, NeuerHighScore, HighScores;
{$R *.dfm}

procedure THauptForm.FeldZeichnen(Col: Integer; Row: Integer);
var i, x, y, oben, mitteE, mitteZ, unten, links, llinks, rrechts, rechts: Integer;
  P: TMoeglichkeiten;
begin
  links := Groese div 10;
  llinks := Groese div 4 + Groese div 10;
  rrechts := Groese div 2 + Groese div 10;
  rechts := Groese - Groese div 7 - 1;
  oben := links - Groese div 20;
  mitteE := llinks - Groese div 20;
  mitteZ := rrechts - Groese div 20;
  unten := rechts - Groese div 20;
  if assigned(ImageAr[row, col]) then ImageAr[row, col].Destroy;
  ImageAr[row, col] := TImage.Create(HauptForm);
  ImageAr[row, col].Parent := HauptForm;
  ImageAr[row, col].Width := Groese;
  ImageAr[row, col].Height := Groese;
  ImageAr[row, col].Canvas.Brush.Color := HColor;
  ImageAr[row, col].Canvas.Brush.Style := bssolid;
  ImageAr[row, col].Canvas.Rectangle(0, 0, Groese, Groese);
  ImageAr[row, col].Canvas.Font.Size := Groese div 10;
  ImageAr[row, col].Canvas.Font.Color := MColor;
  ImageAr[row, col].Canvas.Font.Name := 'Courier New';
  ImageAr[row, col].Canvas.Font.Style := [fsBold];
  ImageAr[row, col].Top := row * (Groese + 1) + (row div 4) * 5 + 4;
  ImageAr[row, col].Left := col * (Groese + 1) + (col div 4) * 5 + 4;
  ImageAr[row, col].Enabled := true;
  ImageAr[row, col].Visible := true;
  ImageAr[row, col].OnMouseEnter := ImageArMouseEnter;
  ImageAr[row, col].OnMouseLeave := ImageArMouseLeave;
  ImageAr[row, col].Tag := col * 16 + row;
  if virAr[row, col] = 0 then
  begin
    P := Moegliche(row, col);
    for i := 0 to Length(P) - 1 do
      case P[i] of
        1: ImageAr[row, col].Canvas.TextOut(links, oben, '0');
        2: ImageAr[row, col].Canvas.TextOut(llinks, oben, '1');
        3: ImageAr[row, col].Canvas.TextOut(rrechts, oben, '2');
        4: ImageAr[row, col].Canvas.TextOut(rechts, oben, '3');
        5: ImageAr[row, col].Canvas.TextOut(links, mitteE, '4');
        6: ImageAr[row, col].Canvas.TextOut(llinks, mitteE, '5');
        7: ImageAr[row, col].Canvas.TextOut(rrechts, mitteE, '6');
        8: ImageAr[row, col].Canvas.TextOut(rechts, mitteE, '7');
        9: ImageAr[row, col].Canvas.TextOut(links, mitteZ, '8');
        10: ImageAr[row, col].Canvas.TextOut(llinks, mitteZ, '9');
        11: ImageAr[row, col].Canvas.TextOut(rrechts, mitteZ, 'A');
        12: ImageAr[row, col].Canvas.TextOut(rechts, mitteZ, 'B');
        13: ImageAr[row, col].Canvas.TextOut(links, unten, 'C');
        14: ImageAr[row, col].Canvas.TextOut(llinks, unten, 'D');
        15: ImageAr[row, col].Canvas.TextOut(rrechts, unten, 'E');
        16: ImageAr[row, col].Canvas.TextOut(rechts, unten, 'F');
      end;
  end
  else
    if VorgabenAr[row, col] then
    begin
      ImageAr[row, col].Canvas.Font.Size := Round(Groese / 1.5);
      ImageAr[row, col].Canvas.Font.Color := VColor;
      ImageAr[row, col].Canvas.Font.Style := [fsBold];
      ImageAr[row, col].Canvas.Font.Name := 'Courier New';
    //ImageAr[row, col].Canvas.TextOut(Round(Groese/10), Round(Groese/50), InterToHexa(virAr[row, col]));
      x := Groese - ImageAr[row, col].Canvas.Textwidth(InterToHexa(virAr[row, col]));
      y := Groese - ImageAr[row, col].Canvas.Textheight(InterToHexa(virAr[row, col]));
      ImageAr[row, col].Canvas.TextOut(x div 2, y div 2, InterToHexa(virAr[row, col]));
      ImageAr[row, col].Canvas.Brush.Style := bsClear;
      ImageAr[row, col].Canvas.Rectangle(0, 0, Groese, Groese);
    end
    else
    begin
      ImageAr[row, col].Canvas.Font.Size := Round(Groese / 1.5);
      ImageAr[row, col].Canvas.Font.Color := EColor;
      ImageAr[row, col].Canvas.Font.Style := [fsBold];
      ImageAr[row, col].Canvas.Font.Name := 'Courier New';
    //ImageAr[row, col].Canvas.TextOut(Round(Groese/10), Round(Groese/50), InterToHexa(virAr[row, col]));
      x := Groese - ImageAr[row, col].Canvas.Textwidth(InterToHexa(virAr[row, col]));
      y := Groese - ImageAr[row, col].Canvas.Textheight(InterToHexa(virAr[row, col]));
      ImageAr[row, col].Canvas.TextOut(x div 2, y div 2, InterToHexa(virAr[row, col]));
      ImageAr[row, col].Canvas.Brush.Style := bsClear;
      ImageAr[row, col].Canvas.Rectangle(0, 0, Groese, Groese);
    end;
end;

procedure THauptForm.SpielfeldZeichnen;
var row, col: Integer;
begin
  Aufloesung := HauptForm.ClientWidth;
  Groese := Aufloesung div 17;
  for row := 0 to 15 do
    for col := 0 to 15 do
    begin
      FeldZeichnen(col, row);
    end;
end;


procedure THauptForm.Spielladen1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    aktuelleSchwierigkeit := '';
    Laden(OpenDialog1.FileName);
    SpielAktiv := true;
    PauseAktiv := False;
    Zeit.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Ressourcen\Pause.bmp');
    aktuellesSpiel1.Enabled := True;
    Timer1.Enabled := true;
    aktuelleSchwierigkeit := 'Sehr einfach';
  end;
end;

procedure THauptForm.Spielspeichern1Click(Sender: TObject);
begin
  if PauseAktiv then
  else Zeit.Click;
  if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    begin
      if MessageDlg('Wollen Sie das Spiel wirklich überschreiben?', mtConfirmation, mbYesNoCancel, 0) = mrYes then
      begin
        Speichern(SaveDialog1.FileName);
      end;
    end
    else
    begin
      Speichern(SaveDialog1.FileName);
    end;
  end;
  if PauseAktiv then Zeit.Click;
end;

procedure THauptForm.Timer1Timer(Sender: TObject);
var
  aktuelleZeit: string;
begin
  aktuelleSek := aktuelleSek + 1;
  aktuelleZeit := ZeitUmrechnen(aktuelleSek);
  Zeit.Caption := aktuelleZeit;
  MenuItemRightJustify(Zeit);
end;

procedure THauptForm.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
// Quelle: http://www.delphipraxis.net/136090-quadratisches-fenster-auch-waehrend-resize.html
  NewWidth := NewHeight - 40; // -40 ist experimentel für den gleichen Rand
  Resize := True;
end;

procedure THauptForm.FormClose(Sender: TObject; var Action: TCloseAction);
var IniDatei: TIniFile;
begin
  Aufloesung := HauptForm.Height;
  IniDatei := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Einstellungen\Einstellungen.ini');
  try
    IniDatei.WriteInteger('Aufloesung', 'Aufloesung', Aufloesung);
    IniDatei.WriteInteger('Farben', 'VColor', Integer(VColor));
    IniDatei.WriteInteger('Farben', 'EColor', Integer(EColor));
    IniDatei.WriteInteger('Farben', 'HColor', Integer(HColor));
    IniDatei.WriteInteger('Farben', 'AEColor', Integer(AEColor));
    IniDatei.WriteInteger('Farben', 'AFColor', Integer(AFColor));
    IniDatei.WriteInteger('Farben', 'FColor', Integer(FColor));
    IniDatei.WriteInteger('Farben', 'MColor', Integer(MColor));
  finally
    IniDatei.Free;
  end;
end;

procedure THauptForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := false;
  if Application.MessageBox('Wollen Sie das Programm ohne zu speichern wirklich beenden?', 'Beenden?', MB_ICONQUESTION or MB_YESNO) = IDYES then
    CanClose := true;
end;

procedure THauptForm.FormCreate(Sender: TObject);
var IniDatei: TIniFile;
  chmFile: string;
begin
  Randomize;
  MenuItemRightJustify(Zeit);
  PauseAktiv := true;
  aktuelleSek := 0;
  Timer1.Enabled := false;
  SpielAktiv := False;
  AKTIV := -10;
  aktuelleSchwierigkeit := '';
  HauptForm.DoubleBuffered := True;
  Application.OnMinimize := AppMinimize;
  IniDatei := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Einstellungen\Einstellungen.ini');
  try
    Aufloesung := IniDatei.ReadInteger('Aufloesung', 'Aufloesung', 900);
    VColor := TColor(IniDatei.ReadInteger('Farben', 'VColor', Integer(clRed)));
    EColor := TColor(IniDatei.ReadInteger('Farben', 'EColor', Integer(clPurple)));
    HColor := TColor(IniDatei.ReadInteger('Farben', 'HColor', Integer(clWhite)));
    MColor := TColor(IniDatei.ReadInteger('Farben', 'MColor', Integer(clMedGray)));
    AEColor := TColor(IniDatei.ReadInteger('Farben', 'AEColor', Integer(clBlue)));
    AFColor := TColor(IniDatei.ReadInteger('Farben', 'AFColor', Integer(clYellow)));
    FColor := TColor(IniDatei.ReadInteger('Farben', 'FColor', Integer(clRed)));
  finally
    IniDatei.Free;
  end;
  SpielfeldZeichnen;
  //Quelltext von http://www.delphi-treff.de/tutorials/tools/html-hilfe/umleitung/
  //<-----------------------------
  chmFile := ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Hilfe\HexaDoku.chm';
  mHHelp := nil;
  if not FileExists(chmFile) then
    ShowMessage('Hilfe-Datei nicht gefunden'#13 + chmFile);
  {HH 1.2 oder höher Versionskontrolle}
  if (hh.HHCtrlHandle = 0)
    or (hh_funcs._hhMajVer < 4)
    or ((hh_funcs._hhMajVer = 4) and (hh_funcs._hhMinVer < 73)) then
    ShowMessage('Diese Anwendung erfordert die Installation der ' +
      'MS HTML Help 1.2 oder höher');
  {Hook - verwendet HH_FUNCS.pas}
  mHHelp := hh_funcs.THookHelpSystem.Create(chmFile, '', htHHAPI);
  //---------------------------->
end;

procedure THauptForm.FormDestroy(Sender: TObject);
begin
//Quelltext von http://www.delphi-treff.de/tutorials/tools/html-hilfe/umleitung/
//<-------------------------------------
  HHCloseAll; // Schließt alle Hilfe-Fenster
  if Assigned(mHHelp) then
    mHHelp.Free;
//-------------------------------------->
end;

procedure THauptForm.FormKeyPress(Sender: TObject; var Key: Char);
var row, col, row1, col1: Integer;
  T: Char;
begin
  if AKTIV = -10 then
  begin
    AKTIV := 0;
    Markieren;
    RowMarkieren;
    ColMarkieren;
    Exit;
  end;
  col := AKTIV div 16;
  row := AKTIV mod 16;
  if (ord(Key) = 122) then //Z
  begin
    if row > 0 then
    begin
      UnMarkieren;
      RowUnMarkieren;
      ColUnMarkieren;
      BlockUnMarkieren;
      AKTIV := col * 16 + (row - 1);
      Markieren;
      RowMarkieren;
      ColMarkieren;
      BlockMarkieren;
      Exit;
    end
  end;
  if (ord(Key) = 103) then //G
  begin
    if col > 0 then
    begin
      UnMarkieren;
      RowUnMarkieren;
      ColUnMarkieren;
      BlockUnMarkieren;
      AKTIV := (col - 1) * 16 + row;
      Markieren;
      RowMarkieren;
      ColMarkieren;
      BlockMarkieren;
      Exit;
    end
  end;
  if (ord(Key) = 104) then //H
  begin
    if row <> 15 then
    begin
      UnMarkieren;
      RowUnMarkieren;
      ColUnMarkieren;
      BlockUnMarkieren;
      AKTIV := col * 16 + (row + 1);
      Markieren;
      RowMarkieren;
      ColMarkieren;
      BlockMarkieren;
      Exit;
    end
  end;
  if (ord(Key) = 106) then //J
  begin
    if col <> 15 then
    begin
      UnMarkieren;
      RowUnMarkieren;
      ColUnMarkieren;
      BlockUnMarkieren;
      AKTIV := (col + 1) * 16 + row;
      Markieren;
      RowMarkieren;
      ColMarkieren;
      BlockMarkieren;
      Exit;
    end
  end;
  if VorgabenAr[row][col] then Exit;
  if (ord(Key) = 8) then //Löschen
  begin
    virAr[row, col] := 0;
    SpielfeldZeichnen;
  end;
  //alle Zahlen/Buchstaben
  ImageAr[row, col].Canvas.Font.Size := 28;
  ImageAr[row, col].Canvas.Font.Color := EColor;
  ImageAr[row, col].Canvas.Font.Style := [fsBold];
  if ((ord(key) < 48) or (ord(key) > 57)) and (ord(key) <> 8) and ((ord(key) < 97) or (ord(key) > 102)) and ((ord(key) < 65) or (ord(key) > 70)) then
    key := chr(0)
  else
    if (ord(key) <> 8) then
    begin
      if ((ord(key) < 97) or (ord(key) > 102)) then
      begin
        ImageAr[row, col].Canvas.Pen.Color := EColor;
        ImageAr[row, col].Canvas.Brush.Color := HColor;
        ImageAr[row, col].Canvas.Brush.Style := bssolid;
        ImageAr[row, col].Canvas.Rectangle(0, 0, Groese, Groese);
        ImageAr[row, col].Canvas.TextOut(9, -2, Key);
        virAr[row, col] := HexaToInter(Key);
        ImageAr[row, col].Canvas.Brush.Color := clNone;
        ImageAr[row, col].Canvas.Brush.Style := bsClear;
        ImageAr[row, col].Canvas.Rectangle(0, 0, Groese, Groese);
        SpielfeldZeichnen;
      end
      else
      begin
        ImageAr[row, col].Canvas.Pen.Color := EColor;
        ImageAr[row, col].Canvas.Brush.Color := HColor;
        ImageAr[row, col].Canvas.Brush.Style := bssolid;
        ImageAr[row, col].Canvas.Rectangle(0, 0, Groese, Groese);
        ImageAr[row, col].Canvas.TextOut(9, -2, chr(ord(key) - 32));
        T := chr(ord(key) - 32);
        virAr[row, col] := HexaToInter(T);
        ImageAr[row, col].Canvas.Brush.Color := clNone;
        ImageAr[row, col].Canvas.Brush.Style := bsClear;
        ImageAr[row, col].Canvas.Rectangle(0, 0, Groese, Groese);
        SpielfeldZeichnen;
      end;
    end;
  if SpielAktiv then
  begin
    for row1 := 0 to 15 do
      for col1 := 0 to 15 do
        if VirAr[row1, col1] = 0 then Exit;
    if FehlerSuchen(False) then Application.MessageBox('Sie haben noch Fehler enthalten!', 'Fehler', MB_ICONWARNING or MB_OK)
    else
    begin
      NeuerHighscoreFRM.Show;
      aktuellesSpiel1.Enabled := False;
      SpielAktiv := False;
      Timer1.Enabled := False;
      PauseAktiv := True;
      MenuItemRightJustify(Zeit);
      Zeit.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Ressourcen\Start.bmp');
    end;
  end;
end;


procedure THauptForm.FormResize(Sender: TObject);
begin
  SpielfeldZeichnen;
end;

procedure THauptForm.ImageArMouseEnter(Sender: TObject);
begin
  if AKTIV <> -10 then
  begin
    UnMarkieren;
    ColUnMarkieren;
    RowUnMarkieren;
    BlockUnMarkieren;
  end;
  AKTIV := (Sender as TImage).Tag;
  Markieren;
  ColMarkieren;
  RowMarkieren;
  BlockMarkieren;
end;

procedure THauptForm.ImageArMouseLeave(Sender: TObject);
begin
  UnMarkieren;
  ColUnMarkieren;
  RowUnMarkieren;
  BlockUnMarkieren;
end;

procedure THauptForm.Markieren;
var row, col: Integer;
begin
  col := AKTIV div 16;
  row := AKTIV mod 16;
  ImageAr[row, col].Canvas.Pen.Color := AFColor;
  ImageAr[row, col].Canvas.Brush.Style := bsClear;
  ImageAr[row, col].Canvas.Rectangle(1, 1, Groese - 1, Groese - 1);
  ImageAr[row, col].Canvas.Rectangle(2, 2, Groese - 2, Groese - 2);
end;

procedure THauptForm.UnMarkieren;
var row, col: Integer;
begin
  col := AKTIV div 16;
  row := AKTIV mod 16;
  ImageAr[row, col].Canvas.Pen.Color := HColor;
  ImageAr[row, col].Canvas.Brush.Style := bsClear;
  ImageAr[row, col].Canvas.Rectangle(1, 1, Groese - 1, Groese - 1);
  ImageAr[row, col].Canvas.Rectangle(2, 2, Groese - 2, Groese - 2);
end;

procedure THauptForm.Wiebeginneich1Click(Sender: TObject);
begin
  Application.HelpContext(1006);
end;

procedure THauptForm.ColMarkieren;
var row, col, row1: Integer;
begin
  col := AKTIV div 16;
  row := AKTIV mod 16;
  for row1 := 0 to 15 do
    if row1 <> row then
    begin
      ImageAr[row1, col].Canvas.Pen.Color := AEColor;
      ImageAr[row1, col].Canvas.Brush.Style := bsClear;
      ImageAr[row1, col].Canvas.Rectangle(1, 1, Groese - 1, Groese - 1);
    end;
end;

procedure THauptForm.ColUnMarkieren;
var row, col, row1: Integer;
begin
  col := AKTIV div 16;
  row := AKTIV mod 16;
  for row1 := 0 to 15 do
    if row1 <> row then
    begin
      ImageAr[row1, col].Canvas.Pen.Color := HColor;
      ImageAr[row1, col].Canvas.Brush.Style := bsClear;
      ImageAr[row1, col].Canvas.Rectangle(1, 1, Groese - 1, Groese - 1);
    end;
end;

procedure THauptForm.Einstellungen1Click(Sender: TObject);
begin
  EinstellungensFRM.Show;
end;

procedure THauptForm.RowMarkieren;
var row, col, col1: Integer;
begin
  col := AKTIV div 16;
  row := AKTIV mod 16;
  for col1 := 0 to 15 do
    if col1 <> col then
    begin
      ImageAr[row, col1].Canvas.Pen.Color := AEColor;
      ImageAr[row, col1].Canvas.Brush.Style := bsClear;
      ImageAr[row, col1].Canvas.Rectangle(1, 1, Groese - 1, Groese - 1);
    end;
end;

procedure THauptForm.RowUnMarkieren;
var row, col, col1: Integer;
begin
  col := AKTIV div 16;
  row := AKTIV mod 16;
  for col1 := 0 to 15 do
    if col1 <> col then
    begin
      ImageAr[row, col1].Canvas.Pen.Color := HColor;
      ImageAr[row, col1].Canvas.Brush.Style := bsClear;
      ImageAr[row, col1].Canvas.Rectangle(1, 1, Groese - 1, Groese - 1);
    end;
end;

procedure THauptForm.schwer1Click(Sender: TObject);
var
  Anzahl: Integer;
  DateiName, DateiPfad: string;
begin
  DateiPfad := ExtractFilePath(ParamStr(0)) + 'SpieleDaten\HexaDoku\Schwer\';
  Anzahl := DateienZaehlen(DateiPfad);
  DateiName := IntToStr(Random(Anzahl)) + '.txt';
  if FileExists(DateiPfad + DateiName) then
  begin
    aktuelleSchwierigkeit := 'Schwer';
    Laden(DateiPfad + DateiName);
    SpielAktiv := true;
    SpielSpeichern1.Enabled := True;
    PauseAktiv := False;
    Zeit.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Ressourcen\Pause.bmp');
    aktuellesSpiel1.Enabled := True;
    Timer1.Enabled := true;
  end
  else ShowMessage('Problem beim Laden!' + sLineBreak + 'Bitte überprüfen Sie ob sich der Ordner SpieleDaten' + sLineBreak + 'im selben Ordner wie die HexaDoku.exe befindet!');
end;

procedure THauptForm.sehreinfach1Click(Sender: TObject);
var
  Anzahl: Integer;
  DateiName, DateiPfad: string;
begin
  DateiPfad := ExtractFilePath(ParamStr(0)) + 'SpieleDaten\HexaDoku\Sehr_einfach\';
  Anzahl := DateienZaehlen(DateiPfad);
  DateiName := IntToStr(Random(Anzahl)) + '.txt';
  if FileExists(DateiPfad + DateiName) then
  begin
    aktuelleSchwierigkeit := 'Sehr einfach';
    Laden(DateiPfad + DateiName);
    SpielAktiv := true;
    SpielSpeichern1.Enabled := True;
    PauseAktiv := False;
    Zeit.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Ressourcen\Pause.bmp');
    aktuellesSpiel1.Enabled := True;
    Timer1.Enabled := true;
  end
  else ShowMessage('Problem beim Laden!' + sLineBreak + 'Bitte überprüfen Sie ob sich der Ordner SpieleDaten' + sLineBreak + 'im selben Ordner wie die HexaDoku.exe befindet!');
end;

procedure THauptForm.sehrschwer1Click(Sender: TObject);
var
  Anzahl: Integer;
  DateiName, DateiPfad: string;
begin
  DateiPfad := ExtractFilePath(ParamStr(0)) + 'SpieleDaten\HexaDoku\Sehr_schwer\';
  Anzahl := DateienZaehlen(DateiPfad);
  DateiName := IntToStr(Random(Anzahl)) + '.txt';
  if FileExists(DateiPfad + DateiName) then
  begin
    aktuelleSchwierigkeit := 'Sehr schwer';
    Laden(DateiPfad + DateiName);
    SpielAktiv := true;
    SpielSpeichern1.Enabled := True;
    PauseAktiv := False;
    Zeit.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Ressourcen\Pause.bmp');
    aktuellesSpiel1.Enabled := True;
    Timer1.Enabled := true;
  end
  else ShowMessage('Problem beim Laden!' + sLineBreak + 'Bitte überprüfen Sie ob sich der Ordner SpieleDaten' + sLineBreak + 'im selben Ordner wie die HexaDoku.exe befindet!');
end;

procedure THauptForm.Laden(DateiName: string);
var
  Row, Col: Integer;
  Datei: TextFile;
  Zeile, s: string;
  BuchStabe: Char;
begin
  AssignFile(Datei, DateiName);
  Reset(Datei);
  if aktuelleSchwierigkeit = '' then
  begin
    for row := 0 to 15 do
    begin
      ReadLn(Datei, Zeile);
      for col := 0 to 15 do
      begin
        BuchStabe := Zeile[col + 1];
        if HexaToInter(Buchstabe) > 0 then VorgabenAr[row, col] := true
        else VorgabenAr[row, col] := False;
      end;
    end;
    for row := 0 to 15 do
    begin
      ReadLn(Datei, Zeile);
      for col := 0 to 15 do
      begin
        BuchStabe := Zeile[col + 1];
        virAr[row, col] := HexaToInter(Buchstabe);
      end;
    end;
  end
  else
  begin
    for row := 0 to 15 do
    begin
      ReadLn(Datei, Zeile);
      for col := 0 to 15 do
      begin
        BuchStabe := Zeile[col + 1];
        virAr[row, col] := HexaToInter(Buchstabe);
        if HexaToInter(Buchstabe) > 0 then VorgabenAr[row, col] := true
        else VorgabenAr[row, col] := False;
      end;
    end;
  end;
  ReadLn(Datei, Zeile);
  ReadLn(Datei, Zeile);
  ReadLn(Datei, Zeile);
  for row := 0 to 15 do
  begin
    ReadLn(Datei, Zeile);
    for col := 0 to 15 do
    begin
      BuchStabe := Zeile[col + 1];
      LoesungAr[row, col] := HexaToInter(Buchstabe);
    end;
  end;
  ReadLn(Datei, s);
  if s = '' then s := '0';
  aktuelleSek := StrToInt(s);
  ReadLn(Datei, aktuelleSchwierigkeit);
  CloseFile(Datei);
  SpielFeldZeichnen;
end;

procedure THauptForm.Aufgeben1Click(Sender: TObject);
begin
  if Application.MessageBox('Wollen Sie wirklich aufgeben?', 'Aufgeben?', MB_ICONQUESTION or MB_YESNO) = IDNo then Exit;
  if Application.MessageBox('Wollen Sie die Lösung sehen?', 'Lösung sehen?', MB_ICONQUESTION or MB_YESNO) = IDYES then LoesungAnzeigen;
  aktuellesSpiel1.Enabled := False;
  SpielSpeichern1.Enabled := False;
  SpielAktiv := False;
  Timer1.Enabled := False;
  PauseAktiv := True;
  MenuItemRightJustify(Zeit);
  Zeit.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Ressourcen\Start.bmp');
end;

procedure THauptForm.Beenden1Click(Sender: TObject);
begin
  Close;
end;

procedure THauptForm.berHexaDoku1Click(Sender: TObject);
begin
  ShowMessage('Dies ist ein freies und einfaches Programm was im Rahmen des' + sLineBreak + 'enstanden ist. Es soll beim Lösen von HexaDokus helfen.' + sLineBreak + 'Die HexaDokus stammen von hexadoku.de');
end;

procedure THauptForm.BlockMarkieren;
var row, col, row1, col1: Integer;
begin
  col := AKTIV div 16;
  row := AKTIV mod 16;
  for col1 := 4 * (col div 4) to 4 * (col div 4) + 3 do
    for row1 := 4 * (row div 4) to 4 * (row div 4) + 3 do
    begin
      ImageAr[row1, col1].Canvas.Pen.Color := AEColor;
      ImageAr[row1, col1].Canvas.Brush.Style := bsClear;
      ImageAr[row1, col1].Canvas.Rectangle(1, 1, Groese - 1, Groese - 1);
    end;
end;

procedure THauptForm.BlockUnMarkieren;
var row, col, row1, col1: Integer;
begin
  col := AKTIV div 16;
  row := AKTIV mod 16;
  for col1 := 4 * (col div 4) to 4 * (col div 4) + 3 do
    for row1 := 4 * (row div 4) to 4 * (row div 4) + 3 do
    begin
      ImageAr[row1, col1].Canvas.Pen.Color := HColor;
      ImageAr[row1, col1].Canvas.Brush.Style := bsClear;
      ImageAr[row1, col1].Canvas.Rectangle(1, 1, Groese - 1, Groese - 1);
    end;
end;


function THauptForm.Moegliche(const ACol, ARow: integer): TMoeglichkeiten;
var
  MoeglichKeiten: array[0..16] of boolean;
  col, row, i: integer;
begin
  SetLength(Result, 0);
  if virAr[ACol, ARow] > 0 then Exit;
  for i := 1 to 16 do MoeglichKeiten[i] := true;
  for row := 0 to 15 do
  begin
    if row = ARow then continue
    else MoeglichKeiten[virAr[ACol, row]] := false;
  end;
  for col := 0 to 15 do
  begin
    if col = ACol then continue
    else MoeglichKeiten[virAr[col, ARow]] := false;
  end;
  for col := 4 * (ACol div 4) to 4 * (ACol div 4) + 3 do
    for row := 4 * (ARow div 4) to 4 * (ARow div 4) + 3 do
      if (col = ACol) and (row = ARow)
        then continue
      else MoeglichKeiten[virAr[col, row]] := false;
  for i := 1 to 16 do
    if MoeglichKeiten[i]
      then
    begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result) - 1] := i;
    end;
end;

procedure THauptForm.Normal1Click(Sender: TObject);
var
  Anzahl: Integer;
  DateiName, DateiPfad: string;
begin
  DateiPfad := ExtractFilePath(ParamStr(0)) + 'SpieleDaten\HexaDoku\Normal\';
  Anzahl := DateienZaehlen(DateiPfad);
  DateiName := IntToStr(Random(Anzahl)) + '.txt';
  if FileExists(DateiPfad + DateiName) then
  begin
    aktuelleSchwierigkeit := 'Normal';
    Laden(DateiPfad + DateiName);
    SpielAktiv := true;
    SpielSpeichern1.Enabled := True;
    PauseAktiv := False;
    Zeit.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Ressourcen\Pause.bmp');
    aktuellesSpiel1.Enabled := True;
    Timer1.Enabled := true;
  end
  else ShowMessage('Problem beim Laden!' + sLineBreak + 'Bitte überprüfen Sie ob sich der Ordner SpieleDaten' + sLineBreak + 'im selben Ordner wie die HexaDoku.exe befindet!');
end;

procedure THauptForm.Pause1Click(Sender: TObject);
begin
  if PauseAktiv then Exit
  else Zeit.Click;
end;

function THauptForm.HexaToInter(var Wert: char): Integer;
begin
  if Wert = '-' then result := 0;
  if Wert = '0' then result := 1;
  if Wert = '1' then result := 2;
  if Wert = '2' then result := 3;
  if Wert = '3' then result := 4;
  if Wert = '4' then result := 5;
  if Wert = '5' then result := 6;
  if Wert = '6' then result := 7;
  if Wert = '7' then result := 8;
  if Wert = '8' then result := 9;
  if Wert = '9' then result := 10;
  if Wert = 'A' then result := 11;
  if Wert = 'B' then result := 12;
  if Wert = 'C' then result := 13;
  if Wert = 'D' then result := 14;
  if Wert = 'E' then result := 15;
  if Wert = 'F' then result := 16;
end;

procedure THauptForm.HighScores1Click(Sender: TObject);
begin
  HighScoresFRM.Show;
end;

procedure THauptForm.Hilfe2Click(Sender: TObject);
begin
  Application.HelpContext(1002);
end;

function THauptForm.InterToHexa(var Wert: Integer): Char;
begin
  case Wert of
    0: result := '-';
    1: result := '0';
    2: result := '1';
    3: result := '2';
    4: result := '3';
    5: result := '4';
    6: result := '5';
    7: result := '6';
    8: result := '7';
    9: result := '8';
    10: result := '9';
    11: result := 'A';
    12: result := 'B';
    13: result := 'C';
    14: result := 'D';
    15: result := 'E';
    16: result := 'F';
  end;
end;

function THauptForm.DateienZaehlen(DateiPfad: string): Integer;
var i: Integer;
begin
  i := 0;
  while FileExists(DateiPfad + IntToStr(i) + '.txt') do inc(i);
  result := i;
end;

procedure THauptForm.einfach1Click(Sender: TObject);
var
  Anzahl: Integer;
  DateiName, DateiPfad: string;
begin
  DateiPfad := ExtractFilePath(ParamStr(0)) + 'SpieleDaten\HexaDoku\Einfach\';
  Anzahl := DateienZaehlen(DateiPfad);
  DateiName := IntToStr(Random(Anzahl)) + '.txt';
  if FileExists(DateiPfad + DateiName) then
  begin
    aktuelleSchwierigkeit := 'Einfach';
    Laden(DateiPfad + DateiName);
    SpielAktiv := true;
    SpielSpeichern1.Enabled := True;
    PauseAktiv := False;
    Zeit.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Ressourcen\Pause.bmp');
    aktuellesSpiel1.Enabled := True;
    Timer1.Enabled := true;
  end
  else ShowMessage('Problem beim Laden!' + sLineBreak + 'Bitte überprüfen Sie ob sich der Ordner SpieleDaten' + sLineBreak + 'im selben Ordner wie die HexaDoku.exe befindet!');
end;

procedure THauptForm.ZeitClick(Sender: TObject);
begin
  if SpielAktiv then
  begin
    if PauseAktiv then
    begin
      PauseBild.Destroy;
      PauseAktiv := False;
      Zeit.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Ressourcen\Pause.bmp');
      Timer1.Enabled := true;
    end
    else
    begin
      PauseAktiv := True;
      Zeit.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Ressourcen\Start.bmp');
      Timer1.Enabled := false;
      PauseBild := TImage.Create(HauptForm);
      with PauseBild do
      begin
        Parent := HauptForm;
        Width := HauptForm.Width;
        Height := HauptForm.Height;
        Top := 0;
        Left := 0;
        Enabled := true;
        Visible := true;
        with Canvas do
        begin
          Brush.Color := HColor;
          Brush.Style := bssolid;
          Rectangle(0, 0, Width, Height);
          with Font do
          begin
            Size := 100;
            Color := VColor;
            Name := 'Courier New';
            Style := [fsBold];
          end;
          TextOut(Width div 5, Height div 4, 'Pause!');
          Font.Size := 30;
          TextOut(10, (Height div 3) + 110, 'Um weiter zu spielen, klicken');
          TextOut(10, (Height div 3) + 170, 'Sie oben rechts auf ihre Zeit.');
        end;
      end;
    end;
  end;
end;

function THauptForm.ZeitUmrechnen(SekundenEin: Integer): string;
var Tage, Stunden, Minuten, Sekunden: Integer;
  Tages, Stundes, Minutes, Sekundes: string;
begin
  Sekunden := SekundenEin mod 60;
  Minuten := (SekundenEin div 60) mod 60;
  Stunden := (SekundenEin div 60) div 60;
  Tage := Stunden div 24;
  Stunden := Stunden mod 24;
  if Tage > 9 then
    Tages := IntToStr(Tage)
  else
    Tages := '0' + IntToStr(Tage);
  if Stunden > 9 then
    Stundes := IntToStr(Stunden)
  else
    Stundes := '0' + IntToStr(Stunden);
  if Minuten > 9 then
    Minutes := IntToStr(Minuten)
  else
    Minutes := '0' + IntToStr(Minuten);
  if Sekunden > 9 then
    Sekundes := IntToStr(Sekunden)
  else
    Sekundes := '0' + IntToStr(Sekunden);
  result := Tages + ':' + Stundes + ':' + Minutes + ':' + Sekundes;
end;

procedure THauptForm.AppMinimize(Sender: TObject);
begin
  if PauseAktiv then Exit
  else Zeit.Click;
end;

procedure THauptForm.Fehleranzeigen1Click(Sender: TObject);
begin
  if FehlerSuchen(True) then ShowMessage('Entweder sind noch Fehler vorhanden (Fehlerfarbene Umrandungen) ' + sLineBreak + 'oder es sind noch nicht alle Felder ausgefüllt!')
  else ShowMessage('Keine Fehler vorhanden!');
end;

function THauptForm.FehlerSuchen(Zeichnen: Boolean): Boolean;
var Row, Col: Integer;
begin;
  Result := False;
  for Col := 0 to 15 do
    for Row := 0 to 15 do
    begin
      if virAr[Row, Col] = LoesungAr[Row, Col] then continue
      else
        Result := True;
      if Zeichnen then
      begin
        if virAr[Row, Col] > 0 then
        begin
          ImageAr[row, col].Canvas.Pen.Color := FColor;
          ImageAr[row, col].Canvas.Brush.Color := FColor;
          ImageAr[row, col].Canvas.Brush.Style := bsBDiagonal;
          ImageAr[row, col].Canvas.Rectangle(1, 1, Groese - 1, Groese - 1);
          ImageAr[row, col].Canvas.Rectangle(2, 2, Groese - 2, Groese - 2);
          ImageAr[row, col].Canvas.Rectangle(3, 3, Groese - 3, Groese - 3);
          ImageAr[row, col].Canvas.Rectangle(4, 4, Groese - 4, Groese - 4);
          ImageAr[row, col].Canvas.Rectangle(5, 5, Groese - 5, Groese - 5);
        end;
      end;
    end;
end;

procedure THauptForm.LoesungAnzeigen;
var Row, Col: Integer;
begin
  for Row := 0 to 15 do
    for Col := 0 to 15 do
      virAr[row, col] := LoesungAr[row, col];
  SpielfeldZeichnen;
end;

procedure THauptForm.Speichern(DateiName: string);
var
  i, j: Integer;
  Zeile: string;
  Datei: TextFile;
begin
  AssignFile(Datei, DateiName + '.txt');
  ReWrite(Datei);
  for i := 0 to 15 do
  begin
    for j := 0 to 15 do
    begin
      if VorgabenAr[i, j] then
        Zeile := Zeile + InterToHexa(virAr[i, j])
      else
        Zeile := Zeile + '-';
    end;
    WriteLn(Datei, Zeile);
    Zeile := '';
  end;
  for i := 0 to 15 do
  begin
    for j := 0 to 15 do
    begin
      Zeile := Zeile + InterToHexa(virAr[i, j]);
    end;
    WriteLn(Datei, Zeile);
    Zeile := '';
  end;
  WriteLn(Datei, '');
  WriteLn(Datei, '');
  WriteLn(Datei, '');
  for i := 0 to 15 do
  begin
    for j := 0 to 15 do
    begin
      Zeile := Zeile + InterToHexa(LoesungAr[i, j]);
    end;
    WriteLn(Datei, Zeile);
    Zeile := '';
  end;
  WriteLn(Datei, IntToStr(aktuelleSek));
  WriteLn(Datei, aktuelleSchwierigkeit);
  CloseFile(Datei);
  ShowMessage('Spiel erfolgreich gespeichert!');
end;


procedure THauptForm.Fortsetzen1Click(Sender: TObject);
begin
  if PauseAktiv then Zeit.Click;
end;


procedure THauptForm.mittel1Click(Sender: TObject);
var
  Anzahl: Integer;
  DateiName, DateiPfad: string;
begin
  DateiPfad := ExtractFilePath(ParamStr(0)) + 'SpieleDaten\HexaDoku\Mittel\';
  Anzahl := DateienZaehlen(DateiPfad);
  DateiName := IntToStr(Random(Anzahl)) + '.txt';
  if FileExists(DateiPfad + DateiName) then
  begin
    aktuelleSchwierigkeit := 'Mittel';
    Laden(DateiPfad + DateiName);
    SpielAktiv := true;
    SpielSpeichern1.Enabled := True;
    PauseAktiv := False;
    Zeit.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Ressourcen\Pause.bmp');
    aktuellesSpiel1.Enabled := True;
    Timer1.Enabled := true;
  end
  else ShowMessage('Problem beim Laden!' + sLineBreak + 'Bitte überprüfen Sie ob sich der Ordner SpieleDaten' + sLineBreak + 'im selben Ordner wie die HexaDoku.exe befindet!');
end;


//FREMDQUELLTEXT---<--------------------------------------------------

function THauptForm.MenuItemRightJustify(MenuItem: TMenuItem): Boolean;
var
  Info: TMenuItemInfo;
  MenuHandle: THandle;
  MenuIndex: Integer;
  Caption: string;
begin
  MenuHandle := MenuItem.Parent.Handle;
  MenuIndex := MenuItem.MenuIndex;
  FillChar(Info, SizeOf(Info), 0);
  Info.cbSize := SizeOf(Info);
  Info.fMask := MIIM_TYPE;
  Result := GetMenuItemInfo(MenuHandle, MenuIndex, True, Info);

  if not Result then Exit;

  SetLength(Caption, Info.cch);
  Info.dwTypeData := Pointer(Caption);
  Info.cch := Info.cch + 1;
  Result := GetMenuItemInfo(MenuHandle, MenuIndex, True, Info);

  if not Result then Exit;

  Info.fType := Info.fType or MFT_RIGHTJUSTIFY;
  Result := SetMenuItemInfo(MenuHandle, MenuIndex, True, Info);
  DrawMenuBar(Handle);
end;

function THauptForm.GetUsername: string;
var
  Buffer: array[0..255] of Char;
  Size: DWord;
begin
  Size := SizeOf(Buffer);
  if not Windows.GetUserName(Buffer, Size) then
    RaiseLastOSError; //RaiseLastWin32Error; {Bis D5};
  SetString(Result, Buffer, Size - 1);
end;
//------------------------------------------------------------------>

end.

