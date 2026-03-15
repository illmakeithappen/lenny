enum AppLanguage { de, en }

class AppStrings {
  final AppLanguage language;
  const AppStrings(this.language);

  // ── Home Screen ──
  String get subtitle =>
      language == AppLanguage.de ? 'BERLINER LINIENRATEN' : 'BERLIN LINE QUIZ';
  String get areaLabel =>
      language == AppLanguage.de ? 'Streckengebiet' : 'Area';
  String get ringbahn => 'Ringbahn';
  String get ringbahnSub =>
      language == AppLanguage.de ? 'Innerer Ring' : 'Inner Ring';
  String get fullNetwork =>
      language == AppLanguage.de ? 'Gesamtnetz' : 'Full Network';
  String get fullNetworkSub =>
      language == AppLanguage.de ? 'Alle Stationen' : 'All Stations';
  String get lineTypeLabel =>
      language == AppLanguage.de ? 'Linientyp' : 'Line Type';
  String stationsAndRounds(int stations, int rounds) =>
      language == AppLanguage.de
          ? '$stations Stationen  ·  $rounds Runden'
          : '$stations Stations  ·  $rounds Rounds';
  String get startButton =>
      language == AppLanguage.de ? 'Losfahren!' : 'Depart!';
  String get flavorText => 'Tsch tsch tsch ...';

  // ── Game Screen ──
  String get endButton =>
      language == AppLanguage.de ? 'Beenden' : 'End';
  String get whichLinesStop => language == AppLanguage.de
      ? 'Welche Linien halten an'
      : 'Which lines stop at';
  String lineCount(int n) => language == AppLanguage.de
      ? '$n ${n == 1 ? "Linie" : "Linien"}'
      : '$n ${n == 1 ? "Line" : "Lines"}';
  String get checkAnswer =>
      language == AppLanguage.de ? 'Antwort pruefen' : 'Check Answer';
  String get continueButton =>
      language == AppLanguage.de ? 'Weiterfahren' : 'Continue';
  String get lastStop =>
      language == AppLanguage.de ? 'Endstation!' : 'Last Stop!';
  String get perfectRide =>
      language == AppLanguage.de ? 'Perfekte Fahrt!' : 'Perfect Ride!';
  String points(int score) => language == AppLanguage.de
      ? '${score >= 0 ? "+" : ""}$score Punkte'
      : '${score >= 0 ? "+" : ""}$score Points';
  String get correct =>
      language == AppLanguage.de ? 'Richtig' : 'Correct';
  String get wrong =>
      language == AppLanguage.de ? 'Falsch' : 'Wrong';
  String get missed =>
      language == AppLanguage.de ? 'Vergessen' : 'Missed';

  // ── Score Screen ──
  String get pointsLabel =>
      language == AppLanguage.de ? 'Punkte' : 'Points';
  String get roundsLabel =>
      language == AppLanguage.de ? 'Runden' : 'Rounds';
  String get perfectRidesLabel =>
      language == AppLanguage.de ? 'Perfekte Fahrten' : 'Perfect Rides';
  String get hitRateLabel =>
      language == AppLanguage.de ? 'Trefferquote' : 'Hit Rate';
  String get journeyLog =>
      language == AppLanguage.de ? 'Fahrtverlauf' : 'Journey Log';
  String get playAgain =>
      language == AppLanguage.de ? 'Nochmal' : 'Again';
  String get homeButton =>
      language == AppLanguage.de ? 'Depot' : 'Home';

  // ── Verdicts ──
  String get verdictPerfectTitle =>
      language == AppLanguage.de ? 'Lokfuehrer!' : 'Train Driver!';
  String get verdictPerfectSub => language == AppLanguage.de
      ? 'Alle Runden perfekt. Du kennst das Netz wie deine Westentasche.'
      : 'All rounds perfect. You know the network like the back of your hand.';
  String get verdictGreatTitle =>
      language == AppLanguage.de ? 'Stammfahrgast' : 'Regular Rider';
  String get verdictGreatSub => language == AppLanguage.de
      ? 'Starke Leistung! Du findest dich bestens zurecht.'
      : 'Strong performance! You know your way around.';
  String get verdictOkTitle =>
      language == AppLanguage.de ? 'Gelegenheitsfahrer' : 'Casual Rider';
  String get verdictOkSub => language == AppLanguage.de
      ? 'Nicht schlecht, aber da geht noch mehr.'
      : 'Not bad, but there\'s room for improvement.';
  String get verdictBadTitle =>
      language == AppLanguage.de ? 'Schiffbruch' : 'Shipwreck';
  String get verdictBadSub => language == AppLanguage.de
      ? 'Du bist wohl eher mit dem Boot unterwegs ...'
      : 'You\'re probably more of a boat person ...';
  String get verdictWorstTitle =>
      language == AppLanguage.de ? 'Fussgaenger' : 'Pedestrian';
  String get verdictWorstSub => language == AppLanguage.de
      ? 'Vielleicht erstmal den Netzplan studieren?'
      : 'Maybe study the network map first?';
}
