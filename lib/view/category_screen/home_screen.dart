import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/widget/enum.dart';
import '../../global/widget/global_app_bar.dart';
import '../../custom_drawer_screen.dart';
import '../../global/widget/global_image_loader.dart';
import '../../global/widget/images.dart';
import 'bangla_kobita/bangla_kobita_list_screen.dart';
import 'english_kobita/english_poems_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int currentIndex = 0;
  CarouselSliderController buttonCarouselController = CarouselSliderController();
  late AnimationController _bounceController;
  late AnimationController _floatingController;

  final List<String> sliderImage = [
    'assets/images/01.png',
    'assets/images/02.png',
    'assets/images/03.jpg',
    'assets/images/04.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(
        title: "ছোটদের ছড়া-কবিতা",
      ),
      drawer: const CustomDrawerScreen(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFE6F0), // Light pink
              Color(0xFFB3E5FC), // Light blue
              Color(0xFFE8F5E8), // Light green
              Color(0xFFFFF3E0), // Light orange
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Floating decorative elements
            ...List.generate(5, (index) => _buildFloatingElement(index)),

            // Main content
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  // Welcome message with animation
                  AnimatedBuilder(
                    animation: _bounceController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + (_bounceController.value * 0.05),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF9A9E), Color(0xFFFAD0C4)],
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pink.withValues(alpha:0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.auto_stories, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                '🌈 স্বাগতম! পড়ার জগতে! 📚',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Enhanced carousel with fun animations
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha:0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: CarouselSlider(
                        items: sliderImage
                            .map(
                              (item) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFFFFE6F0), Color(0xFFB3E5FC)],
                              ),
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                // Sparkle overlay
                                Positioned.fill(
                                  child: AnimatedBuilder(
                                    animation: _floatingController,
                                    builder: (context, child) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.white.withValues(alpha:0.1 * _floatingController.value),
                                              Colors.transparent,
                                              Colors.white.withValues(alpha: 0.05 * _floatingController.value),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                            .toList(),
                        carouselController: buttonCarouselController,
                        options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          aspectRatio: 2,
                          viewportFraction: 1,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Enhanced page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: sliderImage.asMap().entries.map((entry) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: currentIndex == entry.key ? 8 : 6,
                        width: currentIndex == entry.key ? 25 : 12,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: currentIndex == entry.key
                                ? [const Color(0xFFFF6B6B), const Color(0xFFFFE66D)]
                                : [Colors.grey.shade300, Colors.grey.shade400],
                          ),
                          boxShadow: currentIndex == entry.key
                              ? [
                            BoxShadow(
                              color: const Color(0xFFFF6B6B).withValues(alpha:0.5),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                              : [],
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 25),

                  // Fun category cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildAnimatedCategoryCard(
                          imagePath: 'assets/images/bangla.png',
                          title: 'বাংলা 🇧🇩',
                          subtitle: 'মজার ছড়া',
                          colors: [const Color(0xFF667eea), const Color(0xFF764ba2)],
                          onTap: () => Get.to(() => const BanglaKobitaListScreen()),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildAnimatedCategoryCard(
                          imagePath: 'assets/images/english.png',
                          title: 'English 🇬🇧',
                          subtitle: 'Fun Poems',
                          colors: [const Color(0xFFf093fb), const Color(0xFFf5576c)],
                          onTap: () => Get.to(() => const EnglishPoemsListScreen()),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Bottom mascot with bounce animation
                  AnimatedBuilder(
                    animation: _bounceController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, -10 * _bounceController.value),
                        child: GlobalImageLoader(
                          imagePath: Images.splashScreen,
                          width: Get.width * 0.7,
                          fit: BoxFit.contain,
                          imageFor: ImageFor.asset,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingElement(int index) {
    final icons = ['🦄', '🌈', '🎪', '🎨', '🚀', '⭐', '✨', '🎭', '🎯', '🧸'];
    final colors = [
      Colors.pink, Colors.purple, Colors.blue, Colors.green,
      Colors.orange, Colors.red, Colors.yellow, Colors.indigo,
      Colors.teal, Colors.amber
    ];

    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Positioned(
          top: 100 + (index * 120) + (20 * _floatingController.value),
          left: (index.isEven ? 50 : Get.width - 100) + (10 * _floatingController.value),
          child: Opacity(
            opacity: 0.3 + (0.4 * _floatingController.value),
            child: Text(
              icons[index],
              style: TextStyle(
                fontSize: 24,
                color: colors[index],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedCategoryCard({
    required String imagePath,
    required String title,
    required String subtitle,
    required List<Color> colors,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        // Add a small bounce animation on tap
        _bounceController.forward().then((_) => _bounceController.reverse());
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colors[0].withValues(alpha:0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white.withValues(alpha:0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha:0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      imagePath,
                      height: 35,
                      width: 35,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha:0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow icon
            const Positioned(
              top: 15,
              right: 15,
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}