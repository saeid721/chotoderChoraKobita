import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controller/home_animation_controller.dart';
import 'home_category_model.dart';

class HomeCategoryWidget extends StatefulWidget {
  final HomeCategoryModel category;
  final int index;
  final AnimationController floatingController;
  final AnimationController pulseController;
  final AnimationController shimmerController;
  final Function(HomeCategoryModel) onTap;

  const HomeCategoryWidget({
    super.key,
    required this.category,
    required this.index,
    required this.floatingController,
    required this.pulseController,
    required this.shimmerController,
    required this.onTap,
  });

  @override
  State<HomeCategoryWidget> createState() => _HomeCategoryWidgetState();
}

class _HomeCategoryWidgetState extends State<HomeCategoryWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _hoverAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _hoverAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _hoverController.forward();
        HapticFeedback.mediumImpact();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _hoverController.reverse();
        widget.onTap(widget.category);
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _hoverController.reverse();
      },
      child: AnimatedBuilder(
        animation: widget.pulseController,
        builder: (context, child) {
          final scale = 1.0 + sin(widget.pulseController.value * 2 * pi + widget.index) * 0.02;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                // Main 3D shadow
                BoxShadow(
                  color: widget.category.gradient[0].withOpacity(0.4),
                  blurRadius: 25 + (_hoverAnimation.value * 10),
                  spreadRadius: -5,
                  offset: Offset(0, 8 + (_hoverAnimation.value * 4)),
                ),
                // Inner glow
                BoxShadow(
                  color: widget.category.gradient[1].withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: -8,
                  offset: const Offset(0, -2),
                ),
                // Outer rim glow
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 20 + (_hoverAnimation.value * 5),
                  sigmaY: 20 + (_hoverAnimation.value * 5),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: const [0.0, 0.3, 0.7, 1.0],
                      colors: [
                        Colors.white.withOpacity(0.2 + (_hoverAnimation.value * 0.1)),
                        widget.category.gradient[0].withOpacity(0.15 + (_hoverAnimation.value * 0.05)),
                        widget.category.gradient[1].withOpacity(0.1 + (_hoverAnimation.value * 0.05)),
                        Colors.white.withOpacity(0.05),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3 + (_hoverAnimation.value * 0.2)),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Stack(
                    children: [
                      // Animated shimmer overlay
                      AnimatedBuilder(
                        animation: widget.shimmerController,
                        builder: (context, child) {
                          return Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                gradient: LinearGradient(
                                  begin: Alignment(-1.0 + (widget.shimmerController.value * 2), -1.0),
                                  end: Alignment(1.0 + (widget.shimmerController.value * 2), 1.0),
                                  colors: [
                                    Colors.transparent,
                                    Colors.white.withOpacity(0.1),
                                    Colors.white.withOpacity(0.2),
                                    Colors.white.withOpacity(0.1),
                                    Colors.transparent,
                                  ],
                                  stops: const [0.0, 0.4, 0.5, 0.6, 1.0],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // 3D highlight effect
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 60,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0.4),
                                Colors.white.withOpacity(0.1),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Main content
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Animated icon
                              Text(
                                widget.category.icon,
                                style: TextStyle(
                                  fontSize: 30,
                                  shadows: [
                                    Shadow(
                                      color: widget.category.gradient[0].withOpacity(0.5),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),

                              // Title with gradient and 3D text effect
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    widget.category.gradient[0],
                                    widget.category.gradient[1],
                                  ],
                                ).createShader(bounds),
                                child: Text(
                                  widget.category.title,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: widget.category.gradient[0].withOpacity(0.5),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                      const Shadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Subtitle with glow effect
                              Text(
                                widget.category.subtitle,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.85),
                                  fontWeight: FontWeight.w600,
                                  shadows: [
                                    Shadow(
                                      color: widget.category.gradient[1].withOpacity(0.3),
                                      blurRadius: 4,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Bottom rim highlight
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                widget.category.gradient[0].withOpacity(0.6),
                                widget.category.gradient[1].withOpacity(0.6),
                              ],
                            ),
                          ),
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
    );
  }
}

class MagicalPortal extends StatelessWidget {
  final AnimationController morphController;
  final AnimationController particleController;

  const MagicalPortal({
    super.key,
    required this.morphController,
    required this.particleController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: AnimatedBuilder(
        animation: morphController,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(sin(morphController.value * 2 * pi) * 0.05),
            alignment: Alignment.center,
            child: ClipPath(
              clipper: MagicalPortalClipper(morphController.value),
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
                      CustomPaint(
                        size: const Size(double.infinity, 120),
                        painter: MagicalParticlesPainter(particleController.value),
                      ),
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
    );
  }
}