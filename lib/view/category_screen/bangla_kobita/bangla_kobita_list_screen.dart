// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../data/genaral/bangla_kobita_data.dart';
// import '../../../../../global/widget/manu_item_widget.dart';
// import '../../../../../global/widget/colors.dart';
// import '../../../../../global/widget/global_app_bar.dart';
// import '../../../../../global/widget/global_container.dart';
// import 'bangla_full_kobita_screen.dart';
//
// class BanglaKobitaListScreen extends StatelessWidget {
//   const BanglaKobitaListScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       appBar: const GlobalAppBar(title: "ছোটদের বাংলা ছড়া-কবিতা"),
//       body: GlobalContainer(
//         backgroundColor: ColorRes.backgroundColor,
//         width: size.width,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//           child: Column(
//             children: List.generate(banglaKobitaData.length, (index) {
//               final kobita = banglaKobitaData[index];
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 8),
//                 child: ManuItem(
//                   title: kobita.title,
//                   onTap: () {
//                     Get.to(() => BanglaFullKobitaScreen(id: kobita.id));
//                   },
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/genaral/bangla_kobita_data.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../global/widget/global_sizedbox.dart';
import '../../../global/widget/global_text.dart';
import 'bangla_full_kobita_screen.dart';

class BanglaKobitaListScreen extends StatefulWidget {
  const BanglaKobitaListScreen({super.key});

  @override
  State<BanglaKobitaListScreen> createState() => _BanglaKobitaListScreenState();
}

