import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/genaral/bangla_songs_data.dart';
import '../../../../../global/widget/chapter_item_widget.dart';
import '../../../../../global/widget/colors.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../../../global/widget/global_container.dart';
import '../../../../../global/widget/global_sizedbox.dart';
import 'bangla_song_full_lyric_screen.dart';

class BanglaKobitaListScreen extends StatefulWidget {
  const BanglaKobitaListScreen({super.key});

  @override
  State<BanglaKobitaListScreen> createState() => _BanglaKobitaListScreenState();
}

class _BanglaKobitaListScreenState extends State<BanglaKobitaListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: "ছোটদের বাংলা ছড়া ও কবিতা"),
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
                  itemCount: banglaSongsData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final songLyric = banglaSongsData[index];
                    return Column(
                      children: [
                        ChapterItem(
                          title: songLyric.title,
                          onTap: () {
                            Get.to(() => BanglaKobitaFullScreen(id: songLyric.id));
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
