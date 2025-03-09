// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/lyric_controller.dart';
// import '../widget/global_app_bar.dart';
// import '../widget/global_button.dart';
// import '../widget/global_textform_field.dart';
// import '../model/lyric_model.dart';
//
// class UpdateBanglaSongsLyricScreen extends StatelessWidget {
//   final Lyric lyric;
//
//   const UpdateBanglaSongsLyricScreen({super.key, required this.lyric});
//
//   @override
//   Widget build(BuildContext context) {
//     final LyricController controller = Get.put(LyricController());
//
//     // Set the initial values of the text fields with the passed lyric
//     controller.titleController.text = lyric.title;
//     controller.fullLyricController.text = lyric.fullLyric;
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: const GlobalAppBar(title: "Update Bangla Songs Lyrics"),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               GlobalTextFormField(
//                 controller: controller.titleController,
//                 titleText: 'Lyric Title',
//                 hintText: 'Update Lyric Title',
//                 isDense: true,
//                 maxLine: 1,
//                 filled: true,
//               ),
//               const SizedBox(height: 10),
//               GlobalTextFormField(
//                 controller: controller.fullLyricController,
//                 titleText: 'Full Lyric',
//                 hintText: 'Update Full Lyric',
//                 isDense: true,
//                 maxLine: 20,
//                 filled: true,
//               ),
//               const SizedBox(height: 20),
//               GlobalButtonWidget(
//                 str: 'Update',
//                 height: 45,
//                 onTap: () {
//                   // Call the controller's updateLyric function
//                   controller.updateLyric(lyric.id);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
