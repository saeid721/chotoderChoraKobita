import 'package:flutter/material.dart';

class EnglishNumberModel {
  final String letter;
  final Color primaryColor;
  final Color secondaryColor;

  EnglishNumberModel({
    required this.letter,
    required this.primaryColor,
    required this.secondaryColor,
  });
}

/// Generate 1–100 English numbers list
final List<EnglishNumberModel> letters = List.generate(100, (index) {
  final number = index + 1;
  return EnglishNumberModel(
    letter: number.toString(),
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
