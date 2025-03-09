import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/widget/colors.dart';
import '../../../global/widget/global_app_bar.dart';
import '../../../global/widget/global_container.dart';
import '../../../global/widget/sub_category_card_widget.dart';
import 'sub_category_screen/arabic_lyrics/arabic_song_list_screen.dart';
import 'sub_category_screen/bangla_lyrics/bangla_song_list_screen.dart';
import 'sub_category_screen/english_lyrics/english_song_list_screen.dart';
import 'sub_category_screen/hindi_lyrics/hindi_song_list_screen.dart';
import 'sub_category_screen/urdhu_lyrics/urdhu_song_list_screen.dart';

class SubCategoryIslamicScreen extends StatefulWidget {
  const SubCategoryIslamicScreen({super.key});

  @override
  State<SubCategoryIslamicScreen> createState() => _SubCategoryIslamicScreenState();
}

class _SubCategoryIslamicScreenState extends State<SubCategoryIslamicScreen> {

  int currentIndex = 0;
  CarouselSliderController buttonCarouselController = CarouselSliderController();

  final List<String> sliderImage = [
    'assets/images/01.png',
    'assets/images/02.png',
    'assets/images/03.jpg',
    'assets/images/04.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(
        title: "Islamic Songs Lyric",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: CarouselSlider(
                    items: sliderImage
                        .map(
                          (item) => GlobalContainer(
                        borderCornerRadius: const BorderRadius.all(Radius.circular(10.0)),
                        backgroundColor: ColorRes.backgroundColor,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                          child: Image.asset(
                            item,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                    ).toList(),
                    carouselController: buttonCarouselController,
                    options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 2,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: sliderImage.asMap().entries.map((entry) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 7,
                      width: currentIndex == entry.key ? 15 : 7,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentIndex == entry.key
                            ? ColorRes.primaryColor
                            : ColorRes.borderColor,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: SubCategoryCardWidget(
                        imagePath: 'assets/images/song.png',
                        title: 'Bangla',
                        onTap: () =>
                            Get.to(() => const BanglaIslamicSongListScreen()),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: SubCategoryCardWidget(
                        imagePath: 'assets/images/song.png',
                        title: 'English',
                        onTap: () => Get.to(
                                () => const EnglishIslamicSongListScreen()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: SubCategoryCardWidget(
                        imagePath: 'assets/images/song.png',
                        title: 'Hindi',
                        onTap: () => Get.to(
                                () => const HindiIslamicSongListScreen()),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: SubCategoryCardWidget(
                        imagePath: 'assets/images/song.png',
                        title: 'Arabic',
                        onTap: () => Get.to(
                                () => const ArabicIslamicSongListScreen()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: SubCategoryCardWidget(
                        imagePath: 'assets/images/song.png',
                        title: 'Urdhu',
                        onTap: () => Get.to(
                                () => const UrdhuIslamicSongListScreen()),
                      ),
                    ),
                    Expanded(
                      child: SubCategoryCardWidget(
                        title: '',
                        onTap: () =>
                        Get.back,
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
