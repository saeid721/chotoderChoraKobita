import 'package:flutter/material.dart';
import '../../../../../data/genaral/bangla_songs_data.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../../../global/widget/bangla_kobita_widget.dart';

class BanglaFullKobitaScreen extends StatelessWidget {
  final String id;
  const BanglaFullKobitaScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    // Find the song by its ID
    final bangalKobita = banglaKobitaData.firstWhere((song) => song.id == id);

    return Scaffold(
      appBar: GlobalAppBar(
        title: bangalKobita.title,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KobitaWidget(
              fullKobita: bangalKobita.fullKobita,
              writer: bangalKobita.writer,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
