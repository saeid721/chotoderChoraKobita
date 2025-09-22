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
    LetterModel(letter: 'A', pronunciation: 'AY', phonetic: '/eɪ/', word: 'Allah', description: 'One God', icon: '🕋', primaryColor: Color(0xFF6C5CE7), secondaryColor: Color(0xFFA29BFE)),
    LetterModel(letter: 'B', pronunciation: 'BEE', phonetic: '/biː/', word: 'Bismillah', description: 'We begin with Allah', icon: '﷽', primaryColor: Color(0xFFE17055), secondaryColor: Color(0xFFFD79A8)),
    LetterModel(letter: 'C', pronunciation: 'SEE', phonetic: '/siː/', word: 'Crescent', description: 'Moon of Islam', icon: '🌙', primaryColor: Color(0xFF00CEC9), secondaryColor: Color(0xFF55EFC4)),
    LetterModel(letter: 'D', pronunciation: 'DEE', phonetic: '/diː/', word: 'Dua', description: 'Talking to Allah', icon: '🙏', primaryColor: Color(0xFFFF6B6B), secondaryColor: Color(0xFFFFE66D)),
    LetterModel(letter: 'E', pronunciation: 'EE', phonetic: '/iː/', word: 'Eid', description: 'Happy Muslim Festival', icon: '🎉', primaryColor: Color(0xFF4ECDC4), secondaryColor: Color(0xFF45B7D1)),
    LetterModel(letter: 'F', pronunciation: 'EFF', phonetic: '/ɛf/', word: 'Fajr', description: 'Morning Prayer', icon: '🌅', primaryColor: Color(0xFFFF9FF3), secondaryColor: Color(0xFFF368E0)),
    LetterModel(letter: 'G', pronunciation: 'GEE', phonetic: '/dʒiː/', word: 'Ghusl', description: 'Cleaning body', icon: '🚿', primaryColor: Color(0xFF5F27CD), secondaryColor: Color(0xFF00D2D3)),
    LetterModel(letter: 'H', pronunciation: 'AYCH', phonetic: '/eɪtʃ/', word: 'Hajj', description: 'Trip to Makkah', icon: '🕋', primaryColor: Color(0xFFE55039), secondaryColor: Color(0xFFFA983A)),
    LetterModel(letter: 'I', pronunciation: 'EYE', phonetic: '/aɪ/', word: 'Iman', description: 'Faith in Allah', icon: '💖', primaryColor: Color(0xFF3867D6), secondaryColor: Color(0xFF8854D0)),
    LetterModel(letter: 'J', pronunciation: 'JAY', phonetic: '/dʒeɪ/', word: 'Jannah', description: 'Beautiful Paradise', icon: '🌴', primaryColor: Color(0xFF2ECC71), secondaryColor: Color(0xFF27AE60)),
    LetterModel(letter: 'K', pronunciation: 'KAY', phonetic: '/keɪ/', word: 'Kaaba', description: 'House of Allah', icon: '🕋', primaryColor: Color(0xFF95A5A6), secondaryColor: Color(0xFFBDC3C7)),
    LetterModel(letter: 'L', pronunciation: 'ELL', phonetic: '/ɛl/', word: 'Lailatul Qadr', description: 'Special Night', icon: '⭐', primaryColor: Color(0xFFF1C40F), secondaryColor: Color(0xFFF39C12)),
    LetterModel(letter: 'M', pronunciation: 'EMM', phonetic: '/ɛm/', word: 'Masjid', description: 'Mosque for Prayer', icon: '🏠', primaryColor: Color(0xFF9B59B6), secondaryColor: Color(0xFF8E44AD)),
    LetterModel(letter: 'N', pronunciation: 'ENN', phonetic: '/ɛn/', word: 'Nabi', description: 'Prophet of Allah', icon: '🕌', primaryColor: Color(0xFF2C3E50), secondaryColor: Color(0xFF34495E)),
    LetterModel(letter: 'O', pronunciation: 'OH', phonetic: '/oʊ/', word: 'Oud', description: 'Nice perfume', icon: '🌸', primaryColor: Color(0xFF3498DB), secondaryColor: Color(0xFF2980B9)),
    LetterModel(letter: 'P', pronunciation: 'PEE', phonetic: '/piː/', word: 'Prophet', description: 'Messenger of Allah', icon: '👳', primaryColor: Color(0xFF1ABC9C), secondaryColor: Color(0xFF16A085)),
    LetterModel(letter: 'Q', pronunciation: 'CUE', phonetic: '/kjuː/', word: 'Quran', description: 'Holy Book', icon: '📖', primaryColor: Color(0xFFE74C3C), secondaryColor: Color(0xFFC0392B)),
    LetterModel(letter: 'R', pronunciation: 'ARR', phonetic: '/ɑːr/', word: 'Ramadan', description: 'Fasting Month', icon: '🌙', primaryColor: Color(0xFFFF6B9D), secondaryColor: Color(0xFFFFA8E2)),
    LetterModel(letter: 'S', pronunciation: 'ESS', phonetic: '/ɛs/', word: 'Salah', description: '5 Times Prayer', icon: '🙏', primaryColor: Color(0xFFFFD93D), secondaryColor: Color(0xFFFF6B6B)),
    LetterModel(letter: 'T', pronunciation: 'TEE', phonetic: '/tiː/', word: 'Tasbih', description: 'Prayer Beads', icon: '📿', primaryColor: Color(0xFF74B9FF), secondaryColor: Color(0xFF0984E3)),
    LetterModel(letter: 'U', pronunciation: 'YOU', phonetic: '/juː/', word: 'Umrah', description: 'Small Pilgrimage', icon: '🕋', primaryColor: Color(0xFF6C5CE7), secondaryColor: Color(0xFFA29BFE)),
    LetterModel(letter: 'V', pronunciation: 'VEE', phonetic: '/viː/', word: 'Veil', description: 'Muslim Dress', icon: '🧕', primaryColor: Color(0xFFE17055), secondaryColor: Color(0xFFD63031)),
    LetterModel(letter: 'W', pronunciation: 'DOUBLE-YOU', phonetic: '/ˈdʌbəljuː/', word: 'Wudu', description: 'Washing before Salah', icon: '💧', primaryColor: Color(0xFF00B894), secondaryColor: Color(0xFF00CEC9)),
    LetterModel(letter: 'X', pronunciation: 'EKS', phonetic: '/ɛks/', word: 'Xylophone', description: 'Just for fun', icon: '🎵', primaryColor: Color(0xFF2D3436), secondaryColor: Color(0xFF636E72)),
    LetterModel(letter: 'Y', pronunciation: 'WHY', phonetic: '/waɪ/', word: 'Yawm al-Qiyamah', description: 'Day of Judgment', icon: '⏳', primaryColor: Color(0xFFFDCB6E), secondaryColor: Color(0xFFE84393)),
    LetterModel(letter: 'Z', pronunciation: 'ZEE', phonetic: '/ziː/', word: 'Zakat', description: 'Giving to the poor', icon: '💰', primaryColor: Color(0xFF74B9FF), secondaryColor: Color(0xFF0984E3)),
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