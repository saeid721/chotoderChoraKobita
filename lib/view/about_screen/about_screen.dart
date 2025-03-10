import 'package:flutter/material.dart';
import '../../../global/widget/colors.dart';
import '../../../global/widget/global_text.dart';
import '../../global/widget/global_image_loader.dart';
import '../../global/widget/images.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      appBar: AppBar(
        elevation: 1,
        shadowColor: ColorRes.borderColor,
        iconTheme: const IconThemeData(color: ColorRes.primaryColor),
        title: const Text(
          'ছোটদের মজার ছড়া ও কবিতা',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ColorRes.primaryColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            GlobalImageLoader(
              imagePath: Images.appLogo,
              height: 220,
              width: 220,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 15),
            GlobalText(
              str: "Welcome to ছোটদের মজার ছড়া ও কবিতা",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.left,
              fontFamily: 'Rubik',
              color: ColorRes.primaryColor,
              isSelectable: false,
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GlobalText(
                    str:
                        """Welcome to ছোটদের মজার ছড়া ও কবিতা Apps, where you'll discover a rich collection that inspires and helps you enjoy the beauty of your favorite ছোটদের মজার ছড়া ও কবিতা! Whether you're passionate about singing, a karaoke lover, or someone who appreciates meaningful words, our platform is crafted to bring you closer to the ছোটদের মজার ছড়া ও কবিতা that speak to your soul.
We offer an extensive selection of song ছোটদের মজার ছড়া ও কবিতা from various genres, cultures, and languages, with a special emphasis on ছোটদের মজার ছড়া ও কবিতা. Our aim is to provide an easy, seamless experience for anyone seeking to connect with meaningful and inspirational ছোটদের মজার ছড়া ও কবিতা.
At ছোটদের মজার ছড়া ও কবিতা Apps, we believe that ছোটদের মজার ছড়া ও কবিতা hold the power to evoke emotions, share stories, and spread positivity. That’s why we are dedicated to curating a broad range of ছোটদের মজার ছড়া ও কবিতা, from timeless treasures to contemporary favorites, all available on a user-friendly platform.
Join us in exploring the beauty of words through song, and let this journey inspire you!
                        """,
                    fontSize: 15,
                    color: ColorRes.black,
                    textAlign: TextAlign.justify,
                    isSelectable: false,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
