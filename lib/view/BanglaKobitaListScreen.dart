// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/kobita_controller.dart';
// import '../global/widget/chapter_item_widget.dart';
// import '../global/widget/global_app_bar.dart';
// import 'BanglaKobitaFullScreen.dart';
//
// class BanglaKobitaListScreen extends StatelessWidget {
//   const BanglaKobitaListScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final LyricController controller = Get.put(LyricController());
//
//     return Scaffold(
//       appBar: const GlobalAppBar(title: "ছোটদের বাংলা ছড়া ও কবিতা"),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 15, right: 15),
//           child: Column(
//             children: [
//               const SizedBox(height: 10),
//               Obx(() {
//                 return Expanded(  // Wrap with Expanded to avoid unbounded height
//                   child: ListView.builder(
//                     itemCount: controller.lyrics.length,
//                     itemBuilder: (context, index) {
//                       return Column(
//                         children: [
//                           ChapterItem(
//                             title: controller.lyrics[index].title,
//                             onTap: () {
//                               Get.to(() => BanglaKobitaFullScreen(lyric: controller.lyrics[index]));
//                             },
//                           ),
//                           const SizedBox(height: 5),
//                         ],
//                       );
//                     },
//                   ),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     //Get.to(() => const AddBanglaSongsLyricScreen());
//       //   },
//       //   tooltip: "Add New Lyric",
//       //   child: const Icon(Icons.add, color: ColorRes.primaryColor),
//       // ),
//     );
//   }
// }
