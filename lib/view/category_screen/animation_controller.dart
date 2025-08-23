import 'dart:math';
import 'package:flutter/material.dart';

class BanglaKobitaAnimations {
  final TickerProvider vsync;

  late AnimationController sparkleController;
  late AnimationController floatingController;
  late AnimationController textController;
  late AnimationController headerController;
  final List<AnimationController> itemControllers = [];

  BanglaKobitaAnimations({required this.vsync});

  void init({int itemCount = 0}) {
    sparkleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: vsync,
    )..repeat();

    floatingController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: vsync,
    )..repeat(reverse: true);

    textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: vsync,
    )..forward();

    headerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: vsync,
    )..repeat(reverse: true);

    for (int i = 0; i < itemCount; i++) {
      itemControllers.add(AnimationController(
        duration: Duration(milliseconds: 300 + (i * 50)),
        vsync: vsync,
      ));
    }
  }

  /// Animate list items sequentially
  Future<void> animateItemsIn() async {
    for (var controller in itemControllers) {
      controller.forward();
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  /// Floating decoration position logic
  Offset getFloatingPosition(int index, double screenWidth) {
    final offsetY = 50 + (index * 80) + (30 * floatingController.value);
    final offsetX = (index.isEven ? 30 : screenWidth - 80) +
        (20 * floatingController.value * (index.isEven ? 1 : -1));
    return Offset(offsetX, offsetY);
  }

  /// Sparkle rotation value
  double getSparkleRotation() => sparkleController.value * 2 * pi;

  void dispose() {
    sparkleController.dispose();
    floatingController.dispose();
    textController.dispose();
    headerController.dispose();
    for (var c in itemControllers) {
      c.dispose();
    }
  }
}
