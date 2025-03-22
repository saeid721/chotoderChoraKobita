import 'package:flutter/material.dart';
import 'enum.dart';

class GlobalImageLoader extends StatelessWidget {
  const GlobalImageLoader({
    super.key,
    required this.imagePath,
    this.imageFor = ImageFor.asset,
    this.height,
    this.width,
    this.fit,
    this.color,
    this.opacity = 1.0,
    this.errorBuilder,
  });

  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  final double opacity;
  final ImageErrorWidgetBuilder? errorBuilder;
  final ImageFor imageFor;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (imageFor == ImageFor.network) {
      imageWidget = Image.network(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorBuilder: errorBuilder ??
            (context, exception, stackTrace) => Center(
                  child: Image.asset(
                    "assets/images/place_holder_img.jpg",
                    height: height,
                    width: width,
                    fit: BoxFit.fill,
                  ),
                ),
      );
    } else {
      imageWidget = Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        color: color,
        errorBuilder: errorBuilder ??
            (context, exception, stackTrace) => Center(
                  child: Image.asset(
                    "assets/images/place_holder_img.jpg",
                    height: height,
                    width: width,
                    fit: BoxFit.fill,
                  ),
                ),
      );
    }

    // Apply opacity to the image
    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: imageWidget,
    );
  }
}
