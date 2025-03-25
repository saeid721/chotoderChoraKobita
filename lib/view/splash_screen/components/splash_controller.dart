import 'package:flutter/material.dart';
import '../../category_screen/catagory_screen.dart';

class SplashController {
  AnimationController? _animationController;
  Animation<double>? _scaleAnimation;

  void initializeAnimation(TickerProvider vsync, BuildContext context) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  void dispose() {
    _animationController?.dispose();
  }

  Animation<double>? get scaleAnimation => _scaleAnimation;
}