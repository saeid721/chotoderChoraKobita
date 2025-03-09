import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/genaral/hindi_songs_data.dart';
import '../../../../../global/widget/chapter_item_widget.dart';
import '../../../../../global/widget/colors.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../../../global/widget/global_container.dart';
import '../../../../../global/widget/global_sizedbox.dart';
import 'hindi_song_full_lyric_screen.dart';

class HindiSongListScreen extends StatefulWidget {
  const HindiSongListScreen({super.key});

  @override
  State<HindiSongListScreen> createState() => _HindiSongListScreenState();
}

class _HindiSongListScreenState extends State<HindiSongListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: "Hindi Songs Lyrics"),
      body: GlobalContainer(
        height: size(context).height,
        width: size(context).width,
        backgroundColor: ColorRes.backgroundColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                const SizedBox(height: 10),
                ListView.builder(
                  itemCount: hindiSongsData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final songLyric = hindiSongsData[index];
                    return Column(
                      children: [
                        ChapterItem(
                          title: songLyric.title,
                          onTap: () {
                            Get.to(() => HindiSongFullLyricScreen(id: songLyric.id));
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
