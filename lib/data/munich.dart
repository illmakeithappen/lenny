import 'package:flutter/material.dart';
import 'city_data.dart';
import 'lines.dart';
import 'stations.dart';

// ─── Munich Lines ───────────────────────────────────────────

const munichLines = <LineInfo>[
  // U-Bahn
  LineInfo(id: 'U1', type: LineType.uBahn, color: Color(0xFF438136)),
  LineInfo(id: 'U2', type: LineType.uBahn, color: Color(0xFFC4003C)),
  LineInfo(id: 'U3', type: LineType.uBahn, color: Color(0xFFED6720)),
  LineInfo(id: 'U4', type: LineType.uBahn, color: Color(0xFF04AF6E)),
  LineInfo(id: 'U5', type: LineType.uBahn, color: Color(0xFFBC7A00)),
  LineInfo(id: 'U6', type: LineType.uBahn, color: Color(0xFF0065AE)),
  LineInfo(id: 'U7', type: LineType.uBahn, color: Color(0xFF9C1D51)),
  LineInfo(id: 'U8', type: LineType.uBahn, color: Color(0xFFED6752)),
  // S-Bahn
  LineInfo(id: 'S1', type: LineType.sBahn, color: Color(0xFF00CBEE)),
  LineInfo(id: 'S2', type: LineType.sBahn, color: Color(0xFF71BF44)),
  LineInfo(id: 'S3', type: LineType.sBahn, color: Color(0xFF862996)),
  LineInfo(id: 'S4', type: LineType.sBahn, color: Color(0xFFD4022A)),
  LineInfo(id: 'S6', type: LineType.sBahn, color: Color(0xFF00975F)),
  LineInfo(id: 'S7', type: LineType.sBahn, color: Color(0xFF8B3533)),
  LineInfo(id: 'S8', type: LineType.sBahn, color: Color(0xFFF6A804)),
];

// ─── Munich Stations ────────────────────────────────────────

