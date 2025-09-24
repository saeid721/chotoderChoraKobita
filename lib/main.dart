import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/splash_screen/splash_screen.dart';
import 'global/widget/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.redAccent,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Something went wrong!\n${details.exceptionAsString()}',
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  };
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
