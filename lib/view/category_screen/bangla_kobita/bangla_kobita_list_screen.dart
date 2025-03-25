import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/genaral/bangla_songs_data.dart';
import '../../../../../global/widget/manu_item_widget.dart';
import '../../../../../global/widget/colors.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../../../global/widget/global_container.dart';
import 'bangla_full_kobita_screen.dart';

class BanglaKobitaListScreen extends StatefulWidget {
  const BanglaKobitaListScreen({super.key});

  @override
  State<BanglaKobitaListScreen> createState() => _BanglaKobitaListScreenState();
}

class _BanglaKobitaListScreenState extends State<BanglaKobitaListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: "ছোটদের বাংলা ছড়া-কবিতা"),
      body: GlobalContainer(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        backgroundColor: ColorRes.backgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                const SizedBox(height: 10),
                ListView.builder(
                  itemCount: banglaKobitaData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final songLyric = banglaKobitaData[index];
                    return Column(
                      children: [
                        ManuItem(
                          title: songLyric.title,
                          onTap: () {
                            Get.to(() => BanglaFullKobitaScreen(id: songLyric.id));
                          },
                        ),
                        const SizedBox(height: 5),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
