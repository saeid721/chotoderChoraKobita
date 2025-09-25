import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controller/home_animation_controller.dart';
import 'home_category_model.dart';

class CategoryCard extends StatelessWidget {
  final HomeCategoryModel category;
  final int index;
  final AnimationController floatingController;
  final AnimationController pulseController;
  final AnimationController shimmerController;
  final Function(HomeCategoryModel) onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.index,
    required this.floatingController,
    required this.pulseController,
    required this.shimmerController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            sin(floatingController.value * 2 * pi + index * 0.5) * 3,
            cos(floatingController.value * 2 * pi + index * 0.7) * 3,
          ),
          child: GestureDetector(
            onTapDown: (_) => HapticFeedback.mediumImpact(),
            onTap: () => onTap(category),
            child: AnimatedBuilder(
              animation: pulseController,
              builder: (context, child) {
                final scale = 1.0 + sin(pulseController.value * 2 * pi + index) * 0.02;
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.white.withOpacity(0.05),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: category.gradient[0].withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Stack(
                          children: [
                            AnimatedBuilder(
                              animation: shimmerController,
                              builder: (context, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        category.gradient[0].withOpacity(0.15),
                                        category.gradient[1].withOpacity(0.1),
                                        Colors.white.withOpacity(0.05),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedBuilder(
                                    animation: pulseController,
                                    builder: (context, child) {
                                      final iconScale = 1.0 + sin(pulseController.value * 3 * pi + index) * 0.1;
                                      return Transform.scale(
                                        scale: iconScale,
                                        child: Center(
                                          child: Text(
                                            category.icon,
                                            style: const TextStyle(fontSize: 24),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  ShaderMask(
                                    shaderCallback: (bounds) => LinearGradient(
                                      colors: category.gradient,
                                    ).createShader(bounds),
                                    child: Text(
                                      category.title,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    category.subtitle,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.7),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}


class MagicalPortal extends StatelessWidget {
  final AnimationController morphController;
  final AnimationController particleController;

  const MagicalPortal({
    super.key,
    required this.morphController,
    required this.particleController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      child: AnimatedBuilder(
        animation: morphController,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(sin(morphController.value * 2 * pi) * 0.05),
            alignment: Alignment.center,
            child: ClipPath(
              clipper: MagicalPortalClipper(morphController.value),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF9333EA).withOpacity(0.3),
                        const Color(0xFFEC4899).withOpacity(0.2),
                        const Color(0xFF06B6D4).withOpacity(0.1),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    children: [
                      CustomPaint(
                        size: const Size(double.infinity, 120),
                        painter: MagicalParticlesPainter(particleController.value),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '🌟 আজকে কী শিখবো? 🌟',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'তোমার পছন্দের বিষয় বেছে নাও!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.8),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}