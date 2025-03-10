import 'package:flutter/material.dart';
import 'colors.dart';

class ChapterItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData icon;
  final Color backgroundColor;

  const ChapterItem({
    required this.title,
    required this.onTap,
    this.icon = Icons.arrow_forward_ios,
    this.backgroundColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        elevation: 2.0,
        shadowColor: Colors.black.withOpacity(0.25),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
            border: const Border(
              bottom: BorderSide(
                color: ColorRes.borderColor,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: ColorRes.primaryColor,
                ),
              ),
              Icon(
                icon,
                color: ColorRes.borderColor,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}