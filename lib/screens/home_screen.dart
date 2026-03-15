import 'package:flutter/material.dart';
import '../data/lines.dart';
import '../data/stations.dart';
import '../l10n/app_strings.dart';
import '../main.dart';
import '../models/game_state.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _innerRingOnly = false;
  bool _includeUBahn = true;
  bool _includeSBahn = true;

  int get _stationCount {
    final base = _innerRingOnly ? innerRingStations : allStations;
    if (_includeUBahn && _includeSBahn) return base.length;
    final activeLineIds = <String>{
      if (_includeUBahn) ...uBahnLines.map((l) => l.id),
      if (_includeSBahn) ...sBahnLines.map((l) => l.id),
    };
    return base
        .where((s) => s.lineIds.intersection(activeLineIds).isNotEmpty)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    final stationCount = _stationCount;
    final scope = LanguageScope.of(context);
    final s = scope.strings;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueGrey.shade900,
              Colors.blueGrey.shade800,
              Colors.blueGrey.shade700,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Language toggle
                  _buildLanguageToggle(scope),
                  const SizedBox(height: 24),
                  // Steam train ASCII art
                  Text(
                    '    __  __\n'
                    ' __|  ||  |__\n'
                    '|  ________  |\n'
                    '|_|  (  )  |_|\n'
                    '  |________|  \n'
                    '   o  o  o  o ',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.6),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Title
                  const Text(
                    'TRAINSPOTS',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 6,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      s.subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        letterSpacing: 4,
                        color: Colors.white70,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Mode toggle card
                  Container(
                    constraints: const BoxConstraints(maxWidth: 360),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.train,
                              color: Colors.white.withValues(alpha: 0.7),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              s.areaLabel,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Toggle buttons
                        Row(
                          children: [
                            Expanded(
                              child: _modeButton(
                                label: s.ringbahn,
                                subtitle: s.ringbahnSub,
                                icon: Icons.circle_outlined,
                                isSelected: _innerRingOnly,
                                onTap: () =>
                                    setState(() => _innerRingOnly = true),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _modeButton(
                                label: s.fullNetwork,
                                subtitle: s.fullNetworkSub,
                                icon: Icons.public,
                                isSelected: !_innerRingOnly,
                                onTap: () =>
                                    setState(() => _innerRingOnly = false),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Line type filter card
                  Container(
                    constraints: const BoxConstraints(maxWidth: 360),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.filter_alt_rounded,
                              color: Colors.white.withValues(alpha: 0.7),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              s.lineTypeLabel,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _toggleButton(
                                label: 'U-Bahn',
                                icon: Icons.directions_subway_rounded,
                                isSelected: _includeUBahn,
                                onTap: () {
                                  if (_includeUBahn && !_includeSBahn) return;
                                  setState(() =>
                                      _includeUBahn = !_includeUBahn);
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _toggleButton(
                                label: 'S-Bahn',
                                icon: Icons.directions_railway_rounded,
                                isSelected: _includeSBahn,
                                onTap: () {
                                  if (_includeSBahn && !_includeUBahn) return;
                                  setState(() =>
                                      _includeSBahn = !_includeSBahn);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          s.stationsAndRounds(stationCount, maxRounds),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Start button
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => GameScreen(
                            innerRingOnly: _innerRingOnly,
                            includeUBahn: _includeUBahn,
                            includeSBahn: _includeSBahn,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_arrow_rounded, size: 28),
                    label: Text(
                      s.startButton,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFDA421E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Bottom flavor text
                  Text(
                    s.flavorText,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.25),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageToggle(LanguageScope scope) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _langChip('DE', AppLanguage.de, scope),
        const SizedBox(width: 8),
        _langChip('EN', AppLanguage.en, scope),
      ],
    );
  }

  Widget _langChip(String label, AppLanguage lang, LanguageScope scope) {
    final isSelected = scope.language == lang;
    return GestureDetector(
      onTap: () => scope.onLanguageChanged(lang),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.15),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white38,
            fontWeight: FontWeight.bold,
            fontSize: 13,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _toggleButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: isSelected ? Colors.white : Colors.white38,
              size: 20,
            ),
            const SizedBox(width: 8),
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white54,
              size: 22,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white54,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modeButton({
    required String label,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white54,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white54,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.6)
                    : Colors.white38,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
