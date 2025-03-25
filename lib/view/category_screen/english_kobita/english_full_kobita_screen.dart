import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/genaral/english_poems_data.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../global/widget/english_poems_widget.dart';
import '../../../global/widget/global_container.dart';

class EnglishFullPoemScreen extends StatelessWidget {
  final String id;
  const EnglishFullPoemScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // Find the poem by its ID
    final englishPoem = englishPoemsClassOneData.firstWhere((poem) => poem.id == id);

    return Scaffold(
      appBar: GlobalAppBar(
        title: englishPoem.title,
      ),
      body: GlobalContainer(
        width: Get.width,
        height: Get.height, // Full height including app bar space
        child: EnglishPoemsWidget(
          poemImage: englishPoem.fullPoemImage,
        ),
      ),
    );
  }
}