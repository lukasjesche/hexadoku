unit HighScores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, XPMan, StdCtrls, StrUtils, Buttons, jpeg, ExtCtrls;

type
  THighScoresFRM = class(TForm)
    Spee: TXPManifest;
    PageControl: TPageControl;
    SEinfachSheet: TTabSheet;
    EinfachSheet: TTabSheet;
    NormalSheet: TTabSheet;
    MittelSheet: TTabSheet;
    SchwerSheet: TTabSheet;
    SSchwerSheet: TTabSheet;
    SEinfachList: TListBox;
    Image1: TImage;
    BitBtn1: TBitBtn;
    NormalList: TListBox;
    SSchwerList: TListBox;
    SchwerList: TListBox;
    EinfachList: TListBox;
    MittelList: TListBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FuegeZumHighScoreHinzu(Name: string; Score: Integer; Trennzeichen: Char; Trennzeichenmenge: integer; Schwierigkeit: string);
    function Umrechnen(eHighItem: string): string;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HighScoresFRM: THighScoresFRM;
  HighScoreSEinfach, HighScoreEinfach, HighScoreMittel, HighScoreNormal, HighScoreSchwer, HighScoreSSchwer: TStringList;
  HighScorePfad: string;


implementation

uses NeuerHighScore;

{$R *.dfm}

