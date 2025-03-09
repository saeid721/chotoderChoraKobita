import 'package:flutter/material.dart';
import '../../../../../data/genaral/urdhu_songs_data.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../../../global/widget/songs_widget.dart';

class UrdhuSongFullLyricScreen extends StatelessWidget {
  final String id;
  const UrdhuSongFullLyricScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // Find the song by its ID
    final songLyric = urdhuSongsData.firstWhere((song) => song.id == id);

    return Scaffold(
      appBar: GlobalAppBar(
        title: songLyric.title,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SongsWidget(
              fullLyric: songLyric.fullLyric,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
