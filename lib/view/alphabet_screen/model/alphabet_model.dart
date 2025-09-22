
import 'package:flutter/material.dart';

class LetterModel {
  final String letter;
  final String pronunciation;
  final String phonetic;
  final String word;
  final String? description;
  final Color primaryColor;
  final Color secondaryColor;
  final String icon;
  LetterModel({
    required this.letter,
    required this.pronunciation,
    required this.phonetic,
    required this.word,
    this.description,
    required this.primaryColor,
    required this.secondaryColor,
    required this.icon,
  });
}


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