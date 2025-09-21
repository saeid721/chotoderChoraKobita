import 'package:flutter/material.dart';
import 'alpha_enmu.dart';

class ThemeSelectorWidget extends StatelessWidget {
  final AlphabetTheme theme;
  final String emoji;
  final Color color;
  final AlphabetTheme currentTheme;
  final Function(AlphabetTheme) onSwitchTheme;

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
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.6)],
          ),
          border: Border.all(
            color: isActive ? Colors.white : Colors.transparent,
            width: 2,
          ),
          boxShadow: isActive
              ? [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ]
              : null,
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