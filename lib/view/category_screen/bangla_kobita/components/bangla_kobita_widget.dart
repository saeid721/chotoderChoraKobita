import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../global/widget/colors.dart';
import '../../../../global/widget/enum.dart';
import '../../../../global/widget/global_image_loader.dart';
import '../../../../global/widget/global_text.dart';
import '../../../../global/widget/images.dart';

class KobitaWidget extends StatelessWidget {
  final String fullKobita;
  final String? writer;

  const KobitaWidget({
    super.key,
    required this.fullKobita,
    this.writer,
  });

  @override
  Widget build(BuildContext context) {
    final availableHeight = Get.height - kToolbarHeight - MediaQuery.of(context).padding.top;
    final isLargeScreen = Get.width > 400;

    return SizedBox(
      height: availableHeight,
      width: Get.width,
      child: Stack(
        children: [
          // Background Image
          GlobalImageLoader(
            imagePath: Images.kobitaBg,
            width: Get.width,
            height: availableHeight,
            fit: BoxFit.fill,
            imageFor: ImageFor.asset,
          ),

          // Poem Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              GlobalText(
                str: fullKobita,
                fontSize: isLargeScreen ? 21 : 18,
                fontWeight: FontWeight.w600,
                color: ColorRes.textColor,
                textAlign: TextAlign.center,
              ),
              if (writer != null && writer!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const GlobalImageLoader(
                        imagePath: Images.penInc,
                        height: 25,
                        width: 25,
                        fit: BoxFit.fill,
                        color: ColorRes.primaryColor,
                      ),
                      GlobalText(
                        str: writer!,
                        fontSize: 14,
                        color: ColorRes.black,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}


