import 'lines.dart';
import 'stations.dart';

enum City { berlin, munich }

class CityData {
  final City city;
  final List<LineInfo> allLines;
  final List<Station> allStations;
  final List<Station>? innerRingStations;
  final bool hasInnerRing;

  CityData({
    required this.city,
    required this.allLines,
    required this.allStations,
    this.innerRingStations,
  }) : hasInnerRing = innerRingStations != null;

  late final List<LineInfo> uBahnLines =
      allLines.where((l) => l.type == LineType.uBahn).toList();
  late final List<LineInfo> sBahnLines =
      allLines.where((l) => l.type == LineType.sBahn).toList();
  late final Map<String, LineInfo> lineById = {
    for (final l in allLines) l.id: l,
  };
}
