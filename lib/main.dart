import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/splash_screen/splash_screen.dart';
import 'global/widget/colors.dart';

void main() async {
  runApp(const IslamicSongsLyricsApp());
}

class IslamicSongsLyricsApp extends StatelessWidget {
  const IslamicSongsLyricsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: ColorRes.backgroundColor),
      title: 'ছোটদের মজার ছড়া ও কবিতা',
      home: const SplashScreen(),
    );
  }
}
