import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';
import 'global_container.dart';
import 'global_text.dart';

class SongsWidget extends StatelessWidget {
  final String fullLyric;

  const SongsWidget({
    super.key,
    required this.fullLyric,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalContainer(
      backgroundColor: ColorRes.backgroundColor,
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GlobalContainer(
          backgroundColor: ColorRes.white,
          elevation: 2.0,
          borderCornerRadius: BorderRadius.circular(5),
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GlobalText(
                  str: fullLyric,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
