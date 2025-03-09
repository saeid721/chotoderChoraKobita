import 'package:flutter/material.dart';

class GlobalContainer extends StatelessWidget {
  final double borderRadius;
  final BorderRadiusGeometry? borderCornerRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Widget? child;
  final Color backgroundColor;
  final double? width;
  final double? height;
  final Border? border;
  final double elevation;
  final Color? bottomBorderColor; // Dynamic bottom border color

  const GlobalContainer({
    super.key,
    this.borderRadius = 0.0,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.child,
    this.width,
    this.height,
    this.border,
    this.backgroundColor = Colors.white,
    this.borderCornerRadius,
    this.elevation = 0.0,
    this.bottomBorderColor, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      shadowColor: Colors.black.withOpacity(0.3),
      borderRadius: borderCornerRadius ?? BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        width: width,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius:
              borderCornerRadius ?? BorderRadius.circular(borderRadius),
          border: border ??
              Border(
                bottom: BorderSide(
                  color: bottomBorderColor ??
                      Colors.transparent, // Dynamic bottom border color
                  width: 1.0, // Adjust thickness if needed
                ),
              ),
        ),
        child: child,
      ),
    );
  }
}
