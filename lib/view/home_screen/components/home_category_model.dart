import 'package:flutter/material.dart';

class HomeCategoryModel {
  final String title;
  final String subtitle;
  final String slug;
  final String icon;
  final List<Color> gradient;
  final String emoji;

  HomeCategoryModel({
    required this.title,
    required this.subtitle,
    required this.slug,
    required this.icon,
    required this.gradient,
    required this.emoji,
  });
}


class StarParticle {
  final double x, y, size, twinkleSpeed, brightness;

  StarParticle({
    required this.x,
    required this.y,
    required this.size,
    required this.twinkleSpeed,
    required this.brightness,
  });
}


class FloatingIsland {
  final double x, y, size, floatSpeed;
  final Color color;

  FloatingIsland({
    required this.x,
    required this.y,
    required this.size,
    required this.floatSpeed,
    required this.color,
  });
}