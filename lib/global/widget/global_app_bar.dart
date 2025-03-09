import 'package:flutter/material.dart';
import 'colors.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double elevation;
  final Color backgroundColor;
  final Color titleColor;
  final Color iconColor;

  const GlobalAppBar({
    super.key,
    required this.title,
    this.elevation = 1,
    this.backgroundColor = ColorRes.backgroundColor,
    this.titleColor = ColorRes.white,
    this.iconColor = ColorRes.white,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      shadowColor: ColorRes.borderColor,
      backgroundColor: ColorRes.primaryColor,
      iconTheme: IconThemeData(color: iconColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: titleColor,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
