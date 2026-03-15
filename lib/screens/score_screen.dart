import 'package:flutter/material.dart';
import '../l10n/app_strings.dart';
import '../main.dart';
import '../models/game_state.dart';
import 'game_screen.dart';

class ScoreScreen extends StatelessWidget {
  final GameState gameState;

  const ScoreScreen({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    final s = LanguageScope.of(context).strings;
    final verdict = _getVerdict(s);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueGrey.shade900,
              Colors.blueGrey.shade800,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Verdict icon
                Text(
                  verdict.icon,
                  style: const TextStyle(fontSize: 48),
                ),
                const SizedBox(height: 12),

                // Verdict title
                Text(
                  verdict.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  verdict.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.6),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 24),

                // Score card
                Container(
                  constraints: const BoxConstraints(maxWidth: 360),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${gameState.totalScore}',
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w900,
                          color: Colors.blueGrey.shade800,
                        ),
                      ),
                      Text(
                        s.pointsLabel,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey.shade400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _statRow(
                        Icons.route_rounded,
                        s.roundsLabel,
                        '${gameState.totalRounds}',
                      ),
                      _statRow(
                        Icons.star_rounded,
                        s.perfectRidesLabel,
                        '${gameState.perfectRounds}',
                      ),
                      _statRow(
                        Icons.percent_rounded,
                        s.hitRateLabel,
                        '${_hitPercentage()}%',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Round breakdown
                Container(
                  constraints: const BoxConstraints(maxWidth: 360),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          s.journeyLog,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                      ...gameState.rounds.asMap().entries.map((entry) {
                        final i = entry.key;
                        final round = entry.value;
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Colors.white.withValues(alpha: 0.06),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Round number
                              SizedBox(
                                width: 28,
                                child: Text(
                                  '${i + 1}.',
                                  style: TextStyle(
                                    color:
                                        Colors.white.withValues(alpha: 0.4),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Station name
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      round.station.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      round.correctLineIds.join(', '),
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white
                                            .withValues(alpha: 0.4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Perfect badge or score
                              if (round.isPerfect)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.green.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '+${round.score}',
                                    style: const TextStyle(
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                )
                              else
                                Text(
                                  '${round.score >= 0 ? "+" : ""}${round.score}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: round.score >= 0
                                        ? Colors.white70
                                        : Colors.redAccent,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => GameScreen(
                              innerRingOnly: gameState.innerRingOnly,
                              includeUBahn: gameState.includeUBahn,
                              includeSBahn: gameState.includeSBahn,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.replay_rounded),
                      label: Text(s.playAgain),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFDA421E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).popUntil((r) => r.isFirst);
                      },
                      icon: const Icon(Icons.home_rounded),
                      label: Text(s.homeButton),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white70,
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _hitPercentage() {
    if (gameState.rounds.isEmpty) return 0;
    int totalCorrect = 0;
    int totalLines = 0;
    for (final r in gameState.rounds) {
      totalCorrect += r.hits.length;
      totalLines += r.correctLineIds.length;
    }
    if (totalLines == 0) return 0;
    return (totalCorrect * 100 / totalLines).round();
  }

  _Verdict _getVerdict(AppStrings s) {
    final pct = _hitPercentage();
    final perfect = gameState.perfectRounds;

    if (perfect == maxRounds) {
      return _Verdict(
        icon: '\u{1F682}',
        title: s.verdictPerfectTitle,
        subtitle: s.verdictPerfectSub,
      );
    } else if (pct >= 80) {
      return _Verdict(
        icon: '\u{1F683}',
        title: s.verdictGreatTitle,
        subtitle: s.verdictGreatSub,
      );
    } else if (pct >= 50) {
      return _Verdict(
        icon: '\u{1F68B}',
        title: s.verdictOkTitle,
        subtitle: s.verdictOkSub,
      );
    } else if (pct >= 25) {
      return _Verdict(
        icon: '\u{1F6A2}',
        title: s.verdictBadTitle,
        subtitle: s.verdictBadSub,
      );
    } else {
      return _Verdict(
        icon: '\u{1F6B6}',
        title: s.verdictWorstTitle,
        subtitle: s.verdictWorstSub,
      );
    }
  }

  Widget _statRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.blueGrey.shade400),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 14)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _Verdict {
  final String icon;
  final String title;
  final String subtitle;
  const _Verdict({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
