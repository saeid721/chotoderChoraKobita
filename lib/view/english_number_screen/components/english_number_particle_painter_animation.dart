import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../model/english_number_model.dart';

class ParticlePainter extends CustomPainter {
  final List<ParticleEffect> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      final paint = Paint()
        ..color = particle.color.withOpacity(particle.life / particle.maxLife)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(particle.x, particle.y),
        particle.size,
        paint,
      );

      if (particle.emoji.isNotEmpty) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: particle.emoji,
            style: TextStyle(
              fontSize: particle.size * 2,
              color: Colors.white.withOpacity(particle.life / particle.maxLife),
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            particle.x - textPainter.width / 2,
            particle.y - textPainter.height / 2,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}



class HologramScanPainter extends CustomPainter {
  final double progress;

  HologramScanPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.transparent,
          const Color(0xFF00FFFF).withOpacity(0.3),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final scanX = size.width * progress;
    final rect = Rect.fromLTWH(scanX - 50, 0, 100, size.height);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}



class FirefliesPainter extends CustomPainter {
  final double progress;

  FirefliesPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    final fireflies = [
      {'x': 0.2, 'y': 0.3, 'phase': 0.0},
      {'x': 0.8, 'y': 0.5, 'phase': 1.0},
      {'x': 0.4, 'y': 0.7, 'phase': 2.0},
      {'x': 0.6, 'y': 0.2, 'phase': 1.5},
      {'x': 0.9, 'y': 0.8, 'phase': 0.5},
    ];

    for (final firefly in fireflies) {
      final x = size.width * firefly['x']! +
          math.sin(progress * 2 * math.pi + firefly['phase']!) * 20;
      final y = size.height * firefly['y']! +
          math.cos(progress * 2 * math.pi + firefly['phase']!) * 15;

      final opacity = (math.sin(progress * 4 * math.pi + firefly['phase']!) * 0.5 + 0.5);

      paint.color = const Color(0xFFFFFF00).withOpacity(opacity * 0.8);
      canvas.drawCircle(Offset(x, y), 3, paint);

      paint.color = const Color(0xFFFFFF00).withOpacity(opacity * 0.3);
      canvas.drawCircle(Offset(x, y), 8, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}




class WaterWavesPainter extends CustomPainter {
  final double progress;

  WaterWavesPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00FFFF).withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();

    for (double x = 0; x <= size.width; x += 5) {
      final y1 = size.height * 0.3 +
          math.sin(progress * 2 * math.pi + x * 0.01) * 10;
      final y2 = size.height * 0.7 +
          math.cos(progress * 2 * math.pi + x * 0.008) * 8;

      if (x == 0) {
        path.moveTo(x, y1);
      } else {
        path.lineTo(x, y1);
      }
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}




class BubbleStreamPainter extends CustomPainter {
  final double progress;

  BubbleStreamPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    final bubbles = [
      {'x': 0.1, 'speed': 1.0, 'size': 4.0},
      {'x': 0.3, 'speed': 1.2, 'size': 6.0},
      {'x': 0.5, 'speed': 0.8, 'size': 3.0},
      {'x': 0.7, 'speed': 1.5, 'size': 5.0},
      {'x': 0.9, 'speed': 1.1, 'size': 7.0},
    ];

    for (final bubble in bubbles) {
      final x = size.width * bubble['x']!;
      final y = size.height - ((progress * bubble['speed']!) % 1.2) * size.height * 1.2;

      if (y > -50 && y < size.height + 50) {
        paint.color = Colors.white.withOpacity(0.3);
        canvas.drawCircle(Offset(x, y), bubble['size']!, paint);

        paint.color = Colors.white.withOpacity(0.6);
        canvas.drawCircle(
          Offset(x - bubble['size']! * 0.3, y - bubble['size']! * 0.3),
          bubble['size']! * 0.3,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}