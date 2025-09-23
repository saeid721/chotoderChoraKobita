import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../global/widget/colors.dart';
import '../../../global/widget/global_text.dart';
import '../../../global/widget/global_sizedbox.dart';
import '../model/alphabet_model.dart';
import 'alpha_enmu.dart';

/// 🌈 Pastel colors for Storybook theme
final colors = [
  [const Color(0xFFFFB6C1), const Color(0xFFFFE4E1)], // A - pink blush
  [const Color(0xFFB6E5D8), const Color(0xFFE8F8F5)], // B - mint aqua
  [const Color(0xFFD4B6FF), const Color(0xFFF0E6FF)], // C - lavender
  [const Color(0xFFFFF8B6), const Color(0xFFFFFDE7)], // D - light lemon
  [const Color(0xFFFFD4B6), const Color(0xFFFFF2E6)], // E - peach soft
  [const Color(0xFFFFD6E8), const Color(0xFFFFF0F5)], // F - rose pink
  [const Color(0xFFD4E6FF), const Color(0xFFF0F6FF)], // G - sky blue
  [const Color(0xFFFFF5CC), const Color(0xFFFFFAE5)], // H - pastel cream
  [const Color(0xFFE6D6FF), const Color(0xFFF5EFFF)], // I - soft violet
  [const Color(0xFFCFFFE0), const Color(0xFFE6FFF2)], // J - light green
  [const Color(0xFFFFE6CC), const Color(0xFFFFF2E5)], // K - apricot
  [const Color(0xFFD6F5FF), const Color(0xFFEFFFFF)], // L - ice blue
  [const Color(0xFFFFCCE5), const Color(0xFFFFE6F2)], // M - blush pink
  [const Color(0xFFCCFFF5), const Color(0xFFE5FFFA)], // N - aqua pastel
  [const Color(0xFFFFC1CC), const Color(0xFFFFE4E9)], // O - soft rose
  [const Color(0xFFB3E5FC), const Color(0xFFE1F5FE)], // P - baby blue
  [const Color(0xFFFFF9C4), const Color(0xFFFFFFE0)], // Q - lemon cream
  [const Color(0xFFC8E6C9), const Color(0xFFE8F5E9)], // R - mint leaf
  [const Color(0xFFD1C4E9), const Color(0xFFEDE7F6)], // S - lilac
  [const Color(0xFFFFCCBC), const Color(0xFFFFE0B2)], // T - soft coral
  [const Color(0xFFFFF176), const Color(0xFFFFF59D)], // U - mellow yellow
  [const Color(0xFFB2EBF2), const Color(0xFFE0F7FA)], // V - aqua mist
  [const Color(0xFFF8BBD0), const Color(0xFFFCE4EC)], // W - rosy pastel
  [const Color(0xFFDCEDC8), const Color(0xFFF1F8E9)], // X - green meadow
  [const Color(0xFFB39DDB), const Color(0xFFD1C4E9)], // Y - lavender haze
  [const Color(0xFFFFAB91), const Color(0xFFFFCCBC)], // Z - peach coral
  [const Color(0xFFFFF59D), const Color(0xFFFFFFD9)], // Extra 1 - butter cream
  [const Color(0xFFA5D6A7), const Color(0xFFC8E6C9)], // Extra 2 - leafy mint
];


class LetterGridWidget extends StatelessWidget {
  final List<LetterModel> letters;
  final AnimationController floatingController;
  final AlphabetTheme currentTheme;
  final Function(LetterModel, Offset) onLetterTap;

  const LetterGridWidget({
    super.key,
    required this.letters,
    required this.floatingController,
    required this.currentTheme,
    required this.onLetterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: GridView.builder(
        shrinkWrap: true,
        //physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.87,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: letters.length,
        itemBuilder: (context, index) {
          return LetterCardWidget(
            letter: letters[index],
            index: index,
            floatingController: floatingController,
            currentTheme: currentTheme,
            onLetterTap: onLetterTap,
          );
        },
      ),
    );
  }
}

