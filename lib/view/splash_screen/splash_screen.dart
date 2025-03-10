import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/widget/colors.dart';
import '../../global/widget/global_text.dart';
import '../../global/widget/enum.dart';
import '../../global/widget/global_image_loader.dart';
import '../../global/widget/images.dart';
import '../../controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late SplashController controller;

  @override
  void initState() {
    super.initState();
    controller = SplashController();
    controller.initializeAnimation(this, context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2), // Add space above
            // App Title
            // const GlobalText(
            //   str: "ছোটদের মজার ছড়া ও কবিতা",
            //   fontSize: 28,
            //   fontWeight: FontWeight.w700,
            //   textAlign: TextAlign.center,
            //   fontFamily: 'ComicNeue',
            //   color: ColorRes.primaryColor,
            //   isSelectable: false,
            // ),
            // const SizedBox(height: 30),
            // Animated Logo
            controller.scaleAnimation != null
                ? ScaleTransition(
              scale: controller.scaleAnimation!,
              child: GlobalImageLoader(
                imagePath: Images.splashScreen,
                width: Get.width * 0.9,
                fit: BoxFit.contain,
                imageFor: ImageFor.asset,
              ),
            )
                : GlobalImageLoader(
              imagePath: Images.splashScreen,
              width: Get.width * 0.9,
              fit: BoxFit.contain,
              imageFor: ImageFor.asset,
            ),
            const Spacer(flex: 2), // Add space below
            // Version Text at Bottom
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: GlobalText(
                str: "Version 1.0.1",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                color: ColorRes.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}