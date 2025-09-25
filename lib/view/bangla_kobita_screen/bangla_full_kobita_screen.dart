import 'package:flutter/material.dart';
import '../../../../../data/genaral/bangla_kobita_data.dart';
import '../../../../../global/widget/global_app_bar.dart';
import 'components/bangla_kobita_widget.dart';

class BanglaFullKobitaScreen extends StatefulWidget {
  final String id;
  const BanglaFullKobitaScreen({super.key, required this.id});

  @override
  State<BanglaFullKobitaScreen> createState() => _BanglaFullKobitaScreenState();
}

class _BanglaFullKobitaScreenState extends State<BanglaFullKobitaScreen> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = banglaKobitaData.indexWhere((item) => item.id == widget.id);
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(title: banglaKobitaData[currentIndex].title),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemCount: banglaKobitaData.length,
        itemBuilder: (context, index) {
          final banglaKobita = banglaKobitaData[index];
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: KobitaWidget(
                title: banglaKobita.title,
                fullKobita: banglaKobita.fullKobita,
                writer: banglaKobita.writer,
              ),
            ),
          );
        },
      ),
    );
  }
}
