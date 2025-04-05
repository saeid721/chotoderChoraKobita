import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/genaral/bangla_kobita_data.dart';
import '../../../../../global/widget/manu_item_widget.dart';
import '../../../../../global/widget/colors.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../../../global/widget/global_container.dart';
import 'bangla_full_kobita_screen.dart';

class BanglaKobitaListScreen extends StatelessWidget {
  const BanglaKobitaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const GlobalAppBar(title: "ছোটদের বাংলা ছড়া-কবিতা"),
      body: GlobalContainer(
        backgroundColor: ColorRes.backgroundColor,
        width: size.width,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: List.generate(banglaKobitaData.length, (index) {
              final kobita = banglaKobitaData[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ManuItem(
                  title: kobita.title,
                  onTap: () {
                    Get.to(() => BanglaFullKobitaScreen(id: kobita.id));
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
