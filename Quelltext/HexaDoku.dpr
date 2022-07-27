program HexaDoku;

uses
  Forms,
  Haupt in 'Haupt.pas' {HauptForm},
  Einstellungen in 'Einstellungen.pas' {EinstellungensFRM},
  HighScores in 'HighScores.pas' {HighScoresFRM},
  NeuerHighScore in 'NeuerHighScore.pas' {NeuerHighScoreFRM};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'HexaDoku - Das Spiel!';
  Application.CreateForm(THauptForm, HauptForm);
  Application.CreateForm(TEinstellungensFRM, EinstellungensFRM);
  Application.CreateForm(THighScoresFRM, HighScoresFRM);
  Application.CreateForm(TNeuerHighScoreFRM, NeuerHighScoreFRM);
  Application.Run;
end.
