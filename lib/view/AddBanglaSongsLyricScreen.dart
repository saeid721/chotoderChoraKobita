// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/lyric_controller.dart';
// import '../widget/global_app_bar.dart';
// import '../widget/global_button.dart';
// import '../widget/global_textform_field.dart';
//
// class AddBanglaSongsLyricScreen extends StatelessWidget {
//   const AddBanglaSongsLyricScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final LyricController controller = Get.put(LyricController());
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: const GlobalAppBar(title: "Add Bangla Songs Lyrics"),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               GlobalTextFormField(
//                 controller: controller.titleController,
//                 titleText: 'Lyric Title',
//                 hintText: 'Enter Lyric Title',
//                 isDense: true,
//                 maxLine: 1,
//                 filled: true,
//               ),
//               const SizedBox(height: 10),
//               GlobalTextFormField(
//                 controller: controller.fullLyricController,
//                 titleText: 'Full Lyric',
//                 hintText: 'Enter Full Lyric',
//                 isDense: true,
//                 maxLine: 20,
//                 filled: true,
//               ),
//               const SizedBox(height: 20),
//               GlobalButtonWidget(
//                 str: 'Submit',
//                 height: 45,
//                 onTap: controller.addLyric,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
