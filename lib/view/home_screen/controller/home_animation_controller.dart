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

  void dispose() {
    sparkleController.dispose();
    floatingController.dispose();
    textController.dispose();
    headerController.dispose();
    for (var c in itemControllers) {
      c.dispose();
    }
  }

  void init({int itemCount = 0}) {
    // Initialize controllers
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
}



class HomeAnimationController {
  late final AnimationController floatingController;
  late final AnimationController pulseController;
  late final AnimationController shimmerController;
  late final AnimationController universeController;
  late final AnimationController galaxyController;
  late final AnimationController particleController;
  late final AnimationController morphController;

  HomeAnimationController({required TickerProvider vsync}) {
    floatingController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: vsync,
    );

    pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: vsync,
    );

    shimmerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: vsync,
    );

    universeController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: vsync,
    );

    galaxyController = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: vsync,
    );

    morphController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: vsync,
    );

    particleController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: vsync,
    );
  }

  void init() {
    floatingController.repeat();
    pulseController.repeat(reverse: true);
    shimmerController.repeat();
    universeController.repeat();
    galaxyController.repeat();
    morphController.repeat();
    particleController.repeat();
  }

  void dispose() {
    floatingController.dispose();
    pulseController.dispose();
    shimmerController.dispose();
    universeController.dispose();
    galaxyController.dispose();
    morphController.dispose();
    particleController.dispose();
  }
}

class NebulaPainter extends CustomPainter {
  final double progress;

  NebulaPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..blendMode = BlendMode.screen;

    for (int i = 0; i < 5; i++) {
      final center = Offset(
        size.width * (0.3 + cos(progress * 2 * pi + i) * 0.4),
        size.height * (0.4 + sin(progress * 2 * pi + i) * 0.3),
      );

      paint.shader = RadialGradient(
        colors: [
          const Color(0xFF9333EA).withOpacity(0.1),
          const Color(0xFFEC4899).withOpacity(0.05),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: 200 + i * 50));

      canvas.drawCircle(center, 200 + i * 50, paint);
    }
  }

  @override
  bool shouldRepaint(NebulaPainter oldDelegate) => oldDelegate.progress != progress;
}


class MagicalPortalClipper extends CustomClipper<Path> {
  final double value;

  MagicalPortalClipper(this.value);

  @override
  Path getClip(Size size) {
    final path = Path();
    final waveHeight = 15.0;
    final frequency = 4.0;

    path.moveTo(0, waveHeight);

    for (double x = 0; x <= size.width; x += 5) {
      final y = waveHeight * sin((x / size.width) * frequency * pi + value * 2 * pi) + waveHeight;
      path.lineTo(x, y);
    }

    for (double y = waveHeight; y <= size.height - waveHeight; y += 5) {
      final x = size.width - waveHeight * sin((y / size.height) * frequency * pi + value * 2 * pi + pi / 2) - waveHeight;
      path.lineTo(x, y);
    }

    for (double x = size.width; x >= 0; x -= 5) {
      final y = size.height - waveHeight * sin((x / size.width) * frequency * pi + value * 2 * pi + pi) - waveHeight;
      path.lineTo(x, y);
    }

    for (double y = size.height - waveHeight; y >= waveHeight; y -= 5) {
      final x = waveHeight * sin((y / size.height) * frequency * pi + value * 2 * pi + 3 * pi / 2) + waveHeight;
      path.lineTo(x, y);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant MagicalPortalClipper oldClipper) => oldClipper.value != value;
}



class MagicalParticlesPainter extends CustomPainter {
  final double progress;

  MagicalParticlesPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = Random(42);

    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final particleProgress = (progress + i * 0.1) % 1.0;
      final opacity = sin(particleProgress * 2 * pi) * 0.5 + 0.5;
      final scale = 0.5 + opacity * 0.5;

      final symbols = ['✨', '⭐', '💫', '🌟', '✦', '★'];
      final symbol = symbols[i % symbols.length];

      final textPainter = TextPainter(
        text: TextSpan(
          text: symbol,
          style: TextStyle(
            fontSize: 12 * scale,
            color: Colors.white.withOpacity(opacity * 0.6),
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          x + cos(particleProgress * 2 * pi) * 20,
          y + sin(particleProgress * 2 * pi) * 10,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(MagicalParticlesPainter oldDelegate) => oldDelegate.progress != progress;
}