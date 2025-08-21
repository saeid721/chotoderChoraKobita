import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/model/model.dart';
import '../../global/widget/images.dart';
import '../social_media_screen/telegram_screen.dart';
import '../social_media_screen/threads_screen.dart';
import '../social_media_screen/twitter_screen.dart';
import '../social_media_screen/whatsapp_screen.dart';
import '../../global/widget/colors.dart';
import '../../global/widget/global_text.dart';
import 'components/contact_widget.dart';
import 'components/social_media_widget.dart';
import '../social_media_screen/facebook_screen.dart';
import '../social_media_screen/instagram_screen.dart';
import '../social_media_screen/linkedin_screen.dart';
import '../social_media_screen/youtube_screen.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  List<GlobalMenuModel> menuItem = [
    GlobalMenuModel(img: Images.facebookInc, text: 'Facebook'),
    GlobalMenuModel(img: Images.linkedInInc, text: 'Linkedin'),
    GlobalMenuModel(img: Images.twitterInc, text: 'Twitter'),
    GlobalMenuModel(img: Images.youTubeInc, text: 'YouTube'),
    GlobalMenuModel(img: Images.instagramInc, text: 'Instagram'),
    GlobalMenuModel(img: Images.threadsInc, text: 'Threads'),
    GlobalMenuModel(img: Images.whatsAppInc, text: 'WhatsApp'),
    GlobalMenuModel(img: Images.telegramInc, text: 'Telegram'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.white,
      appBar: AppBar(
        elevation: 1,
        shadowColor: ColorRes.white200,
        backgroundColor: ColorRes.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const GlobalText(
          str: "Contact Us",
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: ColorRes.white,
        ),
        centerTitle: true,
        //backgroundColor: ColorRes.title,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              spacing: 5,
              children: [
                const GlobalText(
                  str: "আস-সালামু আলাইকুম ওয়া রহমাতুল্লাহি ওয়া বারকাতুহু",
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  textAlign: TextAlign.center,
                  color: ColorRes.primaryColor,
                ),
                const GlobalText(
                  str:
                      """সম্মানিত পাঠক-পাঠিকা আমাদের এই অ্যাপটি আপনাদের সেবাই তৈরি করেছি। আমরা আপ্রাণ চেষ্টা করি নিরবচ্ছিন্ন সেবা দিতে। তারপরও যদি কোন সমস্যা আপনাদের চোখে পড়ে অনুগ্রহপূর্বক আমাদের ফেসবুক পেজে ম্যাসেজ করে জানাবেন। আমরা সমাধান করবো। ইন-শাহ-আল্লাহ
সম্মানিত পাঠক-পাঠিকা অ্যাপটি যদি আপনাদের কাছে ভাল লাগে তাহলে প্লে স্টরে গিয়ে ৫ ***** স্টার  রেটিং দিয়ে সুন্দর একটি কমেন্ট করবেন সে আশাবাদী আপনাদের কাছে।
            """,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.justify,
                  color: ColorRes.dark,
                ),
                const SizedBox(height: 2),
                const GlobalText(
                  str: "Follow Us",
                  color: ColorRes.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                GridView.builder(
                    itemCount: menuItem.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 45),
                    //padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const FacebookScreen());
                              break;
                            case 1:
                              Get.to(() => const LinkedInScreen());
                              break;
                            case 2:
                              Get.to(() => const TwitterScreen());
                              break;
                            case 3:
                              Get.to(() => const YouTubeScreen());
                              break;
                            case 4:
                              Get.to(() => const InstagramScreen());
                              break;
                            case 5:
                              Get.to(() => const ThreadsScreen());
                              break;
                            case 6:
                              Get.to(() => const WhatsAppScreen());
                              break;
                            case 7:
                              Get.to(() => const TelegramScreen());
                              break;
                          }
                        },
                        child: SocialMediaWidget(
                          height: 24,
                          width: 24,
                          imagePath: menuItem[index].img,
                          text: menuItem[index].text,
                        ),
                      );
                    }),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorRes.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ColorRes.primaryColor, width: .3),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ContactDetailsWidget(
                        name: "STITBD",
                        address: "Level-2, 25/2 Lake Circus Road, Kalabagan, Dhanmondi, Dhaka, Bangladesh ",
                        email: "info@stitbd.com",
                        phone: "+88 01757-769498",
                        call: "Call",
                        sms: "SMS",
                        mail: "e-Mail",
                        map: "Map",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
