unit NeuerHighScore;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TNeuerHighScoreFRM = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NeuerHighScoreFRM: TNeuerHighScoreFRM;

implementation

uses HighScores, Haupt;

{$R *.dfm}

procedure TNeuerHighScoreFRM.BitBtn1Click(Sender: TObject);
begin
  HighScoresFRM.FuegeZumHighScoreHinzu(Edit1.Text, HauptForm.aktuelleSek, #32, 5, HauptForm.aktuelleSchwierigkeit);
  HighScoresFRM.Show;
  NeuerHighScoreFRM.Close;
end;

procedure TNeuerHighScoreFRM.FormCreate(Sender: TObject);
begin
 Edit1.Text := HauptForm.GetUsername;
end;
end.
