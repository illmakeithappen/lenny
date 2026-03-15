import '../data/stations.dart';

class GameRound {
  final Station station;
  final Set<String> guessedLineIds;

  GameRound({required this.station, required this.guessedLineIds});

  Set<String> get correctLineIds => station.lineIds;
  Set<String> get hits => guessedLineIds.intersection(correctLineIds);
  Set<String> get misses => correctLineIds.difference(guessedLineIds);
  Set<String> get wrongGuesses => guessedLineIds.difference(correctLineIds);
  bool get isPerfect => misses.isEmpty && wrongGuesses.isEmpty;

  int get score {
    int s = hits.length - wrongGuesses.length;
    if (isPerfect) s += 2;
    return s;
  }
}
