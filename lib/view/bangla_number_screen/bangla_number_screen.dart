import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../../global/widget/colors.dart';
import '../../global/widget/global_sizedbox.dart';
import '../../global/widget/global_text.dart';
import 'components/bangla_number_enmu.dart';
import 'components/bangla_number_widget.dart';
import 'components/bangla_number_particle_painter_animation.dart';
import 'components/bangla_number_theme_background_widget.dart';
import 'components/bangla_number_theme_selector_widget.dart';
import 'controller/bangla_number_controller.dart';
import 'model/bangla_number_model.dart';

class BanglaNumberScreen extends StatefulWidget {
  const BanglaNumberScreen({super.key});

  @override
  State<BanglaNumberScreen> createState() => _BanglaNumberScreenState();
}

class _BanglaNumberScreenState extends State<BanglaNumberScreen> with TickerProviderStateMixin {
  late BanglaNumberController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BanglaNumberController(
      vsync: this,
      onLetterTap: (letter, position) => _onLetterTap(letter, position),
      onSwitchTheme: (theme) => _switchTheme(theme),
      onCloseReading: () => _closeReading(),
    );
    _controller.init();
  }

  void _onLetterTap(BanglaNumberModel letter, Offset globalPosition) {
    if (_controller.isReading) return;

    HapticFeedback.heavyImpact();

    setState(() {
      _controller.selectedLetter = letter;
      _controller.isReading = true;
    });

    _controller.createLetterParticles(globalPosition);
    _controller.readingController.forward(from: 0);

    _controller.speakLetter(letter);
  }

  void _switchTheme(BanglaNumberTheme newTheme) {
    if (_controller.currentTheme == newTheme || _controller.isReading) return;

    HapticFeedback.mediumImpact();

    _controller.themeTransitionController.forward(from: 0);

    setState(() {
      _controller.currentTheme = newTheme;
      _controller.particles.clear();
    });

    _controller.createThemeChangeParticles(context);
  }

  void _closeReading() {
    _controller.readingController.reverse();

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _controller.selectedLetter = null;
          _controller.isReading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: ColorRes.white200,
        backgroundColor: ColorRes.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const GlobalText(
          str: "বাংলা সংখ্যা",
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: ColorRes.white,
          isSelectable: false,
        ),
        actions: [
          ThemeSelectorWidget(
            theme: BanglaNumberTheme.storybook,
            emoji: '🌟',
            color: const Color(0xFFFEF8C6),
            currentTheme: _controller.currentTheme,
            onSwitchTheme: _switchTheme,
          ),
          sizedBoxW(8),
          ThemeSelectorWidget(
            theme: BanglaNumberTheme.holographic,
            emoji: '🚀',
            color: const Color(0xFFFF6B6B),
            currentTheme: _controller.currentTheme,
            onSwitchTheme: _switchTheme,
          ),
          sizedBoxW(8),
          ThemeSelectorWidget(
            theme: BanglaNumberTheme.enchanted,
            emoji: '🌿',
            color: const Color(0xFF90EE90),
            currentTheme: _controller.currentTheme,
            onSwitchTheme: _switchTheme,
          ),
          sizedBoxW(8),
          ThemeSelectorWidget(
            theme: BanglaNumberTheme.ocean,
            emoji: '🌊',
            color: const Color(0xFF87CEEB),
            currentTheme: _controller.currentTheme,
            onSwitchTheme: _switchTheme,
          ),
          sizedBoxW(8),
        ],
      ),
      body: Stack(
        children: [
          ThemeBackgroundWidget(
            currentTheme: _controller.currentTheme,
            ambientController: _controller.ambientController,
          ),
          CustomPaint(
            painter: ParticlePainter(_controller.particles),
            size: Size.infinite,
          ),
          Column(
            children: [
              Expanded(
                child: LetterGridWidget(
                  letters: _controller.letters,
                  floatingController: _controller.floatingController,
                  currentTheme: _controller.currentTheme,
                  onLetterTap: _onLetterTap,
                ),
              ),
            ],
          ),
          if (_controller.isReading && _controller.selectedLetter != null)
            ReadingOverlayWidget(
              selectedLetter: _controller.selectedLetter!,
              currentTheme: _controller.currentTheme,
              readingController: _controller.readingController,
              onClose: _closeReading,
            ),
        ],
      ),
    );
  }
}