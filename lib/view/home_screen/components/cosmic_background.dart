import 'dart:math';

import 'package:flutter/material.dart';
import '../controller/home_animation_controller.dart';
import 'home_category_model.dart';

class CosmicBackground extends StatelessWidget {
  final AnimationController universeController;
  final AnimationController galaxyController;
  final List<StarParticle> stars;

  const CosmicBackground({
    super.key,
    required this.universeController,
    required this.galaxyController,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: universeController,
          builder: (context, child) {
            final screenSize = MediaQuery.of(context).size;
            return Stack(
              children: stars.map((star) {
                final twinkle = sin(universeController.value * 2 * pi * star.twinkleSpeed) * 0.5 + 0.5;
                return Positioned(
                  left: star.x * screenSize.width,
                  top: star.y * screenSize.height,
                  child: Container(
                    width: star.size,
                    height: star.size,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(star.brightness * twinkle),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(twinkle * 0.5),
                          blurRadius: star.size * 3,
                          spreadRadius: star.size * 0.5,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        AnimatedBuilder(
          animation: galaxyController,
          builder: (context, child) {
            return CustomPaint(
              size: MediaQuery.of(context).size,
              painter: NebulaPainter(galaxyController.value),
            );
          },
        ),
      ],
    );
  }
}