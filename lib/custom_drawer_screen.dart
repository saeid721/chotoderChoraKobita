import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'global/model/model.dart';
import 'global/widget/colors.dart';
import 'global/widget/enum.dart';
import 'global/widget/global_image_loader.dart';
import 'global/widget/global_text.dart';
import 'global/widget/images.dart';
import 'view/about_screen/about_screen.dart';
import 'view/category_screen/catagory_screen.dart';
import 'view/contact_screen/contact_screen.dart';
import 'view/privacy_policy_screen/privacy_policy_screen.dart';

class CustomDrawerScreen extends StatefulWidget {
  const CustomDrawerScreen({super.key});

  @override
  State<CustomDrawerScreen> createState() => _CustomDrawerScreenState();
}

class _CustomDrawerScreenState extends State<CustomDrawerScreen> {
  int isClick = 0;
  final List<GlobalMenuModel> menuItem = [
    GlobalMenuModel(img: Images.homeInc, text: 'Home'),
    GlobalMenuModel(img: Images.aboutInc, text: 'About Us'),
    GlobalMenuModel(img: Images.contactInc, text: 'Contact Us'),
    GlobalMenuModel(img: Images.shareInc, text: 'Share Your Friends'),
    GlobalMenuModel(img: Images.ratingInc, text: 'Rate Our App'),
    GlobalMenuModel(img: Images.policyInc, text: 'Privacy & Policy'),
  ];

  // Function to handle app sharing
  void _shareApp() {
    const String message = "Check out this amazing app! [Your App Link Here]";
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: Get.height,
        width: Get.width,
        color: ColorRes.white,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: Get.width,
                  height: 160,
                  padding: const EdgeInsets.only(
                      left: 20, right: 10, top: 50, bottom: 10),

                  decoration:  BoxDecoration(
                    border:
                    Border.all(color: ColorRes.primaryColor, width: 0.3),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFFFE6F0), // Light pink
                        Color(0xFFB3E5FC), // Light blue
                      ],
                    ),
                  ),
                  child: const ClipRRect(
                    child: GlobalImageLoader(
                      imagePath: 'assets/images/splash_screen.png',
                      width: 250,
                      imageFor: ImageFor.asset,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: menuItem.length,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () async {
                          setState(() {
                            isClick = index;
                          });
                          log('Index: $index');
                          switch (index) {
                            case 0:
                              Get.to(() => const HomeScreen());
                              break;
                            case 1:
                              Get.to(() => const AboutUsScreen());
                              break;
                            case 2:
                              Get.to(() => const ContactScreen());
                              break;
                            case 3:
                              _shareApp(); // Trigger share app function
                              break;
                            case 4:
                            // Add any action for Rating here
                              break;
                            case 5:
                              Get.to(() => const AppPrivacyPolicyScreen());
                              break;
                          }
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isClick == index
                                ? ColorRes.primaryColor
                                : Colors.white,
                          ),
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              GlobalImageLoader(
                                imagePath: menuItem[index].img,
                                height: 20,
                                width: 20,
                                fit: BoxFit.fill,
                                imageFor: ImageFor.asset,
                              ),
                              const SizedBox(width: 10),
                              GlobalText(
                                str: menuItem[index].text,
                                color: isClick == index
                                    ? ColorRes.white
                                    : ColorRes.black,
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            // Bottom Description and Loader
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 50.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GlobalText(
                      str: 'Version: 1.0.1',
                      color: ColorRes.textColor,
                      fontSize: 13,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
