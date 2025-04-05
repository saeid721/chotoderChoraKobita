import 'package:flutter/material.dart';
import 'colors.dart';
import 'enum.dart';
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
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Background
        GlobalImageLoader(
          imagePath: Images.kobitaBg,
          width: size.width,
          height: size.height,
          fit: BoxFit.cover,
          imageFor: ImageFor.asset,
          opacity: 0.5,
        ),

        // Foreground content
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              children: [
                GlobalText(
                  str: fullKobita,
                  fontSize: size.width > 400 ? 21 : 18,
                  fontWeight: FontWeight.w600,
                  color: ColorRes.textColor,
                  textAlign: TextAlign.center,
                ),
                if (writer != null && writer!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const GlobalImageLoader(
                          imagePath: Images.penInc,
                          height: 22,
                          width: 22,
                          fit: BoxFit.fill,
                          color: ColorRes.primaryColor,
                        ),
                        const SizedBox(width: 6),
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
    );
  }
}

