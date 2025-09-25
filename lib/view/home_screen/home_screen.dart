import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../custom_drawer_screen.dart';
import '../alphabet_screen/alphabet_screen.dart';
import '../bangla_alphabet_screen/bangla_alphabet_screen.dart';
import '../category_screen/bangla_kobita/bangla_kobita_list_screen.dart';
import '../category_screen/english_kobita/english_poems_list_screen.dart';
import '../puzzles_screen/puzzles_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _floatingController;
  late final AnimationController _pulseController;
  late final AnimationController _shimmerController;
  late final AnimationController _universeController;
  late final AnimationController _galaxyController;
  late AnimationController _particleController;
  late AnimationController _morphController;

  final GlobalKey _headerKey = GlobalKey();

  final List<StarParticle> _stars = [];
  final List<FloatingIsland> _islands = [];

  static const List<Color> _kidFriendlyColors = [
    Color(0xFF6366F1), // Indigo
    Color(0xFFEC4899), // Pink
    Color(0xFF10B981), // Emerald
    Color(0xFFF59E0B), // Amber
    Color(0xFF8B5CF6), // Violet
    Color(0xFF06B6D4), // Cyan
  ];

  final List<HomeCategoryModel> _categories = [
    HomeCategoryModel(title: 'ছড়া', subtitle: 'বাংলা ছড়া', slug: 'banglaKobita', icon: '📜', gradient: [Color(0xFF6366F1), Color(0xFF8B5CF6)], emoji: '🎵'),
    HomeCategoryModel(title: 'Poems', subtitle: 'English Poems', slug: 'englishPoems', icon: '📝', gradient: [Color(0xFFEC4899), Color(0xFFF97316)], emoji: '✨'),
    HomeCategoryModel(title: 'সংখ্যা', subtitle: 'বাংলা সংখ্যা', slug: 'banglaNumbers', icon: '🔢', gradient: [Color(0xFF10B981), Color(0xFF06B6D4)], emoji: '🎯'),
    HomeCategoryModel(title: 'Numbers', subtitle: 'English Numbers', slug: 'englishNumbers', icon: '🔟', gradient: [Color(0xFFF59E0B), Color(0xFFEF4444)], emoji: '🌟'),
    HomeCategoryModel(title: 'অক্ষর', subtitle: 'বাংলা অক্ষর', slug: 'banglaAlphabet', icon: '🅱️', gradient: [Color(0xFF8B5CF6), Color(0xFFEC4899)], emoji: '🎨'),
    HomeCategoryModel(title: 'Alphabet', subtitle: 'English Alphabet', slug: 'englishAlphabet', icon: '🔤', gradient: [Color(0xFF06B6D4), Color(0xFF6366F1)], emoji: '🚀'),
    HomeCategoryModel(title: 'Puzzles', subtitle: 'Brain Games', slug: 'puzzles', icon: '🧩', gradient: [Color(0xFFF97316), Color(0xFF10B981)], emoji: '🧠'),
    HomeCategoryModel(title: 'Drawing', subtitle: 'Creative Art', slug: 'drawing', icon: '🎨', gradient: [Color(0xFFEF4444), Color(0xFF8B5CF6)], emoji: '🎪'),
  ];

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _generateCosmicElements();
  }

  void _initAnimations() {
    _floatingController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _shimmerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _universeController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();

    _galaxyController = AnimationController(
      duration: const Duration(seconds: 25),
      vsync: this,
    )..repeat();

    _morphController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _particleController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat();
  }

  void _generateCosmicElements() {
    final random = Random();

    // Generate stars
    _stars.clear();
    for (int i = 0; i < 100; i++) {
      _stars.add(StarParticle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 3 + 1,
        twinkleSpeed: random.nextDouble() * 0.5 + 0.3,
        brightness: random.nextDouble(),
      ));
    }

    // Generate floating islands
    _islands.clear();
    for (int i = 0; i < 5; i++) {
      _islands.add(FloatingIsland(
        x: random.nextDouble() * 0.8 + 0.1,
        y: random.nextDouble() * 0.6 + 0.2,
        size: random.nextDouble() * 30 + 40,
        floatSpeed: random.nextDouble() * 0.3 + 0.2,
        color: _kidFriendlyColors[random.nextInt(_kidFriendlyColors.length)],
      ));
    }
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    _universeController.dispose();
    _galaxyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.5, -0.8),
            radius: 1.5,
            colors: [
              Color(0xFF1E1B4B),
              Color(0xFF312E81),
              Color(0xFF1E40AF),
              Color(0xFF0C4A6E),
            ],
          ),
        ),
        child: Stack(
          children: [
            _buildCosmicBackground(),

            // Main content
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  key: _headerKey,
                  expandedHeight: 70,
                  floating: false,
                  pinned: true,
                  elevation: 0,
                  centerTitle: true,
                  title: AnimatedBuilder(
                    animation: _shimmerController,
                    builder: (context, child) {
                      return ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: const [
                              Colors.white,
                              Color(0xFF6366F1),
                              Colors.white,
                            ],
                            stops: [
                              (_shimmerController.value - 0.3).clamp(0.0, 1.0),
                              _shimmerController.value,
                              (_shimmerController.value + 0.3).clamp(0.0, 1.0),
                            ],
                          ).createShader(bounds);
                        },
                        child: const Text(
                          'ভবিষ্যতের শিক্ষা 🌟',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                  backgroundColor: Colors.transparent,
                  leading: Container(
                    margin: const EdgeInsets.all(8),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: IconButton(
                          onPressed: () {
                            Get.to(() => const CustomDrawerScreen());
                          },
                          icon: const Icon(Icons.menu_rounded, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    height: 120,
                    child: AnimatedBuilder(
                      animation: _morphController,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateX(sin(_morphController.value * 2 * pi) * 0.05),
                          alignment: Alignment.center,
                          child: ClipPath(
                            clipper: MagicalPortalClipper(_morphController.value),
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
                                    // Magical particles
                                    CustomPaint(
                                      size: const Size(double.infinity, 120),
                                      painter: MagicalParticlesPainter(_particleController.value),
                                    ),
                                    // Content
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
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.all(10),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) => _buildCategoryCard(index),
                      childCount: _categories.length,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 40),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCosmicBackground() {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _universeController,
          builder: (context, child) {
            final screenSize = MediaQuery.of(context).size;
            return Stack(
              children: _stars.map((star) {
                final twinkle = sin(_universeController.value * 2 * pi * star.twinkleSpeed) * 0.5 + 0.5;
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
          animation: _galaxyController,
          builder: (context, child) {
            return CustomPaint(
              size: MediaQuery.of(context).size,
              painter: NebulaPainter(_galaxyController.value),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard(int index) {
    final category = _categories[index];

    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            sin(_floatingController.value * 2 * pi + index * 0.5) * 3,
            cos(_floatingController.value * 2 * pi + index * 0.7) * 3,
          ),
          child: GestureDetector(
            onTapDown: (_) => HapticFeedback.mediumImpact(),
            onTap: () {
              HapticFeedback.mediumImpact();
              _handleCategoryTap(category);
            },
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final scale = 1.0 + sin(_pulseController.value * 2 * pi + index) * 0.02;
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
                              animation: _shimmerController,
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
                                    animation: _pulseController,
                                    builder: (context, child) {
                                      final iconScale = 1.0 + sin(_pulseController.value * 3 * pi + index) * 0.1;
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

  void _handleCategoryTap(HomeCategoryModel category) {
    HapticFeedback.mediumImpact();
    switch (category.slug) {
      case 'banglaKobita':
        Get.to(() => BanglaKobitaListScreen());
        break;
      case 'englishPoems':
        Get.to(() => EnglishPoemsListScreen());
        break;
      case 'banglaNumbers':
        Get.to(() => HomeScreen());
        break;
      case 'englishNumbers':
        Get.to(() => HomeScreen());
        break;
      case 'banglaAlphabet':
        Get.to(() => BanglaAlphabetScreen());
        break;
      case 'englishAlphabet':
        Get.to(() => AlphabetScreen());
        break;
      case 'puzzles':
        Get.to(() => PuzzlesScreen());
        break;
      case 'drawing':
        Get.to(() => HomeScreen());
        break;
      default:
        Get.to(() => HomeScreen());
    }
  }
}

// Data models and helper classes
class HomeCategoryModel {
  final String title;
  final String subtitle;
  final String slug;
  final String icon;
  final List<Color> gradient;
  final String emoji;

  HomeCategoryModel({
    required this.title,
    required this.subtitle,
    required this.slug,
    required this.icon,
    required this.gradient,
    required this.emoji,
  });
}

class StarParticle {
  final double x, y, size, twinkleSpeed, brightness;
  StarParticle({
    required this.x,
    required this.y,
    required this.size,
    required this.twinkleSpeed,
    required this.brightness,
  });
}

class FloatingIsland {
  final double x, y, size, floatSpeed;
  final Color color;
  FloatingIsland({
    required this.x,
    required this.y,
    required this.size,
    required this.floatSpeed,
    required this.color,
  });
}

// Custom painters
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

    // Create magical wavy edges
    path.moveTo(0, waveHeight);

    // Top wavy edge
    for (double x = 0; x <= size.width; x += 5) {
      final y = waveHeight * sin((x / size.width) * frequency * pi + value * 2 * pi) + waveHeight;
      path.lineTo(x, y);
    }

    // Right wavy edge
    for (double y = waveHeight; y <= size.height - waveHeight; y += 5) {
      final x = size.width - waveHeight * sin((y / size.height) * frequency * pi + value * 2 * pi + pi/2) - waveHeight;
      path.lineTo(x, y);
    }

    // Bottom wavy edge
    for (double x = size.width; x >= 0; x -= 5) {
      final y = size.height - waveHeight * sin((x / size.width) * frequency * pi + value * 2 * pi + pi) - waveHeight;
      path.lineTo(x, y);
    }

    // Left wavy edge
    for (double y = size.height - waveHeight; y >= waveHeight; y -= 5) {
      final x = waveHeight * sin((y / size.height) * frequency * pi + value * 2 * pi + 3*pi/2) + waveHeight;
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
    final random = Random(42); // Fixed seed for consistent pattern

    // Draw magical floating particles
    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final particleProgress = (progress + i * 0.1) % 1.0;
      final opacity = sin(particleProgress * 2 * pi) * 0.5 + 0.5;
      final scale = 0.5 + opacity * 0.5;

      // Different magical symbols
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
