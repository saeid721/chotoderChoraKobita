// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../global/widget/colors.dart';
// import '../../../../global/widget/enum.dart';
// import '../../../../global/widget/global_image_loader.dart';
// import '../../../../global/widget/global_text.dart';
// import '../../../../global/widget/images.dart';
//
// class EnglishPoemWidget extends StatelessWidget {
//   final String fullPoem;
//
//   const EnglishPoemWidget({
//     super.key,
//     required this.fullPoem,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final availableHeight = Get.height - kToolbarHeight - MediaQuery.of(context).padding.top;
//     final isLargeScreen = Get.width > 400;
//
//     return SizedBox(
//       height: availableHeight,
//       width: Get.width,
//       child: Stack(
//         children: [
//           // Background Image
//           GlobalImageLoader(
//             imagePath: Images.kobitaBg,
//             width: Get.width,
//             height: availableHeight,
//             fit: BoxFit.fill,
//             imageFor: ImageFor.asset,
//           ),
//
//           // Poem Content
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: GlobalText(
//                   str: fullPoem,
//                   fontSize: isLargeScreen ? 21 : 18,
//                   fontWeight: FontWeight.w600,
//                   color: ColorRes.textColor,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
