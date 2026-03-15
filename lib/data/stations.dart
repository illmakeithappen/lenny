class Station {
  final String name;
  final Set<String> lineIds;
  const Station({required this.name, required this.lineIds});
}

/// Stations per line – merged into [allStations] at startup.
const _lineStations = <String, List<String>>{
  // ── U-Bahn ──────────────────────────────────────────────
  'U1': [
    'Uhlandstraße', 'Kurfürstendamm', 'Wittenbergplatz',
    'Nollendorfplatz', 'Kurfürstenstraße', 'Gleisdreieck',
    'Möckernbrücke', 'Hallesches Tor', 'Prinzenstraße',
    'Kottbusser Tor', 'Görlitzer Bahnhof', 'Schlesisches Tor',
    'Warschauer Straße',
  ],
  'U2': [
    'Ruhleben', 'Olympia-Stadion', 'Neu-Westend',
    'Theodor-Heuss-Platz', 'Kaiserdamm', 'Sophie-Charlotte-Platz',
    'Bismarckstraße', 'Deutsche Oper', 'Ernst-Reuter-Platz',
    'Zoologischer Garten', 'Wittenbergplatz', 'Nollendorfplatz',
    'Bülowstraße', 'Gleisdreieck', 'Mendelssohn-Bartholdy-Park',
    'Potsdamer Platz', 'Anton-Wilhelm-Amo-Straße', 'Stadtmitte',
    'Hausvogteiplatz', 'Spittelmarkt', 'Märkisches Museum',
    'Klosterstraße', 'Alexanderplatz', 'Rosa-Luxemburg-Platz',
    'Senefelderplatz', 'Eberswalder Straße', 'Schönhauser Allee',
    'Vinetastraße', 'Pankow',
  ],
  'U3': [
    'Krumme Lanke', 'Onkel Toms Hütte', 'Oskar-Helene-Heim',
    'Freie Universität (Thielplatz)', 'Dahlem-Dorf',
    'Podbielskiallee', 'Breitenbachplatz', 'Rüdesheimer Platz',
    'Heidelberger Platz', 'Fehrbelliner Platz', 'Hohenzollernplatz',
    'Spichernstraße', 'Augsburger Straße', 'Wittenbergplatz',
    'Nollendorfplatz', 'Kurfürstenstraße', 'Gleisdreieck',
    'Möckernbrücke', 'Hallesches Tor', 'Prinzenstraße',
    'Kottbusser Tor', 'Görlitzer Bahnhof', 'Schlesisches Tor',
    'Warschauer Straße',
  ],
  'U4': [
    'Nollendorfplatz', 'Viktoria-Luise-Platz', 'Bayerischer Platz',
    'Rathaus Schöneberg', 'Innsbrucker Platz',
  ],
  'U5': [
    'Hauptbahnhof', 'Bundestag', 'Brandenburger Tor',
    'Unter den Linden', 'Museumsinsel', 'Rotes Rathaus',
    'Alexanderplatz', 'Schillingstraße', 'Strausberger Platz',
    'Weberwiese', 'Frankfurter Tor', 'Samariterstraße',
    'Frankfurter Allee', 'Magdalenenstraße', 'Lichtenberg',
    'Friedrichsfelde', 'Tierpark', 'Biesdorf-Süd',
    'Elsterwerdaer Platz', 'Wuhletal', 'Kaulsdorf-Nord',
    'Kienberg (Gärten der Welt)', 'Cottbusser Platz', 'Hellersdorf',
    'Louis-Lewin-Straße', 'Hönow',
  ],
  'U6': [
    'Alt-Tegel', 'Borsigwerke', 'Holzhauser Straße', 'Otisstraße',
    'Scharnweberstraße', 'Kurt-Schumacher-Platz',
    'Afrikanische Straße', 'Rehberge', 'Seestraße',
    'Leopoldplatz', 'Wedding', 'Reinickendorfer Straße',
    'Schwartzkopffstraße', 'Naturkundemuseum', 'Oranienburger Tor',
    'Friedrichstraße', 'Unter den Linden', 'Stadtmitte',
    'Kochstraße', 'Hallesches Tor', 'Mehringdamm',
    'Platz der Luftbrücke', 'Paradestraße', 'Tempelhof',
    'Alt-Tempelhof', 'Kaiserin-Augusta-Straße', 'Ullsteinstraße',
    'Westphalweg', 'Alt-Mariendorf',
  ],
  'U7': [
    'Rathaus Spandau', 'Altstadt Spandau', 'Zitadelle', 'Haselhorst',
    'Paulsternstraße', 'Rohrdamm', 'Siemensdamm', 'Halemweg',
    'Jakob-Kaiser-Platz', 'Jungfernheide', 'Mierendorffplatz',
    'Richard-Wagner-Platz', 'Bismarckstraße', 'Wilmersdorfer Straße',
    'Adenauerplatz', 'Konstanzer Straße', 'Fehrbelliner Platz',
    'Blissestraße', 'Berliner Straße', 'Bayerischer Platz',
    'Eisenacher Straße', 'Kleistpark', 'Yorckstraße',
    'Möckernbrücke', 'Mehringdamm', 'Gneisenaustraße', 'Südstern',
    'Hermannplatz', 'Rathaus Neukölln', 'Karl-Marx-Straße',
    'Neukölln', 'Grenzallee', 'Blaschkoallee', 'Parchimer Allee',
    'Britz-Süd', 'Johannisthaler Chaussee', 'Lipschitzallee',
    'Wutzkyallee', 'Zwickauer Damm', 'Rudow',
  ],
  'U8': [
    'Wittenau', 'Rathaus Reinickendorf',
    'Karl-Bonhoeffer-Nervenklinik', 'Lindauer Allee',
    'Paracelsus-Bad', 'Residenzstraße', 'Franz-Neumann-Platz',
    'Osloer Straße', 'Pankstraße', 'Gesundbrunnen', 'Voltastraße',
    'Bernauer Straße', 'Rosenthaler Platz', 'Weinmeisterstraße',
    'Alexanderplatz', 'Jannowitzbrücke', 'Heinrich-Heine-Straße',
    'Moritzplatz', 'Kottbusser Tor', 'Schönleinstraße',
    'Hermannplatz', 'Boddinstraße', 'Leinestraße', 'Hermannstraße',
  ],
  'U9': [
    'Osloer Straße', 'Nauener Platz', 'Leopoldplatz',
    'Amrumer Straße', 'Westhafen', 'Birkenstraße', 'Turmstraße',
    'Hansaplatz', 'Zoologischer Garten', 'Kurfürstendamm',
    'Spichernstraße', 'Güntzelstraße', 'Berliner Straße',
    'Bundesplatz', 'Friedrich-Wilhelm-Platz',
    'Walther-Schreiber-Platz', 'Schloßstraße', 'Rathaus Steglitz',
  ],

  // ── S-Bahn ─────────────────────────────────────────────
  // Nord-Süd tunnel lines
  'S1': [
    'Oranienburg', 'Lehnitz', 'Borgsdorf', 'Birkenwerder',
    'Hohen Neuendorf', 'Frohnau', 'Hermsdorf', 'Waidmannslust',
    'Wittenau', 'Wilhelmsruh', 'Schönholz', 'Wollankstraße',
    'Bornholmer Straße', 'Gesundbrunnen', 'Humboldthain',
    'Nordbahnhof', 'Oranienburger Straße', 'Friedrichstraße',
    'Brandenburger Tor', 'Potsdamer Platz', 'Anhalter Bahnhof',
    'Yorckstraße', 'Julius-Leber-Brücke', 'Schöneberg',
    'Friedenau', 'Feuerbachstraße', 'Rathaus Steglitz',
    'Botanischer Garten', 'Lichterfelde West', 'Sundgauer Straße',
    'Zehlendorf', 'Mexikoplatz', 'Schlachtensee', 'Nikolassee',
    'Wannsee',
  ],
  'S2': [
    'Bernau', 'Bernau-Friedenstal', 'Zepernick', 'Röntgental',
    'Buch', 'Karow', 'Blankenburg', 'Pankow-Heinersdorf', 'Pankow',
    'Bornholmer Straße', 'Gesundbrunnen', 'Humboldthain',
    'Nordbahnhof', 'Oranienburger Straße', 'Friedrichstraße',
    'Brandenburger Tor', 'Potsdamer Platz', 'Anhalter Bahnhof',
    'Yorckstraße', 'Südkreuz', 'Priesterweg', 'Attilastraße',
    'Marienfelde', 'Buckower Chaussee', 'Schichauweg',
    'Lichtenrade', 'Mahlow', 'Blankenfelde',
  ],
  'S25': [
    'Hennigsdorf', 'Heiligensee', 'Schulzendorf', 'Tegel',
    'Eichborndamm', 'Karl-Bonhoeffer-Nervenklinik',
    'Alt-Reinickendorf', 'Schönholz', 'Wollankstraße',
    'Bornholmer Straße', 'Gesundbrunnen', 'Humboldthain',
    'Nordbahnhof', 'Oranienburger Straße', 'Friedrichstraße',
    'Brandenburger Tor', 'Potsdamer Platz', 'Anhalter Bahnhof',
    'Yorckstraße', 'Südkreuz', 'Priesterweg', 'Lichterfelde Ost',
    'Teltow Stadt',
  ],
  'S26': [
    'Blankenburg', 'Pankow-Heinersdorf', 'Pankow',
    'Bornholmer Straße', 'Gesundbrunnen', 'Humboldthain',
    'Nordbahnhof', 'Oranienburger Straße', 'Friedrichstraße',
    'Brandenburger Tor', 'Potsdamer Platz', 'Anhalter Bahnhof',
    'Yorckstraße', 'Südkreuz', 'Priesterweg', 'Lichterfelde Ost',
    'Teltow Stadt',
  ],

  // Stadtbahn (east-west) lines
  'S3': [
    'Spandau', 'Stresow', 'Pichelsberg', 'Olympiastadion',
    'Heerstraße', 'Messe Süd', 'Westkreuz', 'Charlottenburg',
    'Savignyplatz', 'Zoologischer Garten', 'Tiergarten', 'Bellevue',
    'Hauptbahnhof', 'Friedrichstraße', 'Hackescher Markt',
    'Alexanderplatz', 'Jannowitzbrücke', 'Ostbahnhof',
    'Warschauer Straße', 'Ostkreuz', 'Rummelsburg',
    'Betriebsbahnhof Rummelsburg', 'Karlshorst', 'Wuhlheide',
    'Köpenick', 'Hirschgarten', 'Friedrichshagen', 'Rahnsdorf',
    'Wilhelmshagen', 'Erkner',
  ],
  'S5': [
    'Westkreuz', 'Charlottenburg', 'Savignyplatz',
    'Zoologischer Garten', 'Tiergarten', 'Bellevue',
    'Hauptbahnhof', 'Friedrichstraße', 'Hackescher Markt',
    'Alexanderplatz', 'Jannowitzbrücke', 'Ostbahnhof',
    'Warschauer Straße', 'Ostkreuz', 'Nöldnerplatz', 'Lichtenberg',
    'Friedrichsfelde Ost', 'Biesdorf', 'Wuhletal', 'Kaulsdorf',
    'Mahlsdorf', 'Birkenstein', 'Hoppegarten', 'Neuenhagen',
    'Fredersdorf', 'Petershagen Nord', 'Strausberg',
    'Hegermühle', 'Strausberg Nord',
  ],
  'S7': [
    'Potsdam Hauptbahnhof', 'Babelsberg', 'Griebnitzsee', 'Wannsee',
    'Grunewald', 'Westkreuz', 'Charlottenburg', 'Savignyplatz',
    'Zoologischer Garten', 'Tiergarten', 'Bellevue',
    'Hauptbahnhof', 'Friedrichstraße', 'Hackescher Markt',
    'Alexanderplatz', 'Jannowitzbrücke', 'Ostbahnhof',
    'Warschauer Straße', 'Ostkreuz', 'Nöldnerplatz', 'Lichtenberg',
    'Friedrichsfelde Ost', 'Springpfuhl', 'Poelchaustraße',
    'Marzahn', 'Raoul-Wallenberg-Straße', 'Mehrower Allee',
    'Ahrensfelde',
  ],
  'S75': [
    'Westkreuz', 'Charlottenburg', 'Savignyplatz',
    'Zoologischer Garten', 'Tiergarten', 'Bellevue',
    'Hauptbahnhof', 'Friedrichstraße', 'Hackescher Markt',
    'Alexanderplatz', 'Jannowitzbrücke', 'Ostbahnhof',
    'Warschauer Straße', 'Ostkreuz', 'Nöldnerplatz', 'Lichtenberg',
    'Friedrichsfelde Ost', 'Springpfuhl', 'Gehrenseestraße',
    'Hohenschönhausen', 'Wartenberg',
  ],
  'S9': [
    'Spandau', 'Stresow', 'Pichelsberg', 'Olympiastadion',
    'Heerstraße', 'Messe Süd', 'Westkreuz', 'Charlottenburg',
    'Savignyplatz', 'Zoologischer Garten', 'Tiergarten', 'Bellevue',
    'Hauptbahnhof', 'Friedrichstraße', 'Hackescher Markt',
    'Alexanderplatz', 'Jannowitzbrücke', 'Ostbahnhof',
    'Warschauer Straße', 'Ostkreuz', 'Treptower Park',
    'Plänterwald', 'Baumschulenweg', 'Schöneweide', 'Johannisthal',
    'Adlershof', 'Altglienicke', 'Grünbergallee',
    'Flughafen BER Terminal 5', 'Flughafen BER',
  ],

  // Ringbahn
  'S41/S42': [
    'Gesundbrunnen', 'Greifswalder Straße', 'Landsberger Allee',
    'Storkower Straße', 'Frankfurter Allee', 'Ostkreuz',
    'Treptower Park', 'Sonnenallee', 'Neukölln', 'Hermannstraße',
    'Tempelhof', 'Südkreuz', 'Schöneberg', 'Innsbrucker Platz',
    'Bundesplatz', 'Heidelberger Platz', 'Hohenzollerndamm',
    'Halensee', 'Westkreuz', 'Messe Nord/ICC', 'Westend',
    'Jungfernheide', 'Beusselstraße', 'Westhafen', 'Wedding',
  ],

  // Southeastern branches
  'S8': [
    'Birkenwerder', 'Mühlenbeck-Mönchmühle', 'Blankenburg',
    'Pankow-Heinersdorf', 'Pankow', 'Bornholmer Straße',
    'Schönhauser Allee', 'Prenzlauer Allee', 'Greifswalder Straße',
    'Landsberger Allee', 'Storkower Straße', 'Frankfurter Allee',
    'Ostkreuz', 'Treptower Park', 'Plänterwald',
    'Baumschulenweg', 'Schöneweide', 'Johannisthal', 'Adlershof',
    'Altglienicke', 'Grünbergallee',
    'Flughafen BER Terminal 5', 'Flughafen BER',
  ],
  'S85': [
    'Grünau', 'Adlershof', 'Schöneweide', 'Baumschulenweg',
    'Plänterwald', 'Treptower Park', 'Ostkreuz',
    'Frankfurter Allee', 'Storkower Straße', 'Landsberger Allee',
    'Greifswalder Straße', 'Schönhauser Allee', 'Prenzlauer Allee',
    'Bornholmer Straße', 'Pankow', 'Pankow-Heinersdorf',
    'Blankenburg',
  ],
  'S45': [
    'Südkreuz', 'Tempelhof', 'Hermannstraße', 'Neukölln',
    'Köllnische Heide', 'Baumschulenweg', 'Schöneweide',
    'Johannisthal', 'Adlershof', 'Altglienicke', 'Grünbergallee',
    'Flughafen BER Terminal 5', 'Flughafen BER',
  ],
  'S46': [
    'Westend', 'Messe Nord/ICC', 'Westkreuz', 'Halensee',
    'Hohenzollerndamm', 'Heidelberger Platz', 'Bundesplatz',
    'Innsbrucker Platz', 'Schöneberg', 'Südkreuz', 'Tempelhof',
    'Hermannstraße', 'Neukölln', 'Köllnische Heide',
    'Baumschulenweg', 'Schöneweide', 'Oberspree',
    'Spindlersfeld', 'Niederschöneweide', 'Adlershof',
    'Grünau', 'Eichwalde', 'Zeuthen', 'Wildau',
    'Königs Wusterhausen',
  ],
  'S47': [
    'Südkreuz', 'Tempelhof', 'Hermannstraße', 'Neukölln',
    'Köllnische Heide', 'Baumschulenweg', 'Schöneweide',
    'Oberspree', 'Spindlersfeld',
  ],
};

