import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/lyric_model.dart';
import '../global/widget/colors.dart';
import '../global/widget/global_app_bar.dart';
import '../global/widget/songs_widget.dart';
import 'UpdateBanglaSongsLyricScreen.dart';

class BanglaSongsFullLyricScreen extends StatelessWidget {
  final Lyric lyric;

  const BanglaSongsFullLyricScreen({super.key, required this.lyric});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(title: lyric.title),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SongsWidget(fullLyric: lyric.fullLyric),
            const SizedBox(height: 10),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Passing the current lyric to the update screen
      //     Get.to(() => UpdateBanglaSongsLyricScreen(lyric: lyric));
      //   },
      //   tooltip: "Update Lyric",
      //   child: const Icon(Icons.edit, color: ColorRes.primaryColor),
      // ),
    );
  }
}
