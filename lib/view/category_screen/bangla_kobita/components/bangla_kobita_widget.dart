// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../global/widget/colors.dart';
// import '../../../../global/widget/enum.dart';
// import '../../../../global/widget/global_image_loader.dart';
// import '../../../../global/widget/global_text.dart';
// import '../../../../global/widget/images.dart';
//
// class KobitaWidget extends StatelessWidget {
//   final String fullKobita;
//   final String? writer;
//
//   const KobitaWidget({
//     super.key,
//     required this.fullKobita,
//     this.writer,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final availableHeight = Get.height - kToolbarHeight - MediaQuery.of(context).padding.top;
//     final isLargeScreen = Get.width > 400;
//
//     return SizedBox(
//       height: availableHeight,
//       width: Get.width,
//       child: Stack(
//         children: [
//           // Background Image
//           GlobalImageLoader(
//             imagePath: Images.kobitaBg,
//             width: Get.width,
//             height: availableHeight,
//             fit: BoxFit.fill,
//             imageFor: ImageFor.asset,
//           ),
//
//           // Poem Content
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 10),
//               GlobalText(
//                 str: fullKobita,
//                 fontSize: isLargeScreen ? 21 : 18,
//                 fontWeight: FontWeight.w600,
//                 color: ColorRes.textColor,
//                 textAlign: TextAlign.center,
//               ),
//               if (writer != null && writer!.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const GlobalImageLoader(
//                         imagePath: Images.penInc,
//                         height: 25,
//                         width: 25,
//                         fit: BoxFit.fill,
//                         color: ColorRes.primaryColor,
//                       ),
//                       GlobalText(
//                         str: writer!,
//                         fontSize: 14,
//                         color: ColorRes.black,
//                       ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//



import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global/widget/enum.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/images.dart';

class KobitaWidget extends StatefulWidget {
  final String fullKobita;
  final String title;
  final String? writer;

  const KobitaWidget({
    super.key,
    required this.fullKobita,
    required this.title,
    this.writer,
  });

  @override
  State<KobitaWidget> createState() => _KobitaWidgetState();
}

class _KobitaWidgetState extends State<KobitaWidget>
    with TickerProviderStateMixin {
  late AnimationController _sparkleController;
  late AnimationController _floatingController;
  late AnimationController _textController;
  double _textSize = 21.0;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    _sparkleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Animate text in
    _textController.forward();
  }

  @override
  void dispose() {
    _sparkleController.dispose();
    _floatingController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = Get.height - kToolbarHeight - MediaQuery.of(context).padding.top;
    final isLargeScreen = Get.width > 400;

    return SizedBox(
      height: availableHeight,
      width: Get.width,
      child: Stack(
        children: [
          // Animated background with gradient
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFE6F0),
                  Color(0xFFE1F5FE),
                  Color(0xFFF3E5F5),
                  Color(0xFFFFF3E0),
                ],
                stops: [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),

          // Floating decorative elements
          ...List.generate(8, (index) => _buildFloatingDecoration(index)),

          // Background Image with overlay
          GlobalImageLoader(
            imagePath: Images.kobitaBg,
            width: Get.width,
            height: availableHeight,
            fit: BoxFit.fill,
            imageFor: ImageFor.asset,
          ),

          // Gradient overlay for better text readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.1),
                  Colors.white.withValues(alpha: 0.3),
                  Colors.white.withValues(alpha: 0.5),
                  Colors.white.withValues(alpha: 0.3),
                ],
              ),
            ),
          ),

          // Reading controls overlay
          Positioned(
            top: 20,
            right: 20,
            child: _buildReadingControls(),
          ),

          // Main content with enhanced animations
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: SingleChildScrollView(
                child: AnimatedBuilder(
                  animation: _textController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _textController,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.5),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _textController,
                          curve: Curves.easeOutBack,
                        )),
                        child: _buildPoemContent(isLargeScreen),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Bottom decorative wave
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomWave(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingDecoration(int index) {
    final decorations = ['⭐', '🌟', '✨', '🌙', '🌸', '🦋', '🌈', '💫'];
    final colors = [
      Colors.yellow,
      Colors.purple,
      Colors.pink,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.indigo,
    ];

    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        final offsetY = 50 + (index * 80) + (30 * _floatingController.value);
        final offsetX = (index.isEven ? 30 : Get.width - 80) + (20 * _floatingController.value * (index.isEven ? 1 : -1));

        return Positioned(
          top: offsetY,
          left: offsetX,
          child: AnimatedBuilder(
            animation: _sparkleController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _sparkleController.value * 2 * 3.14159,
                child: Opacity(
                  opacity: 0.4 + (0.4 * _floatingController.value),
                  child: Text(
                    decorations[index],
                    style: TextStyle(
                      fontSize: 20 + (5 * _floatingController.value),
                      color: colors[index],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildReadingControls() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Font size controls
          IconButton(
            onPressed: () {
              setState(() {
                if (_textSize > 16) _textSize -= 2;
              });
            },
            icon: const Icon(Icons.text_decrease),
            tooltip: 'ছোট করুন',
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (_textSize < 28) _textSize += 2;
              });
            },
            icon: const Icon(Icons.text_increase),
            tooltip: 'বড় করুন',
          ),

          // Reading mode toggle
          IconButton(
            onPressed: () {
              setState(() {
                _isPlaying = !_isPlaying;
              });

              if (_isPlaying) {
                _sparkleController.repeat();
              } else {
                _sparkleController.stop();
              }
            },
            icon: Icon(_isPlaying ? Icons.pause_circle : Icons.play_circle),
            tooltip: _isPlaying ? 'থামান' : 'শুরু করুন',
            color: Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildPoemContent(bool isLargeScreen) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.purple.withValues(alpha: 0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Decorative header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF9A8B), Color(0xFFA8E6CF)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('📖', style: TextStyle(fontSize: 20)),
                SizedBox(width: 8),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Text('📖', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // Poem text with enhanced styling
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: _textSize,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D3748),
            ),
            child: Text(
              widget.fullKobita,
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 5),

          // Writer info with enhanced design
          if (widget.writer != null && widget.writer!.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withValues(alpha: 0.1),
                    Colors.blue.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.purple.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.purple.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const GlobalImageLoader(
                      imagePath: Images.penInc,
                      height: 20,
                      width: 20,
                      fit: BoxFit.fill,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'লেখক',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.writer!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3748),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomWave() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(_floatingController.value),
          size: Size(Get.width, 60),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFF9A8B), Color(0xFFA8E6CF)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);

    for (double x = 0; x <= size.width; x++) {
      final y = size.height * 0.5 +
          (size.height * 0.3 *
              (sin((x / size.width * 2 * 3.14159) + (animationValue * 2 * 3.14159))));
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