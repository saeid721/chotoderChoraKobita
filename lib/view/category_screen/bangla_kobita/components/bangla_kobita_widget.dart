import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../../global/widget/enum.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_sizedbox.dart';
import '../../../../global/widget/global_text.dart';
import '../../../../global/widget/images.dart';
import '../../../home_screen/controller/animation_controller.dart';

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

class _KobitaWidgetState extends State<KobitaWidget> with TickerProviderStateMixin {
  late BanglaKobitaAnimations animations;
  double _textSize = 21.0;
  bool _isPlaying = false;

  // Text-to-Speech
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    animations = BanglaKobitaAnimations(vsync: this);
    animations.init();

    _initTTS();
  }

  Future<void> _initTTS() async {
    await _flutterTts.setLanguage("bn-BD");
    await _flutterTts.setPitch(1.5);
    await _flutterTts.setSpeechRate(0.4);
    await _setPreferredVoice();

    _flutterTts.setCompletionHandler(() {
      setState(() => _isPlaying = false);
      animations.sparkleController.stop();
    });
  }

  Future<void> _setPreferredVoice() async {
    try {
      List<dynamic> voices = await _flutterTts.getVoices;
      final selectedVoice = voices.firstWhere(
            (v) => v.toString().toLowerCase().contains('child') ||
            v.toString().toLowerCase().contains('female') ||
            v.toString().toLowerCase().contains('bn'),
        orElse: () => voices.isNotEmpty ? voices.first : null,
      );

      if (selectedVoice != null && selectedVoice is Map) {
        await _flutterTts.setVoice({
          "name": selectedVoice["name"],
          "locale": selectedVoice["locale"]
        });
      }
    } catch (e) {
      debugPrint("TTS voice selection failed: $e");
    }
  }

  @override
  void dispose() {
    animations.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  void _togglePlayPause() async {
    setState(() => _isPlaying = !_isPlaying);

    if (_isPlaying) {
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.5);
      await _flutterTts.setSpeechRate(0.4);
      await _flutterTts.speak(widget.fullKobita);
      animations.sparkleController.repeat();
    } else {
      await _flutterTts.stop();
      animations.sparkleController.stop();
    }
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
          ...List.generate(8, (index) => _buildFloatingDecoration(index)),
          GlobalImageLoader(
            imagePath: Images.kobitaBg,
            width: Get.width,
            height: availableHeight,
            fit: BoxFit.fill,
            imageFor: ImageFor.asset,
          ),
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
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(16),
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
                  IconButton(
                    onPressed: _togglePlayPause,
                    icon: Icon(
                      _isPlaying ? Icons.pause_circle : Icons.play_circle,
                      color: Colors.purple,
                    ),
                    tooltip: _isPlaying ? 'থামান' : 'শুরু করুন',
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: SingleChildScrollView(
                child: AnimatedBuilder(
                  animation: animations.textController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: animations.textController,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.5),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animations.textController,
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
      animation: animations.floatingController,
      builder: (context, child) {
        final pos = animations.getFloatingPosition(index, Get.width);
        return Positioned(
          top: pos.dy,
          left: pos.dx,
          child: Transform.rotate(
            angle: animations.getSparkleRotation(),
            child: Opacity(
              opacity: 0.4 + (0.4 * animations.floatingController.value),
              child: GlobalText(
                str: decorations[index],
                fontSize: 20 + (5 * animations.floatingController.value),
                color: colors[index],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPoemContent(bool isLargeScreen) {
    final rawWriter = widget.writer ?? '';
    final writer = rawWriter.trim();
    final hasWriter = writer.isNotEmpty &&
        writer.toLowerCase() != 'null' &&
        writer.toLowerCase() != 'undefined';

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF714B), Color(0xFF4D2D8C)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GlobalText(str: '📖', fontSize: 20),
                sizedBoxW(8),
                GlobalText(
                  str: widget.title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                sizedBoxW(8),
                GlobalText(str: '📖', fontSize: 20),
              ],
            ),
          ),
          sizedBoxH(10),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: _textSize,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D3748),
            ),
            child: GlobalText(
              str: widget.fullKobita,
              textAlign: TextAlign.center,
              fontSize: _textSize,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D3748),
            ),
          ),
          if (hasWriter)
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
                  sizedBoxW(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalText(
                        str: 'লেখক',
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                      GlobalText(
                        str: writer,
                        fontSize: 14,
                        color: const Color(0xFF2D3748),
                        fontWeight: FontWeight.w700,
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
      animation: animations.floatingController,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(animations.floatingController.value),
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
        colors: [Color(0xFFFF714B), Color(0xFF4D2D8C)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);

    for (double x = 0; x <= size.width; x++) {
      final y = size.height * 0.5 +
          (size.height *
              0.3 *
              (sin((x / size.width * 2 * pi) +
                  (animationValue * 2 * pi))));
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
