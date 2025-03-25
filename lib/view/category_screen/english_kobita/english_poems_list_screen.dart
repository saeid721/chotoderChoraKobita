import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/genaral/english_poems_data.dart';
import '../../../../../global/widget/colors.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../../../global/widget/global_container.dart';
import '../../../global/widget/manu_item_widget.dart';
import 'english_full_kobita_screen.dart';

class EnglishPoemsListScreen extends StatefulWidget {
  const EnglishPoemsListScreen({super.key});

  @override
  State<EnglishPoemsListScreen> createState() => _EnglishPoemsListScreenState();
}

class _EnglishPoemsListScreenState extends State<EnglishPoemsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: "English Rhymes-Poems for Children"),
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
                  itemCount: englishPoemsClassOneData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final englishPoem = englishPoemsClassOneData[index];
                    return Column(
                      children: [
                        ManuItem(
                          title: englishPoem.title,
                          onTap: () {
                            Get.to(() => EnglishFullPoemScreen(id: englishPoem.id));
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