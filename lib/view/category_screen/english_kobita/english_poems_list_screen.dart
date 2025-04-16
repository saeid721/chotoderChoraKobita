import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/genaral/english_poems_data.dart';
import '../../../../../global/widget/colors.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../../../global/widget/global_container.dart';
import '../../../data/genaral/english_poem_data.dart';
import '../../../global/widget/manu_item_widget.dart';
import 'english_full_Poems_screen.dart';
import 'english_full_poem_screen.dart';

class EnglishPoemsListScreen extends StatefulWidget {
  const EnglishPoemsListScreen({super.key});

  @override
  State<EnglishPoemsListScreen> createState() => _EnglishPoemsListScreenState();
}

class _EnglishPoemsListScreenState extends State<EnglishPoemsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: "English Rhymes-Poems for Children"),
      body: GlobalContainer(
        height: Get.height,
        width: Get.width,
        backgroundColor: ColorRes.backgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.015),
                //
                // ListView.builder(
                //   itemCount: englishPoemData.length,
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemBuilder: (ctx, index) {
                //     final englishPoem = englishPoemData[index];
                //     return Padding(
                //       padding: EdgeInsets.only(bottom: Get.height * 0.01),
                //       child: ManuItem(
                //         title: englishPoem.title,
                //         onTap: () {
                //           Get.to(() => EnglishFullPoemScreen(id: englishPoem.id));
                //         },
                //       ),
                //     );
                //   },
                // ),

                ListView.builder(
                  itemCount: englishPoemsClassOneData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final englishPoems = englishPoemsClassOneData[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: Get.height * 0.01),
                      child: ManuItem(
                        title: englishPoems.title,
                        onTap: () {
                          Get.to(() => EnglishFullPoemsScreen(id: englishPoems.id));
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
