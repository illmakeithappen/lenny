import 'package:flutter/material.dart';
import '../data/city_data.dart';
import '../data/lines.dart';
import 'line_button.dart';

class LineGrid extends StatelessWidget {
  final CityData cityData;
  final Set<String> selectedLines;
  final Map<String, LineButtonState> buttonStates;
  final ValueChanged<String> onToggle;
  final bool showUBahn;
  final bool showSBahn;

  const LineGrid({
    super.key,
    required this.cityData,
    required this.selectedLines,
    this.buttonStates = const {},
    required this.onToggle,
    this.showUBahn = true,
    this.showSBahn = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showUBahn) _buildSection('U-Bahn', cityData.uBahnLines),
        if (showUBahn && showSBahn) const SizedBox(height: 16),
        if (showSBahn) _buildSection('S-Bahn', cityData.sBahnLines),
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
