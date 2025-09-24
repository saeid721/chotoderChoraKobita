import 'dart:ui';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../custom_drawer_screen.dart';
import '../alphabet_screen/alphabet_screen.dart';
import '../app_exit_dialog.dart';
import '../bangla_alphabet_screen/bangla_alphabet_screen.dart';
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
  late AnimationController _primaryController;
  late AnimationController _orbitalController;
  late AnimationController _pulseController;
  late AnimationController _morphController;
  late AnimationController _particleController;

  final List<String> sliderImage = [
    'assets/images/01.png',
    'assets/images/02.png',
    'assets/images/03.png',
  ];

  final List<Map<String, dynamic>> particles = [];

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _generateParticles();
  }

  void _initAnimations() {
    _primaryController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _orbitalController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _morphController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();

    _particleController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
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
    _primaryController.dispose();
    _orbitalController.dispose();
    _pulseController.dispose();
    _morphController.dispose();
    _particleController.dispose();
    super.dispose();
  }

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
        appBar: _buildNeuralAppBar(),
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
              _buildAnimatedBackground(),
              _buildParticleSystem(),
              _buildNeuralNetwork(),
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  _buildHeroSection(),
                  _buildQuantumGrid(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildNeuralAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: AnimatedBuilder(
        animation: _morphController,
        builder: (context, child) {
          return ClipPath(
            clipper: WaveClipper(_morphController.value),
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
                    animation: _pulseController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + (_pulseController.value * 0.1),
                        child: ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              Colors.cyan,
                              Colors.pink,
                              Colors.yellow,
                              Colors.purple,
                            ],
                            stops: [
                              (_primaryController.value - 0.3).clamp(0.0, 1.0),
                              (_primaryController.value - 0.1).clamp(0.0, 1.0),
                              (_primaryController.value + 0.1).clamp(0.0, 1.0),
                              (_primaryController.value + 0.3).clamp(0.0, 1.0),
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
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _primaryController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(
                cos(_primaryController.value * 2 * pi) * 0.5,
                sin(_primaryController.value * 2 * pi) * 0.5,
              ),
              radius: 1.5,
              colors: [
                Color.lerp(const Color(0xFF1a1a2e), const Color(0xFF533483),
                    sin(_primaryController.value * 2 * pi) * 0.5 + 0.5)!,
                const Color(0xFF16213e),
                const Color(0xFF0f3460),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildParticleSystem() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return Stack(
          children: particles.map((particle) {
            final progress = (_particleController.value + particle['speed']) % 1.0;
            final screenWidth = MediaQuery.of(context).size.width;
            final screenHeight = MediaQuery.of(context).size.height;

            return Positioned(
              left: (particle['x'] * screenWidth +
                  cos(progress * 2 * pi) * 50) % screenWidth,
              top: (particle['y'] * screenHeight +
                  sin(progress * 2 * pi) * 30) % screenHeight,
              child: Container(
                width: particle['size'],
                height: particle['size'],
                decoration: BoxDecoration(
                  color: particle['color'].withOpacity(
                      0.3 + sin(progress * 4 * pi) * 0.3),
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

  Widget _buildNeuralNetwork() {
    return AnimatedBuilder(
      animation: _orbitalController,
      builder: (context, child) {
        return CustomPaint(
          size: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height),
          painter: NeuralNetworkPainter(_orbitalController.value),
        );
      },
    );
  }

  Widget _buildHeroSection() {
    return SliverToBoxAdapter(
      child: Container(
        height: 150,
        margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.003) // Perspective
                ..rotateX(_pulseController.value * 0.1), // X-axis rotation
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.cyan.withOpacity(0.1),
                          Colors.purple.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // 3D Grid Background
                        CustomPaint(
                          size: const Size(double.infinity, 200),
                          painter: GridPainter(_morphController.value),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedBuilder(
                                animation: _primaryController,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: 1.0 + sin(_primaryController.value * 4 * pi) * 0.1,
                                    child: const Icon(
                                      Icons.rocket_launch,
                                      size: 50,
                                      color: Colors.cyan,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
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
  }


  Widget _buildQuantumGrid() {
    final categories = [
      {'title':'ছড়া','subtitle':'বাংলা ছড়া','icon':'📜','colors':[const Color(0xFF667eea),const Color(0xFF764ba2)]},
      {'title':'Poems','subtitle':'English Poems','icon':'📝','colors':[const Color(0xFFf093fb),const Color(0xFFf5576c)]},
      {'title':'সংখ্যা','subtitle':'বাংলা সংখ্যা','icon':'🔢','colors':[const Color(0xFF36d1dc),const Color(0xFF5b86e5)]},
      {'title':'Numbers','subtitle':'English Numbers','icon':'🔟','colors':[const Color(0xFFff9a9e),const Color(0xFFfad0c4)]},
      {'title':'অক্ষর','subtitle':'বাংলা অক্ষর','icon':'🅱️','colors':[const Color(0xFF4facfe),const Color(0xFF00f2fe)]},
      {'title':'Alphabet','subtitle':'English Alphabet','icon':'🔤','colors':[const Color(0xFFfbc2eb),const Color(0xFFa6c1ee)]},
      {'title':'Puzzles','subtitle':'Brain Games','icon':'🧩','colors':[const Color(0xFFffecd2),const Color(0xFFfcb69f)]},
      {'title':'Drawing','subtitle':'Creative Art','icon':'🎨','colors':[const Color(0xFFa8c0ff),const Color(0xFF3f2b96)]}
    ];


    return SliverPadding(
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
            final category = categories[index];
            return _buildQuantumCard(
              title: category['title'] as String,
              subtitle: category['subtitle'] as String,
              icon: category['icon'] as String,
              colors: category['colors'] as List<Color>,
              index: index,
            );
          },
          childCount: categories.length,
        ),
      ),
    );
  }

  Widget _buildQuantumCard({
    required String title,
    required String subtitle,
    required String icon,
    required List<Color> colors,
    required int index,
  }) {
    return AnimatedBuilder(
      animation: _orbitalController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            sin(_orbitalController.value * 2 * pi + index) * 5,
            cos(_orbitalController.value * 2 * pi + index) * 5,
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
              animation: _pulseController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + sin(_pulseController.value * 2 * pi + index * 0.5) * 0.02,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              colors[0].withOpacity(0.2),
                              colors[1].withOpacity(0.1),
                              Colors.white.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            width: 2,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Animated grid pattern
                            CustomPaint(
                              size: const Size(double.infinity, double.infinity),
                              painter: CardGridPainter(
                                _morphController.value + index * 0.2,
                                colors[0],
                              ),
                            ),

                            // Content
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Icon with glow effect
                                    AnimatedBuilder(
                                      animation: _primaryController,
                                      builder: (context, child) {
                                        return Text(
                                          icon,
                                          style: TextStyle(
                                            fontSize: 30,
                                            shadows: [
                                              Shadow(
                                                color: colors[0],
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 5),


                                    // Text content
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ShaderMask(
                                          shaderCallback: (bounds) => LinearGradient(
                                            colors: [colors[0], colors[1]],
                                          ).createShader(bounds),
                                          child: Text(
                                            title,
                                            style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          subtitle,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white.withOpacity(0.8),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Holographic shine effect
                            AnimatedBuilder(
                              animation: _particleController,
                              builder: (context, child) {
                                return Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      gradient: LinearGradient(
                                        begin: Alignment(-1.0 + _particleController.value * 2, -1),
                                        end: Alignment(1.0 + _particleController.value * 2, 1),
                                        colors: [
                                          Colors.transparent,
                                          Colors.white.withOpacity(0.1),
                                          Colors.transparent,
                                        ],
                                        stops: const [0.0, 0.5, 1.0],
                                      ),
                                    ),
                                  ),
                                );
                              },
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

// Custom Painters for Visual Effects

class WaveClipper extends CustomClipper<Path> {
  final double animationValue;
  WaveClipper(this.animationValue);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);

    for (double x = 0; x <= size.width; x += 10) {
      final y = size.height - 20 + sin((x / size.width * 4 * pi) + (animationValue * 2 * pi)) * 10;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class NeuralNetworkPainter extends CustomPainter {
  final double animationValue;
  NeuralNetworkPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyan.withOpacity(0.1)
      ..strokeWidth = 1;

    // Draw neural network connections
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        final x1 = (i / 10) * size.width;
        final y1 = (j / 10) * size.height;
        final x2 = ((i + 1) / 10) * size.width;
        final y2 = ((j + 1) / 10) * size.height;

        paint.color = Colors.cyan.withOpacity(
            0.1 * sin(animationValue * 2 * pi + i + j)
        );

        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class GridPainter extends CustomPainter {
  final double animationValue;
  GridPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyan.withOpacity(0.1)
      ..strokeWidth = 0.5;

    // Draw 3D grid
    for (int i = 0; i < 20; i++) {
      final offset = sin(animationValue * 2 * pi + i) * 5;
      canvas.drawLine(
        Offset(i * size.width / 20, 0),
        Offset(i * size.width / 20 + offset, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CardGridPainter extends CustomPainter {
  final double animationValue;
  final Color color;
  CardGridPainter(this.animationValue, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.05)
      ..strokeWidth = 0.5;

    // Draw animated grid pattern
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        final x = (i / 10) * size.width;
        final y = (j / 10) * size.height;
        final offset = sin(animationValue * 2 * pi + i + j) * 3;

        paint.color = color.withOpacity(0.05 + 0.05 * sin(animationValue * 2 * pi + i));
        canvas.drawCircle(Offset(x + offset, y + offset), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class WavePainter extends CustomPainter {
  final double animationValue;
  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.cyan.withOpacity(0.3),
          Colors.purple.withOpacity(0.3),
          Colors.pink.withOpacity(0.3),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    path.moveTo(0, size.height / 2);

    for (double x = 0; x <= size.width; x += 5) {
      final y = size.height / 2 +
          sin((x / size.width * 6 * pi) + (animationValue * 4 * pi)) * 20 +
          cos((x / size.width * 4 * pi) + (animationValue * 2 * pi)) * 10;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}