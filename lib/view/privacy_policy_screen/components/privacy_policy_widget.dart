// import 'package:flutter/material.dart';
// import 'package:kalti/global/widget/global_sizedbox.dart';
// import '../../../../../global/constants/colors_resources.dart';
// import '../../../../../global/constants/enum.dart';
// import '../../../../../global/widget/global_container.dart';
// import '../../../../../global/widget/global_image_loader.dart';
// import '../../../../../global/widget/global_text.dart';
//
// class PrivacyPolicyWidget extends StatelessWidget {
//   final String title;
//   final String titleOne;
//   final String titleTwo;
//   final String titleThree;
//   final String titleFour;
//   final String titleFive;
//   final String titleSix;
//   final String titleSeven;
//   final String titleEight;
//   final String titleNine;
//   final String text;
//
//   const PrivacyPolicyWidget({
//     super.key,
//     required this.title,
//     required this.titleOne,
//     required this.titleTwo,
//     required this.titleThree,
//     required this.titleFour,
//     required this.titleFive,
//     required this.titleSix,
//     required this.titleSeven,
//     required this.titleEight,
//     required this.titleNine,
//     required this.text,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GlobalContainer(
//       child: Column(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               GlobalText(
//                 str: title,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: ColorRes.black,
//                 textAlign: TextAlign.center,
//               ),
//               const Divider(),
//               GlobalText(
//                 str: text,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 textAlign: TextAlign.justify,
//               ),
//               sizedBoxH(5),
//               GlobalText(
//                 str: titleOne,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: ColorRes.black,
//                 textAlign: TextAlign.center,
//               ),
//               const Divider(),
//               GlobalText(
//                 str: text,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 textAlign: TextAlign.justify,
//               ),
//               sizedBoxH(5),
//               GlobalText(
//                 str: titleTwo,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: ColorRes.black,
//                 textAlign: TextAlign.center,
//               ),
//               const Divider(),
//               GlobalText(
//                 str: text,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 textAlign: TextAlign.justify,
//               ),
//               sizedBoxH(5),
//               GlobalText(
//                 str: titleThree,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: ColorRes.black,
//                 textAlign: TextAlign.center,
//               ),
//               const Divider(),
//               GlobalText(
//                 str: text,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 textAlign: TextAlign.justify,
//               ),
//               sizedBoxH(5),
//               GlobalText(
//                 str: titleFour,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: ColorRes.black,
//                 textAlign: TextAlign.center,
//               ),
//               const Divider(),
//               GlobalText(
//                 str: text,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 textAlign: TextAlign.justify,
//               ),
//               sizedBoxH(5),
//               GlobalText(
//                 str: titleFive,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: ColorRes.black,
//                 textAlign: TextAlign.center,
//               ),
//               const Divider(),
//               GlobalText(
//                 str: text,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 textAlign: TextAlign.justify,
//               ),
//               sizedBoxH(5),
//               GlobalText(
//                 str: titleSix,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: ColorRes.black,
//                 textAlign: TextAlign.center,
//               ),
//               const Divider(),
//               GlobalText(
//                 str: text,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 textAlign: TextAlign.justify,
//               ),
//               sizedBoxH(5),
//               GlobalText(
//                 str: titleSeven,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: ColorRes.black,
//                 textAlign: TextAlign.center,
//               ),
//               const Divider(),
//               GlobalText(
//                 str: text,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 textAlign: TextAlign.justify,
//               ),
//               sizedBoxH(5),
//               GlobalText(
//                 str: titleEight,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: ColorRes.black,
//                 textAlign: TextAlign.center,
//               ),
//               const Divider(),
//               GlobalText(
//                 str: text,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 textAlign: TextAlign.justify,
//               ),
//               sizedBoxH(5),
//               GlobalText(
//                 str: titleNine,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: ColorRes.black,
//                 textAlign: TextAlign.center,
//               ),
//               const Divider(),
//               GlobalText(
//                 str: text,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 textAlign: TextAlign.justify,
//               ),
//               sizedBoxH(5),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
