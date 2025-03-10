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

  const KobitaWidget({
    super.key,
    required this.fullKobita,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
                opacity: 0.5, // Set custom opacity (e.g., 0.5 for 50% opacity)
              ),
              // Text overlay
              Padding(
                padding: const EdgeInsets.all(10),
                child: GlobalText(
                  str: fullKobita,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: ColorRes.textColor,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}