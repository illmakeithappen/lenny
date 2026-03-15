import 'package:flutter/material.dart';

enum LineType { uBahn, sBahn }

class LineInfo {
  final String id;
  final LineType type;
  final Color color;

  const LineInfo({
    required this.id,
    required this.type,
    required this.color,
  });
}

const allLines = <LineInfo>[
  // U-Bahn
  LineInfo(id: 'U1', type: LineType.uBahn, color: Color(0xFF7DAD25)),
  LineInfo(id: 'U2', type: LineType.uBahn, color: Color(0xFFDA421E)),
  LineInfo(id: 'U3', type: LineType.uBahn, color: Color(0xFF007A5B)),
  LineInfo(id: 'U4', type: LineType.uBahn, color: Color(0xFFF0D722)),
  LineInfo(id: 'U5', type: LineType.uBahn, color: Color(0xFF7E5330)),
  LineInfo(id: 'U6', type: LineType.uBahn, color: Color(0xFF8C6DAB)),
  LineInfo(id: 'U7', type: LineType.uBahn, color: Color(0xFF528DBA)),
  LineInfo(id: 'U8', type: LineType.uBahn, color: Color(0xFF224F86)),
  LineInfo(id: 'U9', type: LineType.uBahn, color: Color(0xFFF3791D)),
  // S-Bahn
  LineInfo(id: 'S1', type: LineType.sBahn, color: Color(0xFFDD6BA1)),
  LineInfo(id: 'S2', type: LineType.sBahn, color: Color(0xFF005F27)),
  LineInfo(id: 'S3', type: LineType.sBahn, color: Color(0xFF0A4F8B)),
  LineInfo(id: 'S5', type: LineType.sBahn, color: Color(0xFFFF5900)),
  LineInfo(id: 'S7', type: LineType.sBahn, color: Color(0xFF6F4E9C)),
  LineInfo(id: 'S8', type: LineType.sBahn, color: Color(0xFF55A822)),
  LineInfo(id: 'S9', type: LineType.sBahn, color: Color(0xFF8B1C24)),
  LineInfo(id: 'S25', type: LineType.sBahn, color: Color(0xFF005F27)),
  LineInfo(id: 'S26', type: LineType.sBahn, color: Color(0xFF005F27)),
  LineInfo(id: 'S41/S42', type: LineType.sBahn, color: Color(0xFFA23B1E)),
  LineInfo(id: 'S45', type: LineType.sBahn, color: Color(0xFFC89F51)),
  LineInfo(id: 'S46', type: LineType.sBahn, color: Color(0xFFC89F51)),
  LineInfo(id: 'S47', type: LineType.sBahn, color: Color(0xFFC89F51)),
  LineInfo(id: 'S75', type: LineType.sBahn, color: Color(0xFF6F4E9C)),
  LineInfo(id: 'S85', type: LineType.sBahn, color: Color(0xFF55A822)),
];

final uBahnLines = allLines.where((l) => l.type == LineType.uBahn).toList();
final sBahnLines = allLines.where((l) => l.type == LineType.sBahn).toList();

final lineById = {for (final l in allLines) l.id: l};
