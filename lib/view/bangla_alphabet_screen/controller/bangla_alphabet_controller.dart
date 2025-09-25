import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'dart:math' as math;
import '../components/alpha_enmu.dart';
import '../model/bangla_alphabet_model.dart';

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
    LetterModel(letter: 'ক', pronunciation: 'ko', phonetic: '/kɔ/', word: 'কাক', description: 'একটি পাখি', icon: '🐦', primaryColor: Color(0xFFF1C40F), secondaryColor: Color(0xFFF39C12)),
    LetterModel(letter: 'খ', pronunciation: 'kho', phonetic: '/kʰɔ/', word: 'খরগোশ', description: 'একটি প্রাণী', icon: '🐇', primaryColor: Color(0xFF9B59B6), secondaryColor: Color(0xFF8E44AD)),
    LetterModel(letter: 'গ', pronunciation: 'go', phonetic: '/gɔ/', word: 'গরু', description: 'গৃহপালিত প্রাণী', icon: '🐄', primaryColor: Color(0xFF2C3E50), secondaryColor: Color(0xFF34495E)),
    LetterModel(letter: 'ঘ', pronunciation: 'gho', phonetic: '/ɡʱɔ/', word: 'ঘোড়া', description: 'একটি প্রাণী', icon: '🐎', primaryColor: Color(0xFF3498DB), secondaryColor: Color(0xFF2980B9)),
    LetterModel(letter: 'ঙ', pronunciation: 'ung', phonetic: '/ŋɔ/', word: 'ঙিন', description: 'প্রতীকী ধ্বনি', icon: '🔔', primaryColor: Color(0xFF1ABC9C), secondaryColor: Color(0xFF16A085)),

    LetterModel(letter: 'চ', pronunciation: 'cho', phonetic: '/tʃɔ/', word: 'চশমা', description: 'চোখের জন্য', icon: '👓', primaryColor: Color(0xFFE74C3C), secondaryColor: Color(0xFFC0392B)),
    LetterModel(letter: 'ছ', pronunciation: 'chho', phonetic: '/tʃʰɔ/', word: 'ছাতা', description: 'বৃষ্টি থেকে বাঁচে', icon: '☂️', primaryColor: Color(0xFFFF6B9D), secondaryColor: Color(0xFFFFA8E2)),
    LetterModel(letter: 'জ', pronunciation: 'jo', phonetic: '/dʒɔ/', word: 'জাহাজ', description: 'নৌকা', icon: '🚢', primaryColor: Color(0xFFFFD93D), secondaryColor: Color(0xFFFF6B6B)),
    LetterModel(letter: 'ঝ', pronunciation: 'jho', phonetic: '/dʒʱɔ/', word: 'ঝুড়ি', description: 'একটি ঝুড়ি', icon: '🧺', primaryColor: Color(0xFF74B9FF), secondaryColor: Color(0xFF0984E3)),
    LetterModel(letter: 'ঞ', pronunciation: 'nyo', phonetic: '/ɲɔ/', word: 'ঞ্যান', description: 'শব্দ উচ্চারণ', icon: '🔊', primaryColor: Color(0xFF6C5CE7), secondaryColor: Color(0xFFA29BFE)),

    LetterModel(letter: 'ক', pronunciation: 'ko', phonetic: '/kɔ/', word: 'কাক', description: 'একটি পাখি', icon: '🐦', primaryColor: Color(0xFFF1C40F), secondaryColor: Color(0xFFF39C12)),
    LetterModel(letter: 'খ', pronunciation: 'kho', phonetic: '/kʰɔ/', word: 'খরগোশ', description: 'একটি প্রাণী', icon: '🐇', primaryColor: Color(0xFF9B59B6), secondaryColor: Color(0xFF8E44AD)),
    LetterModel(letter: 'গ', pronunciation: 'go', phonetic: '/gɔ/', word: 'গরু', description: 'গৃহপালিত প্রাণী', icon: '🐄', primaryColor: Color(0xFF2C3E50), secondaryColor: Color(0xFF34495E)),
    LetterModel(letter: 'ঘ', pronunciation: 'gho', phonetic: '/ɡʱɔ/', word: 'ঘোড়া', description: 'একটি প্রাণী', icon: '🐎', primaryColor: Color(0xFF3498DB), secondaryColor: Color(0xFF2980B9)),
    LetterModel(letter: 'ঙ', pronunciation: 'ung', phonetic: '/ŋɔ/', word: 'ঙিন', description: 'প্রতীকী ধ্বনি', icon: '🔔', primaryColor: Color(0xFF1ABC9C), secondaryColor: Color(0xFF16A085)),

    LetterModel(letter: 'চ', pronunciation: 'cho', phonetic: '/tʃɔ/', word: 'চশমা', description: 'চোখের জন্য', icon: '👓', primaryColor: Color(0xFFE74C3C), secondaryColor: Color(0xFFC0392B)),
    LetterModel(letter: 'ছ', pronunciation: 'chho', phonetic: '/tʃʰɔ/', word: 'ছাতা', description: 'বৃষ্টি থেকে রক্ষা', icon: '☂️', primaryColor: Color(0xFFFF6B9D), secondaryColor: Color(0xFFFFA8E2)),
    LetterModel(letter: 'জ', pronunciation: 'jo', phonetic: '/dʒɔ/', word: 'জাহাজ', description: 'সমুদ্র যান', icon: '🚢', primaryColor: Color(0xFFFFD93D), secondaryColor: Color(0xFFFF6B6B)),
    LetterModel(letter: 'ঝ', pronunciation: 'jho', phonetic: '/dʒʱɔ/', word: 'ঝুড়ি', description: 'একটি ঝুড়ি', icon: '🧺', primaryColor: Color(0xFF74B9FF), secondaryColor: Color(0xFF0984E3)),
    LetterModel(letter: 'ঞ', pronunciation: 'nyo', phonetic: '/ɲɔ/', word: 'ঞ্যান', description: 'শব্দ উচ্চারণ', icon: '🔊', primaryColor: Color(0xFF6C5CE7), secondaryColor: Color(0xFFA29BFE)),

    LetterModel(letter: 'ট', pronunciation: 'to', phonetic: '/ʈɔ/', word: 'টব', description: 'গাছের টব', icon: '🪴', primaryColor: Color(0xFFE17055), secondaryColor: Color(0xFFFD79A8)),
    LetterModel(letter: 'ঠ', pronunciation: 'tho', phonetic: '/ʈʰɔ/', word: 'ঠাকুর', description: 'সম্মানিত ব্যক্তি', icon: '🙏', primaryColor: Color(0xFF00CEC9), secondaryColor: Color(0xFF55EFC4)),
    LetterModel(letter: 'ড', pronunciation: 'do', phonetic: '/ɖɔ/', word: 'ডাক্তার', description: 'চিকিৎসক', icon: '👨‍⚕️', primaryColor: Color(0xFFFF6B6B), secondaryColor: Color(0xFFFFE66D)),
    LetterModel(letter: 'ঢ', pronunciation: 'dho', phonetic: '/ɖʱɔ/', word: 'ঢাক', description: 'বাদ্যযন্ত্র', icon: '🥁', primaryColor: Color(0xFF4ECDC4), secondaryColor: Color(0xFF45B7D1)),
    LetterModel(letter: 'ণ', pronunciation: 'no', phonetic: '/ɳɔ/', word: 'ণব', description: 'বিরল শব্দ', icon: '🔣', primaryColor: Color(0xFFFF9FF3), secondaryColor: Color(0xFFF368E0)),

    LetterModel(letter: 'ত', pronunciation: 'to', phonetic: '/tɔ/', word: 'তালা', description: 'লক', icon: '🔒', primaryColor: Color(0xFF5F27CD), secondaryColor: Color(0xFF00D2D3)),
    LetterModel(letter: 'থ', pronunciation: 'tho', phonetic: '/tʰɔ/', word: 'থালা', description: 'খাওয়ার পাত্র', icon: '🍽️', primaryColor: Color(0xFFE55039), secondaryColor: Color(0xFFFA983A)),
    LetterModel(letter: 'দ', pronunciation: 'do', phonetic: '/dɔ/', word: 'দুধ', description: 'পানীয়', icon: '🥛', primaryColor: Color(0xFF3867D6), secondaryColor: Color(0xFF8854D0)),
    LetterModel(letter: 'ধ', pronunciation: 'dho', phonetic: '/dʱɔ/', word: 'ধান', description: 'শস্য', icon: '🌾', primaryColor: Color(0xFF2ECC71), secondaryColor: Color(0xFF27AE60)),
    LetterModel(letter: 'ন', pronunciation: 'no', phonetic: '/nɔ/', word: 'নদী', description: 'জলধারা', icon: '🌊', primaryColor: Color(0xFF95A5A6), secondaryColor: Color(0xFFBDC3C7)),

    LetterModel(letter: 'প', pronunciation: 'po', phonetic: '/pɔ/', word: 'পাখি', description: 'উড়ন্ত প্রাণী', icon: '🕊️', primaryColor: Color(0xFFF1C40F), secondaryColor: Color(0xFFF39C12)),
    LetterModel(letter: 'ফ', pronunciation: 'pho', phonetic: '/pʰɔ/', word: 'ফুল', description: 'গাছের সৌন্দর্য', icon: '🌸', primaryColor: Color(0xFF9B59B6), secondaryColor: Color(0xFF8E44AD)),
    LetterModel(letter: 'ব', pronunciation: 'bo', phonetic: '/bɔ/', word: 'বই', description: 'শিক্ষার মাধ্যম', icon: '📖', primaryColor: Color(0xFF2C3E50), secondaryColor: Color(0xFF34495E)),
    LetterModel(letter: 'ভ', pronunciation: 'bho', phonetic: '/bʱɔ/', word: 'ভাত', description: 'খাবার', icon: '🍚', primaryColor: Color(0xFF3498DB), secondaryColor: Color(0xFF2980B9)),
    LetterModel(letter: 'ম', pronunciation: 'mo', phonetic: '/mɔ/', word: 'মাছ', description: 'জলজ প্রাণী', icon: '🐟', primaryColor: Color(0xFF1ABC9C), secondaryColor: Color(0xFF16A085)),

    LetterModel(letter: 'য', pronunciation: 'zo', phonetic: '/zɔ/', word: 'যানবাহন', description: 'যাতায়াতের মাধ্যম', icon: '🚌', primaryColor: Color(0xFFE74C3C), secondaryColor: Color(0xFFC0392B)),
    LetterModel(letter: 'র', pronunciation: 'ro', phonetic: '/rɔ/', word: 'রোদ', description: 'সূর্যের আলো', icon: '☀️', primaryColor: Color(0xFFFF6B9D), secondaryColor: Color(0xFFFFA8E2)),
    LetterModel(letter: 'ল', pronunciation: 'lo', phonetic: '/lɔ/', word: 'লাল', description: 'একটি রং', icon: '🟥', primaryColor: Color(0xFFFFD93D), secondaryColor: Color(0xFFFF6B6B)),
    LetterModel(letter: 'শ', pronunciation: 'sho', phonetic: '/ʃɔ/', word: 'শিশু', description: 'ছোট বাচ্চা', icon: '🧒', primaryColor: Color(0xFF74B9FF), secondaryColor: Color(0xFF0984E3)),
    LetterModel(letter: 'ষ', pronunciation: 'ssho', phonetic: '/ʂɔ/', word: 'ষাঁড়', description: 'প্রাণী', icon: '🐂', primaryColor: Color(0xFF6C5CE7), secondaryColor: Color(0xFFA29BFE)),

    LetterModel(letter: 'স', pronunciation: 'so', phonetic: '/sɔ/', word: 'সাপ', description: 'সরীসৃপ', icon: '🐍', primaryColor: Color(0xFFE17055), secondaryColor: Color(0xFFFD79A8)),
    LetterModel(letter: 'হ', pronunciation: 'ho', phonetic: '/ɦɔ/', word: 'হাতি', description: 'বড় প্রাণী', icon: '🐘', primaryColor: Color(0xFF00CEC9), secondaryColor: Color(0xFF55EFC4)),
    LetterModel(letter: 'ড়', pronunciation: 'ro', phonetic: '/ɽɔ/', word: 'ড়াল', description: 'বিরল শব্দ', icon: '🔡', primaryColor: Color(0xFFFF6B6B), secondaryColor: Color(0xFFFFE66D)),
    LetterModel(letter: 'ঢ়', pronunciation: 'rho', phonetic: '/ɽʱɔ/', word: 'ঢ়', description: 'উচ্চারণ বিশেষ', icon: '🔠', primaryColor: Color(0xFF4ECDC4), secondaryColor: Color(0xFF45B7D1)),
    LetterModel(letter: 'য়', pronunciation: 'y', phonetic: '/jɔ/', word: 'বাংলায়', description: 'শব্দের অংশ', icon: '📝', primaryColor: Color(0xFFFF9FF3), secondaryColor: Color(0xFFF368E0)),

    LetterModel(letter: 'ক্ষ', pronunciation: 'kkho', phonetic: '/kʰjɔ/', word: 'ক্ষেত', description: 'ধানের ক্ষেত', icon: '🌱', primaryColor: Color(0xFF5F27CD), secondaryColor: Color(0xFF00D2D3)),
    LetterModel(letter: 'ত্র', pronunciation: 'tro', phonetic: '/trɔ/', word: 'ত্রিভুজ', description: 'জ্যামিতি আকার', icon: '🔺', primaryColor: Color(0xFFE55039), secondaryColor: Color(0xFFFA983A)),
    LetterModel(letter: 'জ্ঞ', pronunciation: 'ggno', phonetic: '/ɡdʒɔ/', word: 'জ্ঞ', description: 'জ্ঞান', icon: '📚', primaryColor: Color(0xFF3867D6), secondaryColor: Color(0xFF8854D0)),
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
    flutterTts.setLanguage("bn-US");
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