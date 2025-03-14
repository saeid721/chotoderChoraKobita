import 'package:flutter/material.dart';
import '../../../../../data/genaral/bangla_songs_data.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../../../global/widget/kobita_widget.dart';

class BanglaFullKobitaScreen extends StatelessWidget {
  final String id;
  const BanglaFullKobitaScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // Find the song by its ID
    final songLyric = banglaKobitaData.firstWhere((song) => song.id == id);

    return Scaffold(
      appBar: GlobalAppBar(
        title: songLyric.title,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            KobitaWidget(
              fullKobita: songLyric.fullLyric,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
