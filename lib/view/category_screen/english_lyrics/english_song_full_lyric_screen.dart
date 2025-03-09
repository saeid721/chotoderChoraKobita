import 'package:flutter/material.dart';
import '../../../../../data/genaral/english_songs_data.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../../../global/widget/songs_widget.dart';

class EnglishKobitaFullScreen extends StatelessWidget {
  final String id;
  const EnglishKobitaFullScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // Find the song by its ID
    final songLyric = englishSongsData.firstWhere((song) => song.id == id);

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
