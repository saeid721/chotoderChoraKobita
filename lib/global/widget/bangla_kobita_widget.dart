import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'colors.dart';
import 'enum.dart';
import 'global_container.dart';
import 'global_image_loader.dart';
import 'global_text.dart';
import 'images.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GlobalContainer(
          backgroundColor: ColorRes.backgroundColor,
          width: Get.width,
          height: Get.height,
          child: Stack(
            children: [
              // Background Image with custom opacity
              GlobalImageLoader(
                imagePath: Images.kobitaBg,
                width: Get.width,
                height: Get.height,
                fit: BoxFit.cover,
                imageFor: ImageFor.asset,
                opacity: 0.5,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      GlobalText(
                        str: fullKobita,
                        fontSize: 22,
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
