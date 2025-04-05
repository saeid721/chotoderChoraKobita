import 'package:flutter/material.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../data/genaral/english_poem_data.dart';
import 'components/english_poem_widget.dart';

class EnglishFullPoemScreen extends StatelessWidget {
  final String id;
  const EnglishFullPoemScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final poem = englishPoemData.firstWhere((item) => item.id == id);

    return Scaffold(
      appBar: GlobalAppBar(title: poem.title),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: EnglishPoemWidget(
                fullPoem: poem.fullPoem,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

