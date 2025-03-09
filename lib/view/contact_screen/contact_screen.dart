import 'package:flutter/material.dart';
import '../../../global/widget/colors.dart';
import '../../../global/widget/global_text.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: ColorRes.borderColor,
        iconTheme: const IconThemeData(color: ColorRes.primaryColor),
        title: const Text(
          'Contact Us',
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
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GlobalText(
                    str: """আস-সালামু আলাইকুম ওয়া রহমাতুল্লাহি ওয়া বারকাতুহু

সম্মানিত পাঠক-পাঠিকা আমাদের এই অ্যাপটি আপনাদের সেবাই তৈরি করেছি। আমরা আপ্রাণ চেষ্টা করি নিরবচ্ছিন্ন সেবা দিতে। তারপরও যদি কোন সমস্যা আপনাদের চোখে পড়ে অনুগ্রহপূর্বক আমাদের ফেসবুক পেজে ম্যাসেজ করে জানাবেন। আমরা সমাধান করবো। ইন-শাহ-আল্লাহ
সম্মানিত পাঠক-পাঠিকা অ্যাপটি যদি আপনাদের কাছে ভাল লাগে তাহলে প্লে স্টরে গিয়ে ৫ ***** স্টার  রেটিং দিয়ে সুন্দর একটি কমেন্ট করবেন সে আশাবাদী আপনাদের কাছে।


আমাদের ফেসবুক পেজের লিঙ্ক -
""",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: ColorRes.black,
                    isSelectable: false,
                  ),
                  GlobalText(
                    str: "www.facebook.com/FlutterBangla",
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: ColorRes.primaryColor,
                    isSelectable: false,
                  ),
                  SizedBox(height: 100),
                  GlobalText(
                    str: "www.flutterbangla.blogspot.com",
                    fontWeight: FontWeight.w700,
                    color: ColorRes.primaryColor,
                    fontSize: 18,
                    isSelectable: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
