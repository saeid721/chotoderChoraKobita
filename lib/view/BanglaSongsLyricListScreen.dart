import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/lyric_controller.dart';
import '../global/widget/chapter_item_widget.dart';
import '../global/widget/colors.dart';
import '../global/widget/global_app_bar.dart';
import 'AddBanglaSongsLyricScreen.dart';
import 'BanglaSongsFullLyricScreen.dart';

class BanglaSongsLyricListScreen extends StatelessWidget {
  const BanglaSongsLyricListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LyricController controller = Get.put(LyricController());

    return Scaffold(
      appBar: const GlobalAppBar(title: "Bangla Songs Lyrics"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Obx(() {
                return Expanded(  // Wrap with Expanded to avoid unbounded height
                  child: ListView.builder(
                    itemCount: controller.lyrics.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ChapterItem(
                            title: controller.lyrics[index].title,
                            onTap: () {
                              Get.to(() => BanglaSongsFullLyricScreen(lyric: controller.lyrics[index]));
                            },
                          ),
                          const SizedBox(height: 5),
                        ],
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     //Get.to(() => const AddBanglaSongsLyricScreen());
      //   },
      //   tooltip: "Add New Lyric",
      //   child: const Icon(Icons.add, color: ColorRes.primaryColor),
      // ),
    );
  }
}