class LetterCardWidget extends StatelessWidget {
  final LetterModel letter;
  final int index;
  final AnimationController floatingController;
  final AlphabetTheme currentTheme;
  final Function(LetterModel, Offset) onLetterTap;

  const LetterCardWidget({
    super.key,
    required this.letter,
    required this.index,
    required this.floatingController,
    required this.currentTheme,
    required this.onLetterTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: floatingController,
      builder: (context, child) {
        final offset = math.sin(floatingController.value * 2 * math.pi + index * 0.2) * 3;

        return Transform.translate(
          offset: Offset(0, offset),
          child: GestureDetector(
            onTapDown: (details) {
              final RenderBox box = context.findRenderObject() as RenderBox;
              final globalPosition = box.localToGlobal(details.localPosition);
              onLetterTap(letter, globalPosition);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.elasticOut,
              child: ThemeSpecificCardWidget(
                letter: letter,
                index: index,
                currentTheme: currentTheme,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ThemeSpecificCardWidget extends StatelessWidget {
  final LetterModel letter;
  final int index;
  final AlphabetTheme currentTheme;

  const ThemeSpecificCardWidget({
    super.key,
    required this.letter,
    required this.index,
    required this.currentTheme,
  });

  @override
  Widget build(BuildContext context) {
    switch (currentTheme) {
      case AlphabetTheme.storybook:
        return _storybookCardWidget(letter, index);
      case AlphabetTheme.holographic:
        return _holographicCardWidget(letter);
      case AlphabetTheme.enchanted:
        return _enchantedCardWidget(letter, index);
      case AlphabetTheme.ocean:
        return _oceanCardWidget(letter);
    }
  }

  /// 📖 Storybook Theme
  Widget _storybookCardWidget(LetterModel letter, int index) {
    final List<Color> gradientColors = colors[index % colors.length];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: gradientColors.first),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GlobalText(
              str: letter.icon,
              fontSize: 16,
              isSelectable: false,
            ),
            GlobalText(
              str: letter.letter,
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: ColorRes.primaryColor,
              isSelectable: false,
            ),
            GlobalText(
              str: letter.pronunciation,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: ColorRes.deep200,
              isSelectable: false,
            ),
          ],
        ),
      ),
    );
  }

  /// ✨ Holographic Theme
  Widget _holographicCardWidget(LetterModel letter) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF00FFFF).withOpacity(0.1),
            const Color(0xFFFF00FF).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.3)),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GlobalText(
              str: letter.icon,
              fontSize: 16,
              isSelectable: false,
            ),
            GlobalText(
              str: letter.letter,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF00FFFF),
              isSelectable: false,
            ),
            GlobalText(
              str: letter.pronunciation.toLowerCase(),
              fontSize: 8,
              color: const Color(0xFF00FFFF).withOpacity(0.6),
              isSelectable: false,
            ),
          ],
        ),
      ),
    );
  }

  /// 🧚 Enchanted Theme
  Widget _enchantedCardWidget(LetterModel letter, int index) {
    final sway = math.sin(0.5 * 2 * math.pi + index * 0.5) * 2;
    return Transform.rotate(
      angle: sway * 0.02,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            colors: [
              const Color(0xFF90EE90).withOpacity(0.3),
              const Color(0xFF228B22).withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFF90EE90).withOpacity(0.4), width: 2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF90EE90).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlobalText(
                str: letter.icon,
                fontSize: 16,
                isSelectable: false,
              ),
              GlobalText(
                str: letter.letter,
                fontSize: 34,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF90EE90),
                isSelectable: false,
              ),
              GlobalText(
                str: letter.pronunciation.toLowerCase(),
                fontSize: 9,
                color: const Color(0xFF90EE90).withOpacity(0.7),
                fontStyle: FontStyle.italic,
                isSelectable: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🌊 Ocean Theme
  Widget _oceanCardWidget(LetterModel letter) {
    final wave = math.sin(0.5 * 4 * math.pi) * 3;
    return Transform.translate(
      offset: Offset(0, wave),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF00FFFF).withOpacity(0.2),
              const Color(0xFF0080FF).withOpacity(0.1),
            ],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(30),
          ),
          border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00FFFF).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlobalText(
                str: letter.icon,
                fontSize: 16,
                isSelectable: false,
              ),
              GlobalText(
                str: letter.letter,
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF00FFFF),
                isSelectable: false,
              ),
              GlobalText(
                str: letter.pronunciation.toLowerCase(),
                fontSize: 8,
                color: const Color(0xFF00FFFF).withOpacity(0.7),
                fontWeight: FontWeight.bold,
                isSelectable: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReadingOverlayWidget extends StatelessWidget {
  final LetterModel selectedLetter;
  final AlphabetTheme currentTheme;
  final AnimationController readingController;
  final VoidCallback onClose;

  const ReadingOverlayWidget({
    super.key,
    required this.selectedLetter,
    required this.currentTheme,
    required this.readingController,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: readingController,
      builder: (context, child) {
        return Container(
          color: Colors.black.withOpacity(0.9 * readingController.value),
          child: Center(
            child: Transform.scale(
              scale: readingController.value,
              child: Transform.rotate(
                angle: (1 - readingController.value) * math.pi,
                child: Container(
                  margin: const EdgeInsets.all(40),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _themeGradientColors(),
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: _getThemeAccentColor().withOpacity(0.5),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GlobalText(
                        str: selectedLetter.icon,
                        fontSize: 60,
                        isSelectable: false,
                      ),
                      sizedBoxH(10),
                      AnimatedBuilder(
                        animation: readingController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 1 + math.sin(readingController.value * 10) * 0.1,
                            child: GlobalText(
                              str: selectedLetter.letter,
                              fontSize: 120,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              isSelectable: false,
                            ),
                          );
                        },
                      ),
                      sizedBoxH(10),
                      GlobalText(
                        str: '/${selectedLetter.pronunciation}/',
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.8),
                        isSelectable: false,
                      ),
                      sizedBoxH(10),
                      GlobalText(
                        str: selectedLetter.word,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        isSelectable: false,
                      ),
                      sizedBoxH(10),
                      GlobalText(
                        str: selectedLetter.description ?? '',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        isSelectable: false,
                      ),
                      sizedBoxH(30),
                      GestureDetector(
                        onTap: onClose,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.white.withOpacity(0.3)),
                          ),
                          child: const GlobalText(
                            str: 'Continue Reading! 📖',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            isSelectable: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Color> _themeGradientColors() {
    switch (currentTheme) {
      case AlphabetTheme.storybook:
        return [const Color(0xFFFFE6F0), const Color(0xFF4ECDC4), const Color(0xFFFF6B6B)];
      case AlphabetTheme.holographic:
        return [const Color(0xFF00FFFF), const Color(0xFFFF00FF), const Color(0xFF8A2BE2)];
      case AlphabetTheme.enchanted:
        return [const Color(0xFF90EE90), const Color(0xFF228B22), const Color(0xFF32CD32)];
      case AlphabetTheme.ocean:
        return [const Color(0xFF00FFFF), const Color(0xFF0080FF), const Color(0xFF87CEEB)];
    }
  }

  Color _getThemeAccentColor() {
    switch (currentTheme) {
      case AlphabetTheme.storybook:
        return const Color(0xFFFFD700);
      case AlphabetTheme.holographic:
        return const Color(0xFF00FFFF);
      case AlphabetTheme.enchanted:
        return const Color(0xFF90EE90);
      case AlphabetTheme.ocean:
        return const Color(0xFF87CEEB);
    }
  }
}
