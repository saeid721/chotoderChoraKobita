import 'package:flutter/material.dart';
import '../../global/widget/colors.dart';
import '../../global/widget/global_text.dart';
import '../category_screen/catagory_screen.dart';
import '../../global/widget/enum.dart';
import '../../global/widget/global_image_loader.dart';
import '../../global/widget/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Navigate to CategoryHomeScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const CategoryHomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Logo
            ScaleTransition(
              scale: _scaleAnimation,
              child: const GlobalImageLoader(
                imagePath: Images.appLogo,
                height: 220,
                width: 220,
                fit: BoxFit.contain,
                imageFor: ImageFor.asset,
              ),
            ),
            const SizedBox(height: 20),
            // App Title with playful typography
            const GlobalText(
              str: "ছোটদের মজার ছড়া ও কবিতা",
              fontSize: 28,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
              fontFamily: 'ComicNeue',
              color: ColorRes.primaryColor,
              isSelectable: false,
            ),
            const SizedBox(height: 30),
            // Loading Indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFB300)),
              strokeWidth: 5,
            ),
          ],
        ),
      ),
    );
  }
}