/// Stations on or inside the Ringbahn (S41/S42).
const _innerRingNames = <String>{
  // ── Ringbahn stations themselves ──
  'Gesundbrunnen', 'Greifswalder Straße', 'Landsberger Allee',
  'Storkower Straße', 'Frankfurter Allee', 'Ostkreuz',
  'Treptower Park', 'Sonnenallee', 'Neukölln', 'Hermannstraße',
  'Tempelhof', 'Südkreuz', 'Schöneberg', 'Innsbrucker Platz',
  'Bundesplatz', 'Heidelberger Platz', 'Hohenzollerndamm',
  'Halensee', 'Westkreuz', 'Messe Nord/ICC', 'Westend',
  'Jungfernheide', 'Beusselstraße', 'Westhafen', 'Wedding',

  // ── U1 (all inside) ──
  'Uhlandstraße', 'Kurfürstendamm', 'Wittenbergplatz',
  'Nollendorfplatz', 'Kurfürstenstraße', 'Gleisdreieck',
  'Möckernbrücke', 'Hallesches Tor', 'Prinzenstraße',
  'Kottbusser Tor', 'Görlitzer Bahnhof', 'Schlesisches Tor',
  'Warschauer Straße',

  // ── U2 (inside section) ──
  'Bismarckstraße', 'Deutsche Oper', 'Ernst-Reuter-Platz',
  'Zoologischer Garten', 'Bülowstraße',
  'Mendelssohn-Bartholdy-Park', 'Potsdamer Platz',
  'Anton-Wilhelm-Amo-Straße', 'Stadtmitte', 'Hausvogteiplatz',
  'Spittelmarkt', 'Märkisches Museum', 'Klosterstraße',
  'Alexanderplatz', 'Rosa-Luxemburg-Platz', 'Senefelderplatz',
  'Eberswalder Straße',

  // ── U3 (inside section, from Heidelberger Platz east) ──
  'Fehrbelliner Platz', 'Hohenzollernplatz', 'Spichernstraße',
  'Augsburger Straße',

  // ── U4 (all inside) ──
  'Viktoria-Luise-Platz', 'Bayerischer Platz', 'Rathaus Schöneberg',

  // ── U5 (inside section, Hauptbahnhof to Frankfurter Allee) ──
  'Hauptbahnhof', 'Bundestag', 'Brandenburger Tor',
  'Unter den Linden', 'Museumsinsel', 'Rotes Rathaus',
  'Schillingstraße', 'Strausberger Platz', 'Weberwiese',
  'Frankfurter Tor', 'Samariterstraße',

  // ── U6 (inside section, Wedding to Tempelhof) ──
  'Reinickendorfer Straße', 'Schwartzkopffstraße',
  'Naturkundemuseum', 'Oranienburger Tor', 'Friedrichstraße',
  'Kochstraße', 'Mehringdamm', 'Platz der Luftbrücke', 'Paradestraße',

  // ── U7 (inside section, Jungfernheide to Neukölln) ──
  'Mierendorffplatz', 'Richard-Wagner-Platz', 'Wilmersdorfer Straße',
  'Adenauerplatz', 'Konstanzer Straße', 'Blissestraße',
  'Berliner Straße', 'Eisenacher Straße', 'Kleistpark',
  'Yorckstraße', 'Gneisenaustraße', 'Südstern', 'Hermannplatz',
  'Rathaus Neukölln', 'Karl-Marx-Straße',

  // ── U8 (inside section, Gesundbrunnen to Hermannstraße) ──
  'Voltastraße', 'Bernauer Straße', 'Rosenthaler Platz',
  'Weinmeisterstraße', 'Jannowitzbrücke', 'Heinrich-Heine-Straße',
  'Moritzplatz', 'Schönleinstraße', 'Boddinstraße', 'Leinestraße',

  // ── U9 (inside section, Westhafen to Bundesplatz) ──
  'Birkenstraße', 'Turmstraße', 'Hansaplatz', 'Güntzelstraße',

  // ── S-Bahn Stadtbahn (inside, Westkreuz–Ostkreuz exclusive) ──
  'Charlottenburg', 'Savignyplatz', 'Tiergarten', 'Bellevue',
  'Hackescher Markt', 'Ostbahnhof',

  // ── S-Bahn Nord-Süd tunnel (inside) ──
  'Humboldthain', 'Nordbahnhof', 'Oranienburger Straße',
  'Anhalter Bahnhof', 'Julius-Leber-Brücke',
};

/// All unique stations with their combined line sets, sorted by name.
final List<Station> allStations = _buildStations();

/// Only stations on or inside the Ringbahn.
final List<Station> innerRingStations =
    allStations.where((s) => _innerRingNames.contains(s.name)).toList();

List<Station> _buildStations() {
  final map = <String, Set<String>>{};
  for (final entry in _lineStations.entries) {
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
