import 'package:flutter/material.dart';

class BanglaNumberModel {
  final String letter;
  final Color primaryColor;
  final Color secondaryColor;

  BanglaNumberModel({
    required this.letter,
    required this.primaryColor,
    required this.secondaryColor,
  });
}

/// Function to convert int -> Bangla Number
String _convertToBanglaNumber(int number) {
  const banglaDigits = ['০','১','২','৩','৪','৫','৬','৭','৮','৯'];
  final str = number.toString();
  String banglaNumber = '';
  for (var ch in str.split('')) {
    banglaNumber += banglaDigits[int.parse(ch)];
  }
  return banglaNumber;
}

/// Generate 1–100 Bangla numbers list
final List<BanglaNumberModel> letters = List.generate(100, (index) {
  final number = index + 1;
  return BanglaNumberModel(
    letter: _convertToBanglaNumber(number),
    primaryColor: const Color(0xFF6C5CE7),
    secondaryColor: const Color(0xFFA29BFE),
  );
});

// Particle Model for Effects
class ParticleEffect {
  double x;
  double y;
  double vx;
  double vy;
  double size;
  Color color;
  double life;
  double maxLife;
  String emoji;

  ParticleEffect({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.color,
    required this.maxLife,
    this.emoji = '✨',
  }) : life = maxLife;
}
