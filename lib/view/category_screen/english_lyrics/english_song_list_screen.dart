import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/genaral/english_songs_data.dart';
import '../../../../../global/widget/chapter_item_widget.dart';
import '../../../../../global/widget/colors.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../../../global/widget/global_container.dart';
import '../../../../../global/widget/global_sizedbox.dart';
import 'english_song_full_lyric_screen.dart';

class EnglishKobitaListScreen extends StatefulWidget {
  const EnglishKobitaListScreen({super.key});

  @override
  State<EnglishKobitaListScreen> createState() => _EnglishKobitaListScreenState();
}

class _EnglishKobitaListScreenState extends State<EnglishKobitaListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: "Bengali Rhymes & Poems for Children"),
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
                  itemCount: englishSongsData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final songLyric = englishSongsData[index];
                    return Column(
                      children: [
                        ChapterItem(
                          title: songLyric.title,
                          onTap: () {
                            Get.to(() => EnglishKobitaFullScreen(id: songLyric.id));
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