class _BanglaKobitaListScreenState extends State<BanglaKobitaListScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final List<AnimationController> _itemControllers = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    // Initialize controllers for each item
    for (int i = 0; i < banglaKobitaData.length; i++) {
      _itemControllers.add(
        AnimationController(
          duration: Duration(milliseconds: 300 + (i * 50)),
          vsync: this,
        ),
      );
    }

    // Animate items in sequence
    _animateItemsIn();
  }

  void _animateItemsIn() async {
    for (var controller in _itemControllers) {
      controller.forward();
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<dynamic> get filteredPoems {
    if (searchQuery.isEmpty) return banglaKobitaData;
    return banglaKobitaData.where((poem) =>
        poem.title.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const GlobalAppBar(title: "ছোটদের বাংলা ছড়া-কবিতা"),
      body: Container(
        width: size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE6F0),
              Color(0xFFE1F5FE),
              Color(0xFFF3E5F5),
            ],
          ),
        ),
        child: Column(
          children: [
            // Header with search and fun animations
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Fun header with bouncing text
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + (_animationController.value * 0.03),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF9A8B), Color(0xFFA8E6CF)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pink.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('📖', style: TextStyle(fontSize: 24)),
                              sizedBoxW(10),
                              Text(
                                'তোমার পছন্দের কবিতা খুঁজে নাও!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              sizedBoxW(10),
                              Text('🎭', style: TextStyle(fontSize: 24)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  sizedBoxH(20),

                  // Search bar with fun design
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: '🔍 কবিতার নাম খুঁজুন...',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        suffixIcon: searchQuery.isNotEmpty
                            ? IconButton(
                          onPressed: () {
                            setState(() {
                              searchQuery = '';
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                            : const Icon(Icons.search, color: Colors.purple),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Poems list with animations
            Expanded(
              child: filteredPoems.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: filteredPoems.length,
                itemBuilder: (context, index) {
                  final poem = filteredPoems[index];
                  final controllerIndex = banglaKobitaData.indexOf(poem);

                  return AnimatedBuilder(
                    animation: _itemControllers[controllerIndex],
                    builder: (context, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _itemControllers[controllerIndex],
                          curve: Curves.elasticOut,
                        )),
                        child: FadeTransition(
                          opacity: _itemControllers[controllerIndex],
                          child: _buildPoemCard(poem, index),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoemCard(dynamic poem, int index) {
    final colors = [
      [const Color(0xFFFFB6C1), const Color(0xFFFFE4E1)], // pink blush
      [const Color(0xFFB6E5D8), const Color(0xFFE8F8F5)], // mint aqua
      [const Color(0xFFD4B6FF), const Color(0xFFF0E6FF)], // lavender
      [const Color(0xFFFFF8B6), const Color(0xFFFFFDE7)], // light lemon
      [const Color(0xFFFFD4B6), const Color(0xFFFFF2E6)], // peach soft
      [const Color(0xFFFFD6E8), const Color(0xFFFFF0F5)], // rose pink
      [const Color(0xFFD4E6FF), const Color(0xFFF0F6FF)], // sky blue
      [const Color(0xFFFFF5CC), const Color(0xFFFFFAE5)], // pastel cream
      [const Color(0xFFE6D6FF), const Color(0xFFF5EFFF)], // soft violet
      [const Color(0xFFCFFFE0), const Color(0xFFE6FFF2)], // light green
      [const Color(0xFFFFE6CC), const Color(0xFFFFF2E5)], // apricot
      [const Color(0xFFD6F5FF), const Color(0xFFEFFFFF)], // ice blue
      [const Color(0xFFFFCCE5), const Color(0xFFFFE6F2)], // blush pink
      [const Color(0xFFCCFFF5), const Color(0xFFE5FFFA)], // aqua pastel
      [const Color(0xFFFFC1CC), const Color(0xFFFFE4E9)], // soft rose
      [const Color(0xFFB3E5FC), const Color(0xFFE1F5FE)], // baby blue
      [const Color(0xFFFFF9C4), const Color(0xFFFFFFE0)], // lemon cream
      [const Color(0xFFC8E6C9), const Color(0xFFE8F5E9)], // mint leaf
      [const Color(0xFFD1C4E9), const Color(0xFFEDE7F6)], // lilac
      [const Color(0xFFFFCCBC), const Color(0xFFFFE0B2)], // soft coral
      [const Color(0xFFFFF176), const Color(0xFFFFF59D)], // mellow yellow
      [const Color(0xFFB2EBF2), const Color(0xFFE0F7FA)], // aqua mist
      [const Color(0xFFF8BBD0), const Color(0xFFFCE4EC)], // rosy pastel
      [const Color(0xFFDCEDC8), const Color(0xFFF1F8E9)], // green meadow
      [const Color(0xFFB39DDB), const Color(0xFFD1C4E9)], // lavender haze
      [const Color(0xFFFFAB91), const Color(0xFFFFCCBC)], // peach coral
      [const Color(0xFFFFF59D), const Color(0xFFFFFFD9)], // butter cream
      [const Color(0xFFA5D6A7), const Color(0xFFC8E6C9)], // leafy mint
      [const Color(0xFF90CAF9), const Color(0xFFBBDEFB)], // soft blue
      [const Color(0xFFE6EE9C), const Color(0xFFF0F4C3)], // lime pastel
    ];

    final cardColors = colors[index % colors.length];
    final kobitaIcons = [
      '☀️', // প্রভাতী
      '🦜', // আয়রে আয় টিয়ে
      '🐦', // কানা বগীর ছা
      '👦', // খোকন খোকন ডাক পাড়ি
      '🕊️', // নোটন নোটন পায়রাগুলি
      '🦜', // আতা গাছে তোতা পাখি
      '🥭', // আম পাতা জোড়া-জোড়া
      '🌙', // আয় আয় চাঁদ মামা
      '👩‍👦', // খোকন খোকন করে মায়
      '😲', // ওরে বাবা
      '🏡', // তাই তাই মামা বাড়ি যাই
      '🏞️', // আমাদের ছোট নদী
      '🐦', // আমি হব
      '💍', // বাক বাক্‌ কুম পায়রা
      '🙏', // আমার পণ
      '🌸', // চাদ উঠেছে ফুল ফুটেছে
      '👧', // আয়রে আয় মিনি
      '🌧️', // আয় বৃষ্টি ঝেঁপে
      '😴', // ঘুম পাড়ানী মাসি পিসি
      '🌾', // আমাদের গ্রাম
      '👰', // দোল দোল দুলুনি
      '🦁', // সিংহ মামা
      '✨', // খোকার সাধ
      '💪', // সংকল্প
      '✅', // পারিব না
      '💭', // ইচ্ছা
      '🤔', // ষোল আনাই মিছে
      '🏇', // বীর পুরুষ
      '😀', // হাসি
      '🐝', // কাজের লোক
    ];

    final cardIcon = kobitaIcons[index % kobitaIcons.length];

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () {
          Get.to(
                () => BanglaFullKobitaScreen(id: poem.id),
            transition: Transition.rightToLeft,
            duration: const Duration(milliseconds: 300),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: cardColors,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: cardColors[0].withValues(alpha: 1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: cardColors[0].withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background decoration
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // Card content
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    // Fun icon container
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        cardIcon,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),

                    sizedBoxW(10),

                    // Poem title and number
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            poem.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2D3748),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'কবিতা #${index + 1}',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: cardColors[0],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Arrow with bounce animation
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(5 * _animationController.value, 0),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: cardColors[0].withValues(alpha: 1),
                              size: 16,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_animationController.value * 0.1),
                child: const Text('🔍', style: TextStyle(fontSize: 80)),
              );
            },
          ),
          sizedBoxH(20),
          GlobalText(
            str: 'কোন কবিতা খুঁজে পাওয়া যায়নি!',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
          ),
          sizedBoxH(10),
          GlobalText(
            str: 'অন্য নাম দিয়ে খুঁজে দেখুন',
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }
}