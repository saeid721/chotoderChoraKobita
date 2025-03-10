import 'package:flutter/material.dart';
import '../../global/widget/colors.dart';
import '../../global/widget/global_sizedbox.dart';
import '../../global/widget/global_text.dart';

class AppPrivacyPolicyScreen extends StatefulWidget {
  const AppPrivacyPolicyScreen({super.key});

  @override
  State<AppPrivacyPolicyScreen> createState() => _AppPrivacyPolicyScreenState();
}

class _AppPrivacyPolicyScreenState extends State<AppPrivacyPolicyScreen> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

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
          str: "Privacy & Policy",
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: ColorRes.white,
        ),
        centerTitle: true,
        //backgroundColor: ColorRes.title,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GlobalText(
                str: "Privacy & Policy",
                color: ColorRes.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
              const GlobalText(
                str:
                    """This privacy policy applies to the ছোটদের মজার ছড়া ও কবিতা app for mobile devices that was created by STITBD as a Free service. This service is intended for use "AS IS".""",
                color: ColorRes.dark,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
              ),
              sizedBoxH(5),
              const GlobalText(
                str:
                    "What information does the Application obtain and how is it used?",
                color: ColorRes.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
              const GlobalText(
                str:
                    "The Application does not obtain any information when you download and use it. Registration is not required to use the Application.",
                color: ColorRes.dark,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
              ),
              sizedBoxH(5),
              const GlobalText(
                str:
                    "Does the Application collect precise real time location information of the device?",
                color: ColorRes.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
              const GlobalText(
                str:
                    "This Application does not collect precise information about the location of your mobile device.",
                color: ColorRes.dark,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
              ),
              sizedBoxH(5),
              const GlobalText(
                str:
                    "Do third parties see and/or have access to information obtained by the Application?",
                color: ColorRes.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
              const GlobalText(
                str:
                    "Since the Application does not collect any information, no data is shared with third parties.",
                color: ColorRes.dark,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
              ),
              sizedBoxH(5),
              const GlobalText(
                str: "What are my opt-out rights?",
                color: ColorRes.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
              const GlobalText(
                str:
                    "You can stop all collection of information by the Application easily by uninstalling it. You may use the standard uninstall processes as may be available as part of your mobile device or via the mobile application marketplace or network.",
                color: ColorRes.dark,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
              ),
              sizedBoxH(5),
              const GlobalText(
                str: "Children",
                color: ColorRes.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
              const GlobalText(
                str:
                    """""The Application is not used to knowingly solicit data from or market to children under the age of 13.
The Service Provider does not knowingly collect personally identifiable information from children. The Service Provider encourages all children to never submit any personally identifiable information through the Application and/or Services. The Service Provider encourage parents and legal guardians to monitor their children's Internet usage and to help enforce this Policy by instructing their children never to provide personally identifiable information through the Application and/or Services without their permission. If you have reason to believe that a child has provided personally identifiable information to the Service Provider through the Application and/or Services, please contact the Service Provider (info@KaltiEngineering.com) so that they will be able to take the necessary actions. You must also be at least 16 years of age to consent to the processing of your personally identifiable information in your country (in some countries we may allow your parent or guardian to do so on your behalf)."""
                    "",
                color: ColorRes.dark,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
              ),
              sizedBoxH(5),
              const GlobalText(
                str: "Security",
                color: ColorRes.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
              const GlobalText(
                str:
                    "The Service Provider is concerned about safeguarding the confidentiality of your information. However, since the Application does not collect any information, there is no risk of your data being accessed by unauthorized individuals.",
                color: ColorRes.dark,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
              ),
              sizedBoxH(5),
              const GlobalText(
                str: "Changes",
                color: ColorRes.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
              const GlobalText(
                str:
                    """""This Privacy Policy may be updated from time to time for any reason. The Service Provider will notify you of any changes to their Privacy Policy by updating this page with the new Privacy Policy. You are advised to consult this Privacy Policy regularly for any changes, as continued use is deemed approval of all changes.
This privacy policy is effective as of 2025-02-01"""
                    "",
                color: ColorRes.dark,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
              ),
              sizedBoxH(5),
              const GlobalText(
                str: "Your Consent",
                color: ColorRes.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
              const GlobalText(
                str:
                    "By using the Application, you are consenting to the processing of your information as set forth in this Privacy Policy now and as amended by the Service Provider.",
                color: ColorRes.dark,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
              ),
              sizedBoxH(5),
              const GlobalText(
                str: "Contact Us",
                color: ColorRes.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
              const GlobalText(
                str:
                    "If you have any questions regarding privacy while using the Application, or have questions about the practices, please contact the Service Provider via email at info@KaltiEngineering.com.",
                color: ColorRes.dark,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.justify,
              ),
              sizedBoxH(5),
            ],
          ),
        ),
      ),
    );
  }
}
