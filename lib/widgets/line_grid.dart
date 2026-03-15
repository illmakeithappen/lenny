import 'package:flutter/material.dart';
import '../data/lines.dart';
import 'line_button.dart';

class LineGrid extends StatelessWidget {
  final Set<String> selectedLines;
  final Map<String, LineButtonState> buttonStates;
  final ValueChanged<String> onToggle;

  const LineGrid({
    super.key,
    required this.selectedLines,
    this.buttonStates = const {},
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection('U-Bahn', uBahnLines),
        const SizedBox(height: 16),
        _buildSection('S-Bahn', sBahnLines),
      ],
    );
  }

  Widget _buildSection(String title, List<LineInfo> lines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: lines.map((line) {
            return LineButton(
              line: line,
              isSelected: selectedLines.contains(line.id),
              state: buttonStates[line.id] ?? LineButtonState.normal,
              onToggle: () => onToggle(line.id),
            );
          }).toList(),
        ),
      ],
    );
  }
}