procedure THighScoresFRM.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  HighScorePfad := (ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Highscore\');
  if HighScoreSEinfach.Count > 0 then HighScoreSEinfach.SaveToFile(HighScorePfad + 'SEinfach.txt');
  if HighScoreEinfach.Count > 0 then HighScoreEinfach.SaveToFile(HighScorePfad + 'Einfach.txt');
  if HighScoreMittel.Count > 0 then HighScoreMittel.SaveToFile(HighScorePfad + 'Mittel.txt');
  if HighScoreNormal.Count > 0 then HighScoreNormal.SaveToFile(HighScorePfad + 'Normal.txt');
  if HighScoreSchwer.Count > 0 then HighScoreSchwer.SaveToFile(HighScorePfad + 'Schwer.txt');
  if HighScoreSSchwer.Count > 0 then HighScoreSSchwer.SaveToFile(HighScorePfad + 'SSchwer.txt');
end;

procedure THighScoresFRM.FormCreate(Sender: TObject);
var
  e: integer;
begin
  HighScorePfad := (ExtractFilePath(ParamStr(0)) + 'SpieleDaten\Highscore\');
  HighScoreSEinfach := TStringList.Create;
  if FileExists(HighScorePfad + 'SEinfach.txt') then
  begin
    HighScoreSEinfach.LoadFromFile(HighScorePfad + 'SEinfach.txt');
    for e := 0 to HighScoreSEinfach.count - 1 do
      SEinfachList.Items.Add(IntToStr(e + 1) + '. ' + Umrechnen(HighScoreSEinfach[e]));
  end;
  HighScoreEinfach := TStringList.Create;
  if FileExists(HighScorePfad + 'Einfach.txt') then
  begin
    HighScoreEinfach.LoadFromFile(HighScorePfad + 'Einfach.txt');
    for e := 0 to HighScoreEinfach.count - 1 do
      EinfachList.Items.Add(IntToStr(e + 1) + '. ' + Umrechnen(HighScoreEinfach[e]));
  end;
  HighScoreMittel := TStringList.Create;
  if FileExists(HighScorePfad + 'Mittel.txt') then
  begin
    HighScoreMittel.LoadFromFile(HighScorePfad + 'Mittel.txt');
    for e := 0 to HighScoreMittel.count - 1 do
      MittelList.Items.Add(IntToStr(e + 1) + '. ' + Umrechnen(HighScoreMittel[e]));
  end;
  HighScoreNormal := TStringList.Create;
  if FileExists(HighScorePfad + 'Normal.txt') then
  begin
    HighScoreNormal.LoadFromFile(HighScorePfad + 'Normal.txt');
    for e := 0 to HighScoreNormal.count - 1 do
      NormalList.Items.Add(IntToStr(e + 1) + '. ' + Umrechnen(HighScoreNormal[e]));
  end;
  HighScoreSchwer := TStringList.Create;
  if FileExists(HighScorePfad + 'Schwer.txt') then
  begin
    HighScoreSchwer.LoadFromFile(HighScorePfad + 'Schwer.txt');
    for e := 0 to HighScoreSchwer.count - 1 do
      SchwerList.Items.Add(IntToStr(e + 1) + '. ' + Umrechnen(HighScoreSchwer[e]));
  end;
  HighScoreSSchwer := TStringList.Create;
  if FileExists(HighScorePfad + 'SSchwer.txt') then
  begin
    HighScoreSSchwer.LoadFromFile(HighScorePfad + 'SSchwer.txt');
    for e := 0 to HighScoreSSchwer.count - 1 do
      SSchwerList.Items.Add(IntToStr(e + 1) + '. ' + Umrechnen(HighScoreSSchwer[e]));
  end;
end;

function THighScoresFRM.Umrechnen(eHighItem: string): string;
var
  SekZahl, pe, Tage, Stunden, Minuten, Sekunden: Integer;
  Zeit: string;
begin
  pe := Pos(#32, eHighItem);
  SekZahl := StrToInt(Copy(eHighItem, 0, Pos(' ', eHighItem) - 1));
  Sekunden := SekZahl mod 60;
  Minuten := (SekZahl div 60) mod 60;
  Stunden := (SekZahl div 60) div 60;
  Tage := Stunden div 24;
  Stunden := Stunden mod 24;
  Zeit := Format('%-25s', [IntToStr(Tage) + ':' + IntToStr(Stunden) + ':' + IntToStr(Minuten) + ':' + IntToStr(Sekunden)]);
  result := Zeit + Copy(eHighItem, pe, Length(eHighItem) - pe + 1);
end;

procedure THighScoresFRM.FuegeZumHighScoreHinzu(Name: string; Score: Integer; Trennzeichen: Char; Trennzeichenmenge: integer; Schwierigkeit: string);
var
  i: integer;
  AScore: string;
begin
  if Schwierigkeit = 'Sehr einfach' then
  begin
    PageControl.TabIndex := 0;
    AScore := intToStr(Score);
    while Length(AScore) <> 9 do
    begin
      AScore := '0' + AScore;
    end;
    HighScoreSEinfach.Add(AScore + ' ' + Name);
    if HighScoreSEinfach.Count < 2 then
      SEinfachList.Items.Add('1. ' + Umrechnen(HighScoreSEinfach[0]))
    else
    begin
      HighScoreSEinfach.Sort;
      SEinfachList.Clear;
      for i := 0 to HighScoreSEinfach.count - 1 do
      begin
        SEinfachList.Items.Add(IntToStr(i + 1) + '. ' + Umrechnen(HighScoreSEinfach[i]));
      end;
    end;
  end;
  if Schwierigkeit = 'Einfach' then
  begin
    PageControl.TabIndex := 1;
    AScore := intToStr(Score);
    while Length(AScore) <> 9 do
    begin
      AScore := '0' + AScore;
    end;
    HighScoreEinfach.Add(AScore + ' ' + Name);
    if HighScoreEinfach.Count < 2 then
      EinfachList.Items.Add('1. ' + Umrechnen(HighScoreEinfach[0]))
    else
    begin
      HighScoreEinfach.Sort;
      EinfachList.Clear;
      for i := 0 to HighScoreEinfach.count - 1 do
      begin
        EinfachList.Items.Add(IntToStr(i + 1) + '. ' + Umrechnen(HighScoreEinfach[i]));
      end;
    end;
  end;
    if Schwierigkeit = 'Mittel' then
  begin
    PageControl.TabIndex := 2;
    AScore := intToStr(Score);
    while Length(AScore) <> 9 do
    begin
      AScore := '0' + AScore;
    end;
    HighScoreMittel.Add(AScore + ' ' + Name);
    if HighScoreMittel.Count < 2 then
      MittelList.Items.Add('1. ' + Umrechnen(HighScoreMittel[0]))
    else
    begin
      HighScoreMittel.Sort;
      MittelList.Clear;
      for i := 0 to HighScoreMittel.count - 1 do
      begin
        MittelList.Items.Add(IntToStr(i + 1) + '. ' + Umrechnen(HighScoreMittel[i]));
      end;
    end;
  end;
    if Schwierigkeit = 'Normal' then
  begin
    PageControl.TabIndex := 3;
    AScore := intToStr(Score);
    while Length(AScore) <> 9 do
    begin
      AScore := '0' + AScore;
    end;
    HighScoreNormal.Add(AScore + ' ' + Name);
    if HighScoreNormal.Count < 2 then
      NormalList.Items.Add('1. ' + Umrechnen(HighScoreNormal[0]))
    else
    begin
      HighScoreNormal.Sort;
      NormalList.Clear;
      for i := 0 to HighScoreNormal.count - 1 do
      begin
        NormalList.Items.Add(IntToStr(i + 1) + '. ' + Umrechnen(HighScoreNormal[i]));
      end;
    end;
  end;
    if Schwierigkeit = 'Schwer' then
  begin
    PageControl.TabIndex := 4;
    AScore := intToStr(Score);
    while Length(AScore) <> 9 do
    begin
      AScore := '0' + AScore;
    end;
    HighScoreSchwer.Add(AScore + ' ' + Name);
    if HighScoreSchwer.Count < 2 then
      SchwerList.Items.Add('1. ' + Umrechnen(HighScoreSchwer[0]))
    else
    begin
      HighScoreSchwer.Sort;
      SchwerList.Clear;
      for i := 0 to HighScoreSchwer.count - 1 do
      begin
        SchwerList.Items.Add(IntToStr(i + 1) + '. ' + Umrechnen(HighScoreSchwer[i]));
      end;
    end;
  end;
    if Schwierigkeit = 'Sehr schwer' then
  begin
    PageControl.TabIndex := 5;
    AScore := intToStr(Score);
    while Length(AScore) <> 9 do
    begin
      AScore := '0' + AScore;
    end;
    HighScoreSSchwer.Add(AScore + ' ' + Name);
    if HighScoreSSchwer.Count < 2 then
      SSchwerList.Items.Add('1. ' + Umrechnen(HighScoreSSchwer[0]))
    else
    begin
      HighScoreSSchwer.Sort;
      SSchwerList.Clear;
      for i := 0 to HighScoreSSchwer.count - 1 do
      begin
        SSchwerList.Items.Add(IntToStr(i + 1) + '. ' + Umrechnen(HighScoreSSchwer[i]));
      end;
    end;
  end;
end;
end.

