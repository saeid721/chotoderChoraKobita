import 'package:flutter/material.dart';
import '../../../../../data/genaral/english_poems_data.dart';
import '../../../../../global/widget/global_app_bar.dart';
import 'components/english_poems_widget.dart';

class EnglishFullPoemScreen extends StatefulWidget {
  final String id;
  const EnglishFullPoemScreen({
    super.key,
    required this.id,
  });

  @override
  State<EnglishFullPoemScreen> createState() => _EnglishFullPoemScreenState();
}

class _EnglishFullPoemScreenState extends State<EnglishFullPoemScreen> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = englishPoemsData.indexWhere((item) => item.id == widget.id);
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
      appBar: GlobalAppBar(title: englishPoemsData[currentIndex].title),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemCount: englishPoemsData.length,
        itemBuilder: (context, index) {
          final englishPoem = englishPoemsData[index];
          return Center(
            child: EnglishPoemsWidget(
              poemImage: englishPoem.fullPoemImage,
            ),
          );
        },
      ),
    );
  }
}
