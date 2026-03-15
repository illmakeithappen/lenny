import 'package:flutter/material.dart';
import '../data/lines.dart';

enum LineButtonState { normal, hit, missed, wrong }

class LineButton extends StatelessWidget {
  final LineInfo line;
  final bool isSelected;
  final LineButtonState state;
  final VoidCallback onToggle;

  const LineButton({
    super.key,
    required this.line,
    required this.isSelected,
    this.state = LineButtonState.normal,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isResult = state != LineButtonState.normal;

    Color bg;
    Color fg;
    Border? border;

    if (isResult) {
      switch (state) {
        case LineButtonState.hit:
          bg = line.color;
          fg = _contrastColor(line.color);
          border = Border.all(color: Colors.green, width: 3);
        case LineButtonState.wrong:
          bg = Colors.grey.shade300;
          fg = Colors.red.shade700;
          border = Border.all(color: Colors.red, width: 3);
        case LineButtonState.missed:
          bg = line.color.withValues(alpha: 0.3);
          fg = line.color;
          border = Border.all(color: Colors.orange, width: 3);
        case LineButtonState.normal:
          bg = Colors.grey.shade300;
          fg = Colors.black87;
      }
    } else if (isSelected) {
      bg = line.color;
      fg = _contrastColor(line.color);
    } else {
      bg = Colors.grey.shade200;
      fg = Colors.black87;
    }

    return GestureDetector(
      onTap: isResult ? null : onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: border,
        ),
        child: Text(
          line.id,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: fg,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  static Color _contrastColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.4 ? Colors.black87 : Colors.white;
  }
}
