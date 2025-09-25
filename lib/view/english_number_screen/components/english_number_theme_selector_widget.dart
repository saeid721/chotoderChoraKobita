import 'package:flutter/material.dart';
import 'english_number_enmu.dart';

class ThemeSelectorWidget extends StatelessWidget {
  final EnglishNumberTheme theme;
  final String emoji;
  final Color color;
  final EnglishNumberTheme currentTheme;
  final Function(EnglishNumberTheme) onSwitchTheme;

  const ThemeSelectorWidget({
    super.key,
    required this.theme,
    required this.emoji,
    required this.color,
    required this.currentTheme,
    required this.onSwitchTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentTheme == theme;

    return GestureDetector(
      onTap: () => onSwitchTheme(theme),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isActive ? LinearGradient(
            colors: [ color, color.withOpacity(0.6)]) : null,
          border: Border.all(
            color: color,
            width: 1,
          ),
        ),
        transform: Matrix4.identity()..scale(isActive ? 1.1 : 1.0),
        child: Center(
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}