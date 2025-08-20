import 'package:flutter/material.dart';
import 'colors.dart';

class ManuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData icon;
  final Color backgroundColor;

  const ManuItem({
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
        shadowColor: Colors.black.withValues(alpha: 0.25),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorRes.primaryColor,
                ColorRes.borderColor,
                ColorRes.borderColor,
                ColorRes.titleColor,
              ],
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
            ),
          ),
          padding: const EdgeInsets.all(2.0),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(13.0),
                bottomLeft: Radius.circular(13.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: ColorRes.textColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    icon,
                    color: ColorRes.primaryColor,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}