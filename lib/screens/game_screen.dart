import 'package:flutter/material.dart';
import '../data/city_data.dart';
import '../data/lines.dart';
import '../data/stations.dart';
import '../main.dart';
import '../models/game_round.dart';
import '../models/game_state.dart';
import '../widgets/line_button.dart';
import '../widgets/line_grid.dart';
import '../widgets/station_display.dart';
import 'score_screen.dart';

class GameScreen extends StatefulWidget {
  final CityData cityData;
  final bool innerRingOnly;
  final bool includeUBahn;
  final bool includeSBahn;

  const GameScreen({
    super.key,
    required this.cityData,
    this.innerRingOnly = false,
    this.includeUBahn = true,
    this.includeSBahn = true,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final GameState _gameState;
  late Station _currentStation;
  final Set<String> _selectedLines = {};
  bool _showingResult = false;
  GameRound? _lastRound;

  @override
  void initState() {
    super.initState();
    _gameState = GameState(
      cityData: widget.cityData,
      innerRingOnly: widget.innerRingOnly,
      includeUBahn: widget.includeUBahn,
      includeSBahn: widget.includeSBahn,
    );
    _currentStation = _gameState.nextStation();
  }

  void _toggleLine(String lineId) {
    if (_showingResult) return;
    setState(() {
      if (_selectedLines.contains(lineId)) {
        _selectedLines.remove(lineId);
      } else {
        _selectedLines.add(lineId);
      }
    });
  }

  void _submitAnswer() {
    final round = GameRound(
      station: _currentStation,
      guessedLineIds: Set.from(_selectedLines),
    );
    _gameState.addRound(round);
    setState(() {
      _showingResult = true;
      _lastRound = round;
    });
  }

  void _nextStation() {
    if (_gameState.isFinished) {
      _endGame();
      return;
    }
    setState(() {
      _currentStation = _gameState.nextStation();
      _selectedLines.clear();
      _showingResult = false;
      _lastRound = null;
    });
  }

  void _endGame() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ScoreScreen(gameState: _gameState),
      ),
    );
  }

  Map<String, LineButtonState> _buildButtonStates() {
    if (!_showingResult || _lastRound == null) return {};
    final round = _lastRound!;
    final states = <String, LineButtonState>{};
    for (final line in widget.cityData.allLines) {
      if (round.hits.contains(line.id)) {
        states[line.id] = LineButtonState.hit;
      } else if (round.wrongGuesses.contains(line.id)) {
        states[line.id] = LineButtonState.wrong;
      } else if (round.misses.contains(line.id)) {
        states[line.id] = LineButtonState.missed;
      }
    }
    return states;
  }

  @override
  Widget build(BuildContext context) {
    final s = LanguageScope.of(context).strings;
    final roundDisplay = _showingResult
        ? _gameState.totalRounds
        : _gameState.currentRound;
    final isLastRound = _gameState.isFinished;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey.shade800,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            // Round progress
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$roundDisplay/$maxRounds',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Score
            Row(
              children: [
                Icon(
                  Icons.star_rounded,
                  size: 18,
                  color: Colors.amber.shade300,
                ),
                const SizedBox(width: 4),
                Text(
                  '${_gameState.totalScore}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (widget.innerRingOnly)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Ring',
                  style: TextStyle(fontSize: 11, color: Colors.white70),
                ),
              ),
            if (!widget.includeUBahn || !widget.includeSBahn)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    widget.includeUBahn ? 'U' : 'S',
                    style: const TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _endGame,
            icon: const Icon(Icons.close),
            tooltip: s.endButton,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Round progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: roundDisplay / maxRounds,
                  minHeight: 4,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blueGrey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              StationDisplay(station: _currentStation),
              const SizedBox(height: 20),
              LineGrid(
                cityData: widget.cityData,
                selectedLines: _selectedLines,
                buttonStates: _buildButtonStates(),
                onToggle: _toggleLine,
                showUBahn: widget.includeUBahn,
                showSBahn: widget.includeSBahn,
              ),
              const SizedBox(height: 20),
              if (_showingResult) ...[
                _buildResultSummary(),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: _nextStation,
                    style: FilledButton.styleFrom(
                      backgroundColor: isLastRound
                          ? const Color(0xFFDA421E)
                          : Colors.blueGrey.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isLastRound
                              ? Icons.flag_rounded
                              : Icons.arrow_forward_rounded,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isLastRound ? s.lastStop : s.continueButton,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: _submitAnswer,
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF224F86),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      s.checkAnswer,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultSummary() {
    final s = LanguageScope.of(context).strings;
    final round = _lastRound!;
    final Color scoreColor;
    if (round.isPerfect) {
      scoreColor = Colors.green;
    } else if (round.score >= 0) {
      scoreColor = Colors.orange;
    } else {
      scoreColor = Colors.red;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (round.isPerfect)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Text(
                  s.perfectRide,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            const SizedBox(height: 4),
            Text(
              s.points(round.score),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: scoreColor,
              ),
            ),
            const SizedBox(height: 8),
            if (round.hits.isNotEmpty)
              _resultRow(s.correct, round.hits, Colors.green),
            if (round.wrongGuesses.isNotEmpty)
              _resultRow(s.wrong, round.wrongGuesses, Colors.red),
            if (round.misses.isNotEmpty)
              _resultRow(s.missed, round.misses, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _resultRow(String label, Set<String> lineIds, Color color) {
    final IconData icon;
    if (color == Colors.green) {
      icon = Icons.check_circle_rounded;
    } else if (color == Colors.red) {
      icon = Icons.cancel_rounded;
    } else {
      icon = Icons.remove_circle_outline_rounded;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          Expanded(
            child: Text(
              lineIds.toList().join(', '),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
