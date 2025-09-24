import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../custom_drawer_screen.dart';
import '../alphabet_screen/alphabet_screen.dart';
import '../app_exit_dialog.dart';
import '../bangla_alphabet_screen/bangla_alphabet_screen.dart';
import '../category_screen/bangla_kobita/bangla_kobita_list_screen.dart';
import '../category_screen/english_kobita/english_poems_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController primaryController;
  late AnimationController orbitalController;
  late AnimationController pulseController;
  late AnimationController morphController;
  late AnimationController particleController;

  final List<Map<String, dynamic>> particles = [];

  @override
  void initState() {
    super.initState();
    primaryController = AnimationController(duration: const Duration(seconds: 4), vsync: this)..repeat();
    orbitalController =  AnimationController(duration: const Duration(seconds: 8), vsync: this)..repeat();
    pulseController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this) ..repeat(reverse: true);
    morphController = AnimationController(duration: const Duration(seconds: 6), vsync: this)..repeat();
    particleController = AnimationController(duration: const Duration(seconds: 15), vsync: this)..repeat();

    _generateParticles();
  }

  void _generateParticles() {
    final random = Random();
    for (int i = 0; i < 20; i++) {
      particles.add({
        'x': random.nextDouble(),
        'y': random.nextDouble(),
        'size': random.nextDouble() * 4 + 2,
        'speed': random.nextDouble() * 0.5 + 0.2,
        'color': [
          Colors.cyan,
          Colors.pink,
          Colors.purple,
          Colors.yellow,
          Colors.green,
        ][random.nextInt(5)],
      });
    }
  }

  @override
  void dispose() {
    primaryController.dispose();
    orbitalController.dispose();
    pulseController.dispose();
    morphController.dispose();
    particleController.dispose();
    super.dispose();
  }

  final homeScreenCategories = [
      {'title': 'ছড়া', 'subtitle': 'বাংলা ছড়া', 'icon': '📜', 'colors': [Color(0xFF667eea), Color(0xFF764ba2)]},
      {'title': 'Poems', 'subtitle': 'English Poems', 'icon': '📝', 'colors': [Color(0xFFf093fb), Color(0xFFf5576c)]},
      {'title': 'সংখ্যা', 'subtitle': 'বাংলা সংখ্যা', 'icon': '🔢', 'colors': [Color(0xFF36d1dc), Color(0xFF5b86e5)]},
      {'title': 'Numbers', 'subtitle': 'English Numbers', 'icon': '🔟', 'colors': [Color(0xFFff9a9e), Color(0xFFfad0c4)]},
      {'title': 'অক্ষর', 'subtitle': 'বাংলা অক্ষর', 'icon': '🅱️', 'colors': [Color(0xFF4facfe), Color(0xFF00f2fe)]},
      {'title': 'Alphabet', 'subtitle': 'English Alphabet', 'icon': '🔤', 'colors': [Color(0xFFfbc2eb), Color(0xFFa6c1ee)]},
      {'title': 'Puzzles', 'subtitle': 'Brain Games', 'icon': '🧩', 'colors': [Color(0xFFffecd2), Color(0xFFfcb69f)]},
      {'title': 'Drawing', 'subtitle': 'Creative Art', 'icon': '🎨', 'colors': [Color(0xFFa8c0ff), Color(0xFF3f2b96)]},
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        HapticFeedback.mediumImpact();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AppExitDialog(
            title: "",
            message: "তুমি কি অ্যাপ থেকে বের হতে চাও?",
            onTap: () => SystemNavigator.pop(),
          ),
        );
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBarWidget(
          morphController: morphController,
          pulseController: pulseController,
          primaryController: primaryController,
        ),
        drawer: const CustomDrawerScreen(),
        body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 2.0,
              colors: [
                Color(0xFF1a1a2e),
                Color(0xFF16213e),
                Color(0xFF0f3460),
                Color(0xFF533483),
              ],
            ),
          ),
          child: Stack(
            children: [
              AnimatedBackground(primaryController: primaryController),
              ParticleSystem(particleController: particleController, particles: particles),
              NeuralNetwork(orbitalController: orbitalController),
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 150,
                      margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
                      child: AnimatedBuilder(
                        animation: pulseController,
                        builder: (context, child) {
                          return Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.003)
                              ..rotateX(pulseController.value * 0.1),
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withOpacity(0.1),
                                        Colors.cyan.withOpacity(0.1),
                                        Colors.purple.withOpacity(0.1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
                                  ),
                                  child: Stack(
                                    children: [
                                      CustomPaint(
                                        size: const Size(double.infinity, 200),
                                        painter: GridPainter(morphController.value),
                                      ),
                                      Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            AnimatedBuilder(
                                              animation: primaryController,
                                              builder: (context, child) {
                                                return Transform.scale(
                                                  scale: 1.0 +
                                                      sin(primaryController.value * 4 * pi) * 0.1,
                                                  child: const Icon(Icons.rocket_launch,
                                                      size: 50, color: Colors.cyan),
                                                );
                                              },
                                            ),
                                            const SizedBox(height: 16),
                                            ShaderMask(
                                              shaderCallback: (bounds) => const LinearGradient(
                                                colors: [Colors.cyan, Colors.pink, Colors.yellow],
                                              ).createShader(bounds),
                                              child: const Text(
                                                'ডিজিটাল শিক্ষার নতুন যুগ!',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
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
                    padding: const EdgeInsets.all(20),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.25,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final category = homeScreenCategories[index];
                          return HomeMenuWidget(
                            title: category['title'] as String,
                            subtitle: category['subtitle'] as String,
                            icon: category['icon'] as String,
                            colors: category['colors'] as List<Color>,
                            index: index,
                            orbitalController: orbitalController,
                            pulseController: pulseController,
                            primaryController: primaryController,
                            morphController: morphController,
                            particleController: particleController,
                          );
                        },
                        childCount: homeScreenCategories.length,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =================== REUSABLE WIDGETS ===================

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final AnimationController morphController;
  final AnimationController pulseController;
  final AnimationController primaryController;

  const CustomAppBarWidget({
    super.key,
    required this.morphController,
    required this.pulseController,
    required this.primaryController,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: morphController,
      builder: (context, child) {
        return ClipPath(
          clipper: WaveClipper(morphController.value),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.cyan.withOpacity(0.1),
                    Colors.purple.withOpacity(0.1),
                    Colors.pink.withOpacity(0.1),
                  ],
                ),
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.white, size: 28),
                title: AnimatedBuilder(
                  animation: pulseController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (pulseController.value * 0.1),
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            Colors.cyan,
                            Colors.pink,
                            Colors.yellow,
                            Colors.purple,
                          ],
                          stops: [
                            (primaryController.value - 0.3).clamp(0.0, 1.0),
                            (primaryController.value - 0.1).clamp(0.0, 1.0),
                            (primaryController.value + 0.1).clamp(0.0, 1.0),
                            (primaryController.value + 0.3).clamp(0.0, 1.0),
                          ],
                        ).createShader(bounds),
                        child: const Text(
                          "🚀 ভবিষ্যতের শিক্ষা 🌟",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  final AnimationController primaryController;
  const AnimatedBackground({super.key, required this.primaryController});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: primaryController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(
                cos(primaryController.value * 2 * pi) * 0.5,
                sin(primaryController.value * 2 * pi) * 0.5,
              ),
              radius: 1.5,
              colors: [
                Color.lerp(const Color(0xFF1a1a2e), const Color(0xFF533483),
                    sin(primaryController.value * 2 * pi) * 0.5 + 0.5)!,
                const Color(0xFF16213e),
                const Color(0xFF0f3460),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ParticleSystem extends StatelessWidget {
  final AnimationController particleController;
  final List<Map<String, dynamic>> particles;
  const ParticleSystem({super.key, required this.particleController, required this.particles});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: particleController,
      builder: (context, child) {
        return Stack(
          children: particles.map((particle) {
            final progress = (particleController.value + particle['speed']) % 1.0;
            final screenWidth = MediaQuery.of(context).size.width;
            final screenHeight = MediaQuery.of(context).size.height;

            return Positioned(
              left: (particle['x'] * screenWidth + cos(progress * 2 * pi) * 50) % screenWidth,
              top: (particle['y'] * screenHeight + sin(progress * 2 * pi) * 30) % screenHeight,
              child: Container(
                width: particle['size'],
                height: particle['size'],
                decoration: BoxDecoration(
                  color: particle['color'].withOpacity(0.3 + sin(progress * 4 * pi) * 0.3),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: particle['color'].withOpacity(0.5),
                      blurRadius: particle['size'] * 2,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class NeuralNetwork extends StatelessWidget {
  final AnimationController orbitalController;
  const NeuralNetwork({super.key, required this.orbitalController});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: orbitalController,
      builder: (context, child) {
        return CustomPaint(
          size: MediaQuery.of(context).size,
          painter: NeuralNetworkPainter(orbitalController.value),
        );
      },
    );
  }
}

class HomeMenuWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final List<Color> colors;
  final int index;
  final AnimationController orbitalController;
  final AnimationController pulseController;
  final AnimationController primaryController;
  final AnimationController morphController;
  final AnimationController particleController;

  const HomeMenuWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colors,
    required this.index,
    required this.orbitalController,
    required this.pulseController,
    required this.primaryController,
    required this.morphController,
    required this.particleController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: orbitalController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            sin(orbitalController.value * 2 * pi + index) * 5,
            cos(orbitalController.value * 2 * pi + index) * 5,
          ),
          child: GestureDetector(
            onTapDown: (_) => HapticFeedback.mediumImpact(),
            onTap: () {
              HapticFeedback.mediumImpact();
              switch (title) {
                case 'ছড়া':
                  Get.to(() => BanglaKobitaListScreen());
                  break;
                case 'Poems':
                  Get.to(() => EnglishPoemsListScreen());
                  break;
                case 'সংখ্যা':
                  Get.to(() => HomeScreen());
                  break;
                case 'Numbers':
                  Get.to(() => HomeScreen());
                  break;
                case 'অক্ষর':
                  Get.to(() => BanglaAlphabetScreen());
                  break;
                case 'Alphabet':
                  Get.to(() => AlphabetScreen());
                  break;
                case 'Puzzles':
                  Get.to(() => HomeScreen());
                  break;
                case 'Drawing':
                  Get.to(() => HomeScreen());
                  break;
                default:
                  Get.to(() => HomeScreen());
              }
            },
            child: AnimatedBuilder(
              animation: pulseController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 +
                      sin(pulseController.value * 2 * pi + index * 0.5) * 0.02,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              colors[0].withOpacity(0.2),
                              colors[1].withOpacity(0.1),
                              Colors.white.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              width: 1.5,
                              color: Colors.white.withOpacity(0.1)),
                          boxShadow: [
                            BoxShadow(
                              color: colors[0].withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: -5,
                            )
                          ],
                        ),
                        child: Stack(
                          children: [
                            AnimatedBuilder(
                              animation: primaryController,
                              builder: (context, child) {
                                return Positioned.fill(
                                  child: CustomPaint(
                                    painter: GlowPainter(primaryController.value,
                                        colors[0]),
                                  ),
                                );
                              },
                            ),
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    icon,
                                    style: const TextStyle(fontSize: 36),
                                  ),
                                  const SizedBox(height: 12),
                                  ShaderMask(
                                    shaderCallback: (bounds) =>
                                        LinearGradient(colors: colors)
                                            .createShader(bounds),
                                    child: Text(
                                      title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    subtitle,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
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
}

// =================== Animation ===================

class WaveClipper extends CustomClipper<Path> {
  final double value;
  WaveClipper(this.value);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.7);

    final controlPoint1 =
    Offset(size.width * 0.25, size.height * (0.7 + 0.1 * sin(value * 2 * pi)));
    final endPoint1 = Offset(size.width * 0.5, size.height * 0.7);
    path.quadraticBezierTo(
        controlPoint1.dx, controlPoint1.dy, endPoint1.dx, endPoint1.dy);

    final controlPoint2 =
    Offset(size.width * 0.75, size.height * (0.7 - 0.1 * sin(value * 2 * pi)));
    final endPoint2 = Offset(size.width, size.height * 0.7);
    path.quadraticBezierTo(
        controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant WaveClipper oldClipper) => true;
}

class NeuralNetworkPainter extends CustomPainter {
  final double progress;
  NeuralNetworkPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final nodes = [
      Offset(size.width * 0.2, size.height * 0.3),
      Offset(size.width * 0.5, size.height * 0.2),
      Offset(size.width * 0.8, size.height * 0.35),
      Offset(size.width * 0.3, size.height * 0.6),
      Offset(size.width * 0.7, size.height * 0.65),
    ];

    for (final node in nodes) {
      canvas.drawCircle(
          node, 3 + sin(progress * 2 * pi) * 1.5, paint..style = PaintingStyle.fill);
    }

    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final opacity = 0.05 + sin(progress * 2 * pi + i + j) * 0.05;
        paint.color = Colors.white.withOpacity(opacity);
        canvas.drawLine(nodes[i], nodes[j], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant NeuralNetworkPainter oldDelegate) => true;
}

class GridPainter extends CustomPainter {
  final double value;
  GridPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    const spacing = 20.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
          Offset(x, 0),
          Offset(x, size.height),
          paint..color = Colors.white.withOpacity(0.05 + sin(value * 2 * pi) * 0.02));
    }

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
          Offset(0, y),
          Offset(size.width, y),
          paint..color = Colors.white.withOpacity(0.05 + cos(value * 2 * pi) * 0.02));
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) => true;
}

class GlowPainter extends CustomPainter {
  final double progress;
  final Color color;
  GlowPainter(this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide * 0.5;
    final glowRadius = radius * (0.7 + sin(progress * 2 * pi) * 0.2);

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withOpacity(0.3),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: glowRadius));

    canvas.drawCircle(center, glowRadius, paint);
  }

  @override
  bool shouldRepaint(covariant GlowPainter oldDelegate) => true;
}
