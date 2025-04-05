import 'package:flutter/material.dart';
import '../../../../../data/genaral/bangla_kobita_data.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../../../global/widget/bangla_kobita_widget.dart';

class BanglaFullKobitaScreen extends StatelessWidget {
  final String id;
  const BanglaFullKobitaScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final kobita = banglaKobitaData.firstWhere((item) => item.id == id);

    return Scaffold(
      appBar: GlobalAppBar(title: kobita.title),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: KobitaWidget(
            fullKobita: kobita.fullKobita,
            writer: kobita.writer,
          ),
        ),
      ),
    );
  }
}

