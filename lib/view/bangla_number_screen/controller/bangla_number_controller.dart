import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'dart:math' as math;
import '../components/bangla_number_enmu.dart';
import '../model/bangla_number_model.dart';

class BanglaNumberController {
  BanglaNumberTheme currentTheme = BanglaNumberTheme.storybook;
  BanglaNumberModel? selectedLetter;
  bool isReading = false;
  late FlutterTts flutterTts;
  List<ParticleEffect> particles = [];
  late AnimationController floatingController;
  late AnimationController particleController;
  late AnimationController readingController;
  late AnimationController themeTransitionController;
  late AnimationController ambientController;
  Timer? _particleTimer;

  late final List<BanglaNumberModel> letters = BanglaNumberModel.letters;

  final TickerProvider vsync;
  final Function(BanglaNumberModel, Offset) onLetterTap;
  final Function(BanglaNumberTheme) onSwitchTheme;
  final VoidCallback onCloseReading;

  BanglaNumberController({
    required this.vsync,
    required this.onLetterTap,
    required this.onSwitchTheme,
    required this.onCloseReading,
  });

  void init() {
    _initializeTts();
    _initializeAnimations();
    _startParticleSystem();
  }

  void _initializeTts() {
    flutterTts = FlutterTts();
    flutterTts.setLanguage("bn-BD");
    flutterTts.setSpeechRate(0.7);
    flutterTts.setVolume(0.9);
    flutterTts.setPitch(1.0);
  }

  void _initializeAnimations() {
    floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: vsync,
    )..repeat();

    particleController = AnimationController(
      duration: const Duration(milliseconds: 16),
      vsync: vsync,
    )..repeat();

    readingController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: vsync,
    );

    themeTransitionController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: vsync,
    );

    ambientController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: vsync,
    )..repeat();

    particleController.addListener(_updateParticles);
  }

  void _startParticleSystem() {
    _particleTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (particles.length < 20 && !isReading) {
        _createAmbientParticle();
      }
    });
  }

  void _updateParticles() {
    for (int i = particles.length - 1; i >= 0; i--) {
      particles[i].x += particles[i].vx;
      particles[i].y += particles[i].vy;
      particles[i].life--;
      particles[i].vy += 0.1; // Gravity

      if (particles[i].life <= 0) {
        particles.removeAt(i);
      }
    }
  }

  void _createAmbientParticle() {
    final random = math.Random();
    particles.add(ParticleEffect(
      x: random.nextDouble() * 400,
      y: random.nextDouble() * 800,
      vx: (random.nextDouble() - 0.5) * 4,
      vy: (random.nextDouble() - 0.5) * 4,
      size: random.nextDouble() * 6 + 3,
      color: _getThemeAccentColor(),
      maxLife: 80.0 + random.nextDouble() * 40,
      emoji: _getThemeParticleEmoji(),
    ));
  }

  void createLetterParticles(Offset position) {
    final random = math.Random();

    for (int i = 0; i < 25; i++) {
      particles.add(ParticleEffect(
        x: position.dx,
        y: position.dy,
        vx: (random.nextDouble() - 0.5) * 12,
        vy: (random.nextDouble() - 0.5) * 12,
        size: random.nextDouble() * 8 + 4,
        color: _getThemeAccentColor(),
        maxLife: 120.0 + random.nextDouble() * 60,
        emoji: _getThemeParticleEmoji(),
      ));
    }
  }

  void createThemeChangeParticles(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final random = math.Random();

    for (int i = 0; i < 40; i++) {
      particles.add(ParticleEffect(
        x: size.width / 2,
        y: size.height / 2,
        vx: (random.nextDouble() - 0.5) * 16,
        vy: (random.nextDouble() - 0.5) * 16,
        size: random.nextDouble() * 10 + 6,
        color: _getThemeAccentColor(),
        maxLife: 150.0 + random.nextDouble() * 100,
        emoji: _getThemeParticleEmoji(),
      ));
    }
  }

  Color _getThemeAccentColor() {
    switch (currentTheme) {
      case BanglaNumberTheme.storybook:
        return const Color(0xFFFFD700);
      case BanglaNumberTheme.holographic:
        return const Color(0xFF00FFFF);
      case BanglaNumberTheme.enchanted:
        return const Color(0xFF90EE90);
      case BanglaNumberTheme.ocean:
        return const Color(0xFF87CEEB);
    }
  }

  String _getThemeParticleEmoji() {
    switch (currentTheme) {
      case BanglaNumberTheme.storybook:
        return ['✨', '⭐', '🌟', '💫'][math.Random().nextInt(4)];
      case BanglaNumberTheme.holographic:
        return ['⚡', '💎', '🔷', '✦'][math.Random().nextInt(4)];
      case BanglaNumberTheme.enchanted:
        return ['🌿', '🦋', '🌺', '🍃'][math.Random().nextInt(4)];
      case BanglaNumberTheme.ocean:
        return ['🐠', '🫧', '🌊', '🐚'][math.Random().nextInt(4)];
    }
  }

  void speakLetter(BanglaNumberModel letter) async {
    await flutterTts.speak(letter.pronunciation);

    Future.delayed(const Duration(seconds: 2), () {
      if (isReading) {
        onCloseReading();
      }
    });
  }

  void dispose() {
    floatingController.dispose();
    particleController.dispose();
    readingController.dispose();
    themeTransitionController.dispose();
    ambientController.dispose();
    _particleTimer?.cancel();
    flutterTts.stop();
  }
}