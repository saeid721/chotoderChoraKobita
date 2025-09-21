import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'dart:math' as math;
import '../components/alpha_enmu.dart';
import '../model/alphabet_model.dart';

class AlphabetController {
  AlphabetTheme currentTheme = AlphabetTheme.storybook;
  LetterModel? selectedLetter;
  bool isReading = false;
  late FlutterTts flutterTts;
  List<ParticleEffect> particles = [];
  late AnimationController floatingController;
  late AnimationController particleController;
  late AnimationController readingController;
  late AnimationController themeTransitionController;
  late AnimationController ambientController;
  Timer? _particleTimer;

  final List<LetterModel> letters = [
    LetterModel(letter: 'A', pronunciation: 'AY', phonetic: '/eɪ/', word: 'Apple', primaryColor: const Color(0xFF6C5CE7), secondaryColor: const Color(0xFFA29BFE), icon: Icons.rocket_launch),
    LetterModel(letter: 'B', pronunciation: 'BEE', phonetic: '/biː/', word: 'Butterfly', primaryColor: const Color(0xFFE17055), secondaryColor: const Color(0xFFFD79A8), icon: Icons.flight_takeoff),
    LetterModel(letter: 'C', pronunciation: 'SEE', phonetic: '/siː/', word: 'Crystal', primaryColor: const Color(0xFF00CEC9), secondaryColor: const Color(0xFF55EFC4), icon: Icons.diamond),
    LetterModel(letter: 'D', pronunciation: 'DEE', phonetic: '/diː/', word: 'Dragon', primaryColor: const Color(0xFFFF6B6B), secondaryColor: const Color(0xFFFFE66D), icon: Icons.local_fire_department),
    LetterModel(letter: 'E', pronunciation: 'EE', phonetic: '/iː/', word: 'Elephant', primaryColor: const Color(0xFF4ECDC4), secondaryColor: const Color(0xFF45B7D1), icon: Icons.flash_on),
    LetterModel(letter: 'F', pronunciation: 'EFF', phonetic: '/ɛf/', word: 'Fairy', primaryColor: const Color(0xFFFF9FF3), secondaryColor: const Color(0xFFF368E0), icon: Icons.auto_fix_high),
    LetterModel(letter: 'G', pronunciation: 'GEE', phonetic: '/dʒiː/', word: 'Galaxy', primaryColor: const Color(0xFF5F27CD), secondaryColor: const Color(0xFF00D2D3), icon: Icons.blur_on),
    LetterModel(letter: 'H', pronunciation: 'AYCH', phonetic: '/eɪtʃ/', word: 'Heart', primaryColor: const Color(0xFFE55039), secondaryColor: const Color(0xFFFA983A), icon: Icons.favorite),
    LetterModel(letter: 'I', pronunciation: 'EYE', phonetic: '/aɪ/', word: 'Island', primaryColor: const Color(0xFF3867D6), secondaryColor: const Color(0xFF8854D0), icon: Icons.landscape),
    LetterModel(letter: 'J', pronunciation: 'JAY', phonetic: '/dʒeɪ/', word: 'Jungle', primaryColor: const Color(0xFF2ECC71), secondaryColor: const Color(0xFF27AE60), icon: Icons.forest),
    LetterModel(letter: 'K', pronunciation: 'KAY', phonetic: '/keɪ/', word: 'King', primaryColor: const Color(0xFF95A5A6), secondaryColor: const Color(0xFFBDC3C7), icon: Icons.shield),
    LetterModel(letter: 'L', pronunciation: 'ELL', phonetic: '/ɛl/', word: 'Lion', primaryColor: const Color(0xFFF1C40F), secondaryColor: const Color(0xFFF39C12), icon: Icons.bolt),
    LetterModel(letter: 'M', pronunciation: 'EMM', phonetic: '/ɛm/', word: 'Magic', primaryColor: const Color(0xFF9B59B6), secondaryColor: const Color(0xFF8E44AD), icon: Icons.auto_fix_high),
    LetterModel(letter: 'N', pronunciation: 'ENN', phonetic: '/ɛn/', word: 'Nebula', primaryColor: const Color(0xFF2C3E50), secondaryColor: const Color(0xFF34495E), icon: Icons.nights_stay),
    LetterModel(letter: 'O', pronunciation: 'OH', phonetic: '/oʊ/', word: 'Ocean', primaryColor: const Color(0xFF3498DB), secondaryColor: const Color(0xFF2980B9), icon: Icons.waves),
    LetterModel(letter: 'P', pronunciation: 'PEE', phonetic: '/piː/', word: 'Planet', primaryColor: const Color(0xFF1ABC9C), secondaryColor: const Color(0xFF16A085), icon: Icons.public),
    LetterModel(letter: 'Q', pronunciation: 'CUE', phonetic: '/kjuː/', word: 'Quantum', primaryColor: const Color(0xFFE74C3C), secondaryColor: const Color(0xFFC0392B), icon: Icons.scatter_plot),
    LetterModel(letter: 'R', pronunciation: 'ARR', phonetic: '/ɑːr/', word: 'Rainbow', primaryColor: const Color(0xFFFF6B9D), secondaryColor: const Color(0xFFFFA8E2), icon: Icons.colorize),
    LetterModel(letter: 'S', pronunciation: 'ESS', phonetic: '/ɛs/', word: 'Star', primaryColor: const Color(0xFFFFD93D), secondaryColor: const Color(0xFFFF6B6B), icon: Icons.star),
    LetterModel(letter: 'T', pronunciation: 'TEE', phonetic: '/tiː/', word: 'Tornado', primaryColor: const Color(0xFF74B9FF), secondaryColor: const Color(0xFF0984E3), icon: Icons.cyclone),
    LetterModel(letter: 'U', pronunciation: 'YOU', phonetic: '/juː/', word: 'Universe', primaryColor: const Color(0xFF6C5CE7), secondaryColor: const Color(0xFFA29BFE), icon: Icons.all_inclusive),
    LetterModel(letter: 'V', pronunciation: 'VEE', phonetic: '/viː/', word: 'Volcano', primaryColor: const Color(0xFFE17055), secondaryColor: const Color(0xFFD63031), icon: Icons.terrain),
    LetterModel(letter: 'W', pronunciation: 'DOUBLE-YOU', phonetic: '/ˈdʌbəljuː/', word: 'Wind', primaryColor: const Color(0xFF00B894), secondaryColor: const Color(0xFF00CEC9), icon: Icons.air),
    LetterModel(letter: 'X', pronunciation: 'EKS', phonetic: '/ɛks/', word: 'X-ray', primaryColor: const Color(0xFF2D3436), secondaryColor: const Color(0xFF636E72), icon: Icons.visibility),
    LetterModel(letter: 'Y', pronunciation: 'WHY', phonetic: '/waɪ/', word: 'Yellow', primaryColor: const Color(0xFFFDCB6E), secondaryColor: const Color(0xFFE84393), icon: Icons.wb_sunny),
    LetterModel(letter: 'Z', pronunciation: 'ZEE', phonetic: '/ziː/', word: 'Zephyr', primaryColor: const Color(0xFF74B9FF), secondaryColor: const Color(0xFF0984E3), icon: Icons.tsunami),
  ];


  final TickerProvider vsync;
  final Function(LetterModel, Offset) onLetterTap;
  final Function(AlphabetTheme) onSwitchTheme;
  final VoidCallback onCloseReading;

  AlphabetController({
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
    flutterTts.setLanguage("en-US");
    flutterTts.setSpeechRate(0.7);
    flutterTts.setVolume(0.9);
    flutterTts.setPitch(1.2);
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
    // This requires context for MediaQuery, so it should be passed or handled differently
    // For simplicity, we'll assume context is available or adjust in the calling widget
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
      case AlphabetTheme.storybook:
        return const Color(0xFFFFD700);
      case AlphabetTheme.holographic:
        return const Color(0xFF00FFFF);
      case AlphabetTheme.enchanted:
        return const Color(0xFF90EE90);
      case AlphabetTheme.ocean:
        return const Color(0xFF87CEEB);
    }
  }

  String _getThemeParticleEmoji() {
    switch (currentTheme) {
      case AlphabetTheme.storybook:
        return ['✨', '⭐', '🌟', '💫'][math.Random().nextInt(4)];
      case AlphabetTheme.holographic:
        return ['⚡', '💎', '🔷', '✦'][math.Random().nextInt(4)];
      case AlphabetTheme.enchanted:
        return ['🌿', '🦋', '🌺', '🍃'][math.Random().nextInt(4)];
      case AlphabetTheme.ocean:
        return ['🐠', '🫧', '🌊', '🐚'][math.Random().nextInt(4)];
    }
  }

  void speakLetter(LetterModel letter) async {
    await flutterTts.speak(letter.pronunciation);

    Future.delayed(const Duration(seconds: 4), () {
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