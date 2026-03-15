import 'dart:math';
import '../data/city_data.dart';
import '../data/stations.dart';
import 'game_round.dart';

const int maxRounds = 10;

class GameState {
  final CityData cityData;
  final bool innerRingOnly;
  final bool includeUBahn;
  final bool includeSBahn;
  final List<GameRound> rounds = [];
  final List<Station> _recentStations = [];
  final Random _random = Random();

  GameState({
    required this.cityData,
    this.innerRingOnly = false,
    this.includeUBahn = true,
    this.includeSBahn = true,
  });

  Set<String> get activeLineIds => {
        if (includeUBahn) ...cityData.uBahnLines.map((l) => l.id),
        if (includeSBahn) ...cityData.sBahnLines.map((l) => l.id),
      };

  List<Station> get _pool {
    final base = (innerRingOnly && cityData.innerRingStations != null)
        ? cityData.innerRingStations!
        : cityData.allStations;
    final active = activeLineIds;
    if (active.length == cityData.allLines.length) return base;
    return base
        .map((s) => Station(
              name: s.name,
              lineIds: s.lineIds.intersection(active),
            ))
        .where((s) => s.lineIds.isNotEmpty)
        .toList();
  }

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