const _munichLineStations = <String, List<String>>{
  'U1': [
    'Olympia-Einkaufszentrum', 'Georg-Brauchle-Ring', 'Westfriedhof',
    'Gern', 'Rotkreuzplatz', 'Maillingerstraße', 'Stiglmaierplatz',
    'Hauptbahnhof', 'Sendlinger Tor', 'Fraunhoferstraße',
    'Kolumbusplatz', 'Candidplatz', 'Wettersteinplatz',
    'Mangfallplatz',
  ],
  'U2': [
    'Feldmoching', 'Hasenbergl', 'Dülferstraße',
    'Harthof', 'Am Hart', 'Frankfurter Ring',
    'Milbertshofen', 'Scheidplatz', 'Hohenzollernplatz',
    'Josephsplatz', 'Theresienstraße', 'Königsplatz',
    'Hauptbahnhof', 'Sendlinger Tor', 'Fraunhoferstraße',
    'Kolumbusplatz', 'Silberhornstraße', 'Untersbergstraße',
    'Giesing', 'Karl-Preis-Platz', 'Innsbrucker Ring',
    'Josephsburg', 'Kreillerstraße', 'Trudering',
    'Moosfeld', 'Messestadt West', 'Messestadt Ost',
  ],
  'U3': [
    'Moosach', 'Olympia-Einkaufszentrum', 'Oberwiesenfeld',
    'Olympiazentrum', 'Petuelring', 'Scheidplatz',
    'Bonner Platz', 'Münchner Freiheit', 'Giselastraße',
    'Universität', 'Odeonsplatz', 'Marienplatz',
    'Sendlinger Tor', 'Goetheplatz', 'Poccistraße',
    'Implerstraße', 'Brudermühlstraße', 'Thalkirchen',
    'Obersendling', 'Aidenbachstraße', 'Machtlfinger Straße',
    'Forstenrieder Allee', 'Basler Straße', 'Fürstenried West',
  ],
  'U4': [
    'Westendstraße', 'Theresienwiese', 'Hauptbahnhof',
    'Karlsplatz (Stachus)', 'Odeonsplatz', 'Lehel',
    'Max-Weber-Platz', 'Prinzregentenplatz', 'Böhmerwaldplatz',
    'Richard-Strauss-Straße', 'Arabellapark',
  ],
  'U5': [
    'Laimer Platz', 'Friedenheimer Straße', 'Westendstraße',
    'Theresienwiese', 'Hauptbahnhof', 'Karlsplatz (Stachus)',
    'Odeonsplatz', 'Lehel', 'Max-Weber-Platz',
    'Ostbahnhof', 'Innsbrucker Ring', 'Michaelibad',
    'Quiddestraße', 'Neuperlach Süd',
  ],
  'U6': [
    'Garching-Forschungszentrum', 'Garching', 'Garching-Hochbrück',
    'Fröttmaning', 'Kieferngarten', 'Freimann',
    'Studentenstadt', 'Alte Heide', 'Nordfriedhof',
    'Dietlindenstraße', 'Münchner Freiheit', 'Giselastraße',
    'Universität', 'Odeonsplatz', 'Marienplatz',
    'Sendlinger Tor', 'Goetheplatz', 'Poccistraße',
    'Implerstraße', 'Harras', 'Partnachplatz',
    'Westpark', 'Holzapfelkreuth', 'Haderner Stern',
    'Großhadern', 'Klinikum Großhadern',
  ],
  'U7': [
    'Olympia-Einkaufszentrum', 'Georg-Brauchle-Ring', 'Westfriedhof',
    'Gern', 'Rotkreuzplatz', 'Maillingerstraße', 'Stiglmaierplatz',
    'Hauptbahnhof', 'Sendlinger Tor', 'Fraunhoferstraße',
    'Kolumbusplatz', 'Silberhornstraße', 'Untersbergstraße',
    'Giesing', 'Karl-Preis-Platz', 'Innsbrucker Ring',
    'Josephsburg', 'Kreillerstraße', 'Trudering',
    'Moosfeld', 'Messestadt West', 'Messestadt Ost',
  ],
  'U8': [
    'Olympiazentrum', 'Petuelring', 'Scheidplatz',
    'Hohenzollernplatz', 'Josephsplatz', 'Theresienstraße',
    'Königsplatz', 'Hauptbahnhof', 'Sendlinger Tor',
    'Fraunhoferstraße', 'Kolumbusplatz', 'Silberhornstraße',
    'Untersbergstraße', 'Giesing', 'Karl-Preis-Platz',
    'Innsbrucker Ring', 'Michaelibad', 'Quiddestraße',
    'Neuperlach Zentrum',
  ],
  // ── S-Bahn ──────────────────────────────────────────────
  'S1': [
    'Freising', 'Pulling', 'Neufahrn', 'Hallbergmoos',
    'Flughafen München',
    'Eching', 'Lohhof', 'Unterschleißheim', 'Oberschleißheim',
    'Feldmoching', 'Fasanerie', 'Moosach',
    'Laim', 'Hirschgarten', 'Donnersbergerbrücke',
    'Hackerbrücke', 'Hauptbahnhof', 'Karlsplatz (Stachus)',
    'Marienplatz', 'Isartor', 'Rosenheimer Platz', 'Ostbahnhof',
    'Leuchtenbergring',
  ],
  'S2': [
    'Petershausen', 'Vierkirchen-Esterhofen', 'Röhrmoos',
    'Hebertshausen', 'Dachau', 'Dachau Stadt',
    'Karlsfeld', 'Allach', 'Obermenzing',
    'Laim', 'Hirschgarten', 'Donnersbergerbrücke',
    'Hackerbrücke', 'Hauptbahnhof', 'Karlsplatz (Stachus)',
    'Marienplatz', 'Isartor', 'Rosenheimer Platz', 'Ostbahnhof',
    'Leuchtenbergring', 'Berg am Laim',
    'Riem', 'Feldkirchen', 'Heimstetten',
    'Grub', 'Poing', 'Markt Schwaben',
    'Erding',
  ],
  'S3': [
    'Mammendorf', 'Malching', 'Maisach', 'Gernlinden',
    'Esting', 'Olching', 'Gröbenzell', 'Lochhausen',
    'Langwied', 'Pasing', 'Laim', 'Hirschgarten',
    'Donnersbergerbrücke', 'Hackerbrücke', 'Hauptbahnhof',
    'Karlsplatz (Stachus)', 'Marienplatz', 'Isartor',
    'Rosenheimer Platz', 'Ostbahnhof',
    'St.-Martin-Straße', 'Giesing', 'Fasangarten',
    'Fasanenpark', 'Unterhaching', 'Taufkirchen',
    'Furth', 'Deisenhofen', 'Sauerlach',
    'Otterfing', 'Holzkirchen',
  ],
  'S4': [
    'Geltendorf', 'Türkenfeld', 'Grafrath', 'Schöngeising',
    'Buchenau', 'Fürstenfeldbruck', 'Eichenau', 'Puchheim',
    'Aubing', 'Pasing',
    'Laim', 'Hirschgarten', 'Donnersbergerbrücke',
    'Hackerbrücke', 'Hauptbahnhof', 'Karlsplatz (Stachus)',
    'Marienplatz', 'Isartor', 'Rosenheimer Platz', 'Ostbahnhof',
    'Leuchtenbergring', 'Berg am Laim',
    'Trudering', 'Gronsdorf', 'Haar',
    'Vaterstetten', 'Baldham', 'Zorneding',
    'Eglharting', 'Kirchseeon', 'Grafing Bahnhof', 'Grafing Stadt',
    'Ebersberg',
  ],
  'S6': [
    'Tutzing', 'Feldafing', 'Possenhofen', 'Starnberg',
    'Starnberg Nord', 'Gauting', 'Stockdorf', 'Planegg',
    'Gräfelfing', 'Lochham', 'Westkreuz', 'Pasing',
    'Laim', 'Hirschgarten', 'Donnersbergerbrücke',
    'Hackerbrücke', 'Hauptbahnhof', 'Karlsplatz (Stachus)',
    'Marienplatz', 'Isartor', 'Rosenheimer Platz', 'Ostbahnhof',
    'Leuchtenbergring', 'Berg am Laim',
    'Trudering', 'Gronsdorf', 'Haar',
    'Vaterstetten', 'Baldham', 'Zorneding',
    'Eglharting',
  ],
  'S7': [
    'Wolfratshausen', 'Icking', 'Ebenhausen-Schäftlarn',
    'Hohenschäftlarn', 'Baierbrunn', 'Buchenhain',
    'Solln', 'Siemenswerke', 'Mittersendling',
    'Harras', 'Heimeranplatz', 'Donnersbergerbrücke',
    'Hackerbrücke', 'Hauptbahnhof', 'Karlsplatz (Stachus)',
    'Marienplatz', 'Isartor', 'Rosenheimer Platz', 'Ostbahnhof',
    'St.-Martin-Straße', 'Giesing', 'Perlach',
    'Neuperlach Süd', 'Neubiberg', 'Ottobrunn',
    'Hohenbrunn', 'Höhenkirchen-Siegertsbrunn',
    'Dürrnhaar', 'Aying', 'Peiß', 'Großhelfendorf',
    'Kreuzstraße',
  ],
  'S8': [
    'Herrsching', 'Seefeld-Hechendorf', 'Steinebach',
    'Weßling', 'Neugilching', 'Gilching-Argelsried',
    'Germering-Unterpfaffenhofen', 'Harthaus', 'Freiham',
    'Neuaubing', 'Westkreuz', 'Pasing',
    'Laim', 'Hirschgarten', 'Donnersbergerbrücke',
    'Hackerbrücke', 'Hauptbahnhof', 'Karlsplatz (Stachus)',
    'Marienplatz', 'Isartor', 'Rosenheimer Platz', 'Ostbahnhof',
    'Leuchtenbergring', 'Berg am Laim',
    'Daglfing', 'Englschalking', 'Johanneskirchen',
    'Unterföhring', 'Ismaning', 'Hallbergmoos',
    'Flughafen München',
  ],
};

/// Build Munich stations from line data.
List<Station> _buildMunichStations() {
  final map = <String, Set<String>>{};
  for (final entry in _munichLineStations.entries) {
    for (final stationName in entry.value) {
      map.putIfAbsent(stationName, () => <String>{}).add(entry.key);
    }
  }
  final stations = map.entries
      .map((e) => Station(name: e.key, lineIds: e.value))
      .toList()
    ..sort((a, b) => a.name.compareTo(b.name));
  return stations;
}

final List<Station> munichAllStations = _buildMunichStations();

final CityData munichData = CityData(
  city: City.munich,
  allLines: munichLines,
  allStations: munichAllStations,
);
