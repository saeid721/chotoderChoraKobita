import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/islamic/arabic_data.dart';
import '../../../../../global/widget/chapter_item_widget.dart';
import '../../../../../global/widget/colors.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../../../global/widget/global_container.dart';
import '../../../../../global/widget/global_sizedbox.dart';
import 'arabic_song_full_lyric_screen.dart';

class ArabicIslamicSongListScreen extends StatefulWidget {
  const ArabicIslamicSongListScreen({super.key});

  @override
  State<ArabicIslamicSongListScreen> createState() => _ArabicIslamicSongListScreenState();
}

class _ArabicIslamicSongListScreenState extends State<ArabicIslamicSongListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: "Arabic Islamic Lyrics"),
      body: GlobalContainer(
        height: size(context).height,
        width: size(context).width,
        backgroundColor: ColorRes.backgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                const SizedBox(height: 10),
                ListView.builder(
                  itemCount: arabicData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final songLyric = arabicData[index];
                    return Column(
                      children: [
                        ChapterItem(
                          title: songLyric.title,
                          onTap: () {
                            Get.to(() => ArabicIslamicSongFullLyricScreen(id: songLyric.id));
                          },
                        ),
                        const SizedBox(height: 5),
                      ],
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
