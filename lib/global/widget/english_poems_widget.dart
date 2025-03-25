import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'colors.dart';
import 'enum.dart';
import 'global_container.dart';
import 'global_image_loader.dart';

class EnglishPoemsWidget extends StatelessWidget {
  final String poemImage;

  const EnglishPoemsWidget({
    super.key,
    required this.poemImage,
  });

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).padding.top;

    return GlobalContainer(
      backgroundColor: ColorRes.backgroundColor,
      width: Get.width,
      height: availableHeight,
      child: GlobalImageLoader(
        imagePath: poemImage,
        width: Get.width,
        height: availableHeight,
        fit: BoxFit.fill,
        imageFor: ImageFor.asset,
      ),
    );
  }
}