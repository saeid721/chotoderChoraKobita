import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../custom_drawer_screen.dart';
import '../alphabet_screen/alphabet_screen.dart';
import '../bangla_alphabet_screen/bangla_alphabet_screen.dart';
import '../bangla_kobita_screen/bangla_kobita_list_screen.dart';
import '../english_poem_screen/english_poems_list_screen.dart';
import '../puzzles_screen/puzzles_screen.dart';
import 'components/cosmic_background.dart';
import 'components/home_category_model.dart';
import 'components/home_widget.dart';
import 'controller/home_animation_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final HomeAnimationController _animationController;
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
    _animationController = HomeAnimationController(vsync: this)..init();
    _generateCosmicElements();
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
    _animationController.dispose();
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
            CosmicBackground(
              universeController: _animationController.universeController,
              galaxyController: _animationController.galaxyController,
              stars: _stars,
            ),
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  key: _headerKey,
                  expandedHeight: 60,
                  floating: false,
                  pinned: true,
                  elevation: 0,
                  centerTitle: true,
                  title: AnimatedBuilder(
                    animation: _animationController.shimmerController,
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
                              (_animationController.shimmerController.value - 0.3).clamp(0.0, 1.0),
                              _animationController.shimmerController.value,
                              (_animationController.shimmerController.value + 0.3).clamp(0.0, 1.0),
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
                  child: MagicalPortal(
                    morphController: _animationController.morphController,
                    particleController: _animationController.particleController,
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
                          (context, index) => CategoryCard(
                        category: _categories[index],
                        index: index,
                        floatingController: _animationController.floatingController,
                        pulseController: _animationController.pulseController,
                        shimmerController: _animationController.shimmerController,
                        onTap: _handleCategoryTap,
                      ),
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