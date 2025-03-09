import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'view/about_screen/about_screen.dart';
import 'view/contact_screen/contact_screen.dart';
import 'global/widget/colors.dart';
import 'global/widget/global_text.dart';

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({
    super.key,
  });

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {

  // Function to handle app sharing
  void _shareApp() {
    const String message = "Check out this amazing app!";
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
                  padding: const EdgeInsets.only(
                      left: 20, right: 10, top: 50, bottom: 10),
                  decoration: BoxDecoration(
                    color: ColorRes.backgroundColor,
                    border: Border.all(color: ColorRes.primaryColor, width: 0.3),
                  ),
                  child:
                  const GlobalText(
                    str: """Lyrics""",
                    fontWeight: FontWeight.w700,
                    fontSize: 44,
                    color: ColorRes.primaryColor,
                  ),
                ),

                ListTile(
                  title: const Text('About App'),
                  leading: const Icon(Icons.person_outline_outlined,
                      color: ColorRes.primaryColor),
                  onTap: () {
                    Get.to(() => const AboutUsScreen());
                  },
                ),
                ListTile(
                  title: const Text('Rate Our App'),
                  leading: const Icon(Icons.star_rate_outlined,
                      color: ColorRes.primaryColor),
                  onTap: () {
                    //Get.to(() => const RateOurApp());
                  },
                ),
                ListTile(
                  title: const Text('Send Feedback'),
                  leading: const Icon(Icons.comment_bank_outlined,
                      color: ColorRes.primaryColor),
                  onTap: () {
                    //Get.to(() => SendFeedback());
                  },
                ),
                ListTile(
                  title: const Text('Share Your Friends'),
                  leading:
                  const Icon(Icons.share_outlined, color: ColorRes.primaryColor),
                  onTap: () {
                    _shareApp(); // Trigger share app function
                  },
                ),
                ListTile(
                  title: const Text('Contact Us'),
                  leading: const Icon(Icons.location_history_outlined,
                      color: ColorRes.primaryColor),
                  onTap: () {
                    Get.to(() => const ContactUsScreen());
                  },
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey, width: 1)),
                  ),
                  padding: const EdgeInsets.only(top: 5),
                  child: const Column(
                    children: [
                      Text(
                        'Developed by',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorRes.secondaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Flutter Bangla',
                        style: TextStyle(
                          fontSize: 17,
                          color: ColorRes.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Fb.com/FlutterBangla',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: ColorRes.secondaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Bottom Description and Loader
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 50.0),
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
