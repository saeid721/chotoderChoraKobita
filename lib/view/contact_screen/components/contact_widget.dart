import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../global/widget/colors.dart';
import '../../../global/widget/global_container.dart';
import '../../../global/widget/global_sizedbox.dart';
import '../../../global/widget/global_text.dart';

class ContactDetailsWidget extends StatelessWidget {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String call;
  final String sms;
  final String mail;
  final String map;

  final Function() onTap;
  const ContactDetailsWidget({
    super.key,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.call,
    required this.sms,
    required this.mail,
    required this.map,
    required this.onTap,
  });

  Future<void> _makePhoneCall(String phone) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phone);
    await launchUrl(launchUri);
  }

  Future<void> _sendSMS(String phone) async {
    final Uri smsUri = Uri(scheme: 'sms', path: phone);
    await launchUrl(smsUri);
  }

  Future<void> _sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(emailUri);
  }

  Future<void> _openGoogleMap(
      BuildContext context, String name, String address) async {
    final query = Uri.encodeComponent(" $name, $address");
    final geoUri =
        Uri.parse("#");

    if (await canLaunchUrl(geoUri)) {
      await launchUrl(geoUri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open Google Maps app.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlobalContainer(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        // borderRadiusCircular: 10,
        // borderColor: ColorRes.borderColor,
        elevation: 2,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.security_rounded,
                            size: 20,
                            color: ColorRes.primaryColor,
                          ),
                          sizedBoxW(5),
                          GlobalText(
                            str: name,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: ColorRes.dark,
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 18,
                            color: ColorRes.primaryColor,
                          ),
                          sizedBoxW(5),
                          GlobalText(
                            str: phone,
                            fontSize: 13,
                            color: ColorRes.dark,
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            size: 18,
                            color: ColorRes.primaryColor,
                          ),
                          sizedBoxW(5),
                          GlobalText(
                            str: email,
                            fontSize: 13,
                            color: ColorRes.dark,
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: ColorRes.primaryColor,
                          ),
                          sizedBoxW(5),
                          Expanded(
                            child: GlobalText(
                              str: address,
                              maxLines: 3,
                              fontSize: 13,
                              overflow: TextOverflow.ellipsis,
                              color: ColorRes.dark,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => _makePhoneCall(phone),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorRes.primaryColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person_pin_outlined,
                          size: 18,
                          color: ColorRes.red,
                        ),
                        sizedBoxW(5),
                        GlobalText(
                          str: call,
                          fontSize: 12,
                          color: ColorRes.dark,
                        ),
                      ],
                    ),
                  ),
                ),
                sizedBoxW(5),
                GestureDetector(
                  onTap: () => _sendSMS(phone),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorRes.primaryColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.home_repair_service,
                          size: 18,
                          color: ColorRes.red,
                        ),
                        sizedBoxW(5),
                        GlobalText(
                          str: sms,
                          fontSize: 12,
                          color: ColorRes.dark,
                        ),
                      ],
                    ),
                  ),
                ),
                sizedBoxW(5),
                GestureDetector(
                  onTap: () => _sendEmail(email),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorRes.primaryColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.mail,
                          size: 18,
                          color: ColorRes.red,
                        ),
                        sizedBoxW(5),
                        GlobalText(
                          str: mail,
                          fontSize: 12,
                          color: ColorRes.dark,
                        ),
                      ],
                    ),
                  ),
                ),
                sizedBoxW(5),
                GestureDetector(
                  onTap: () => _openGoogleMap(context, name, address),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorRes.primaryColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: ColorRes.red,
                        ),
                        sizedBoxW(5),
                        GlobalText(
                          str: map,
                          fontSize: 12,
                          color: ColorRes.dark,
                        ),
                      ],
                    ),
                  ),
                ),
                sizedBoxW(10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
