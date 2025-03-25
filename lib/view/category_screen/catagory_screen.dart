import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../splash_screen/components/splash_controller.dart';
import '../../global/widget/category_card_widget.dart';
import '../../global/widget/colors.dart';
import '../../global/widget/enum.dart';
import '../../global/widget/global_app_bar.dart';
import '../../custom_drawer_screen.dart';
import '../../global/widget/global_container.dart';
import '../../global/widget/global_image_loader.dart';
import '../../global/widget/images.dart';
import 'bangla_kobita/bangla_kobita_list_screen.dart';
import 'english_kobita/english_poems_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
        title: "ছোটদের মজার ছড়া ও কবিতা",
      ),
      drawer: const CustomDrawerScreen(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFE6F0), // Light pink
              Color(0xFFB3E5FC), // Light blue
            ],
          ),
        ),
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
                  )
                      .toList(),
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
                    height: 3,
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
                    child: CategoryCardWidget(
                      imagePath: 'assets/images/bangla.png',
                      title: 'বাংলা',
                      onTap: () => Get.to(() => const BanglaKobitaListScreen()),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: CategoryCardWidget(
                      imagePath: 'assets/images/english.png',
                      title: 'English',
                      onTap: () => Get.to(() => const EnglishPoemsListScreen()),
                    ),
                  ),
                ],
              ),
              const Spacer(), // Pushes the image to the bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GlobalImageLoader(
                  imagePath: Images.splashScreen,
                  width: Get.width * 0.8,
                  fit: BoxFit.contain,
                  imageFor: ImageFor.asset,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}