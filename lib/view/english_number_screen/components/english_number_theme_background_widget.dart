import 'package:flutter/material.dart';
import 'english_number_enmu.dart';
import 'english_number_particle_painter_animation.dart';

class ThemeBackgroundWidget extends StatelessWidget {
  final EnglishNumberTheme currentTheme;
  final AnimationController ambientController;

  const ThemeBackgroundWidget({
    super.key,
    required this.currentTheme,
    required this.ambientController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ambientController,
      builder: (context, child) {
        switch (currentTheme) {
          case EnglishNumberTheme.storybook:
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFE6F0),
                    Color(0xFFB3E5FC),
                    Color(0xFFE8F5E8),
                    Color(0xFFFFF3E0),
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            );

          case EnglishNumberTheme.holographic:
            return Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  colors: [
                    Color(0xFF1A1A2E),
                    Color(0xFF16213E),
                    Color(0xFF0F3460),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: ambientController,
                    builder: (context, child) {
                      return Positioned.fill(
                        child: CustomPaint(
                          painter: HologramScanPainter(ambientController.value),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );

          case EnglishNumberTheme.enchanted:
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF667EEA),
                    Color(0xFF764BA2),
                    Color(0xFF2D5016),
                    Color(0xFF1A3009),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: ambientController,
                    builder: (context, child) {
                      return Positioned.fill(
                        child: CustomPaint(
                          painter: FirefliesPainter(ambientController.value),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );

          case EnglishNumberTheme.ocean:
            return Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  colors: [
                    Color(0xFF0066CC),
                    Color(0xFF004080),
                    Color(0xFF002040),
                    Color(0xFF001020),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: ambientController,
                    builder: (context, child) {
                      return Positioned.fill(
                        child: CustomPaint(
                          painter: WaterWavesPainter(ambientController.value),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: ambientController,
                    builder: (context, child) {
                      return Positioned.fill(
                        child: CustomPaint(
                          painter: BubbleStreamPainter(ambientController.value),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}