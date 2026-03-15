import 'dart:math';
import '../data/stations.dart';
import 'game_round.dart';

const int maxRounds = 10;

class GameState {
  final bool innerRingOnly;
  final List<GameRound> rounds = [];
  final List<Station> _recentStations = [];
  final Random _random = Random();

  GameState({this.innerRingOnly = false});

  List<Station> get _pool =>
      innerRingOnly ? innerRingStations : allStations;

  int get totalScore => rounds.fold(0, (sum, r) => sum + r.score);
  int get perfectRounds => rounds.where((r) => r.isPerfect).length;
  int get totalRounds => rounds.length;
  bool get isFinished => totalRounds >= maxRounds;
  int get currentRound => totalRounds + 1;

  /// Maximum possible score: every line correct + perfect bonus each round.
  int get maxPossibleScore {
    return rounds.fold(0, (sum, r) => sum + r.station.lineIds.length + 2);
  }

  Station nextStation() {
    final candidates =
        _pool.where((s) => !_recentStations.contains(s)).toList();
    final station = candidates[_random.nextInt(candidates.length)];
    _recentStations.add(station);
    if (_recentStations.length > 20) {
      _recentStations.removeAt(0);
    }
    return station;
  }

  void addRound(GameRound round) {
    rounds.add(round);
  }
}
