import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global/widget/colors.dart';
import '../../../../global/widget/enum.dart';
import '../../../../global/widget/global_container.dart';
import '../../../../global/widget/global_image_loader.dart';

class EnglishPoemsWidget extends StatelessWidget {
  final String poemImage;

  const EnglishPoemsWidget({
    super.key,
    required this.poemImage,
  });

  @override
  Widget build(BuildContext context) {
    final availableHeight = Get.height - kToolbarHeight - MediaQuery.of(context).padding.top;

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
