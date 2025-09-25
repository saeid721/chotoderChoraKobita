import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/genaral/english_poems_data.dart';
import '../../../../../global/widget/global_app_bar.dart';
import '../../../global/widget/global_sizedbox.dart';
import '../../../global/widget/global_text.dart';
import '../home_screen/controller/home_animation_controller.dart';
import 'english_full_poem_screen.dart';

class EnglishPoemsListScreen extends StatefulWidget {
  const EnglishPoemsListScreen({super.key});

  @override
  State<EnglishPoemsListScreen> createState() => _EnglishPoemsListScreenState();
}

class _EnglishPoemsListScreenState extends State<EnglishPoemsListScreen> with TickerProviderStateMixin {
  late BanglaKobitaAnimations animations;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    animations = BanglaKobitaAnimations(vsync: this);
    animations.init(itemCount: englishPoemsData.length);
    animations.animateItemsIn();
  }

  @override
  void dispose() {
    animations.dispose();
    super.dispose();
  }

  List<dynamic> get filteredPoems {
    if (searchQuery.isEmpty) return englishPoemsData;
    return englishPoemsData.where((poem) =>
        poem.title.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const GlobalAppBar(title: "English Rhymes-Poems for Children"),
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
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: animations.floatingController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + (animations.floatingController.value * 0.03),
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
                              GlobalText(
                                str: '📖',
                                fontSize: 24,
                              ),
                              sizedBoxW(10),
                              GlobalText(
                                str: 'Find your favorite poem!',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              sizedBoxW(10),
                              GlobalText(
                                str: '🎭',
                                fontSize: 24,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  sizedBoxH(20),
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
                        hintText: "🔍 Search for the poem's name...",
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
            Expanded(
              child: filteredPoems.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: animations.floatingController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1.0 + (animations.floatingController.value * 0.1),
                          child: const Text('🔍', style: TextStyle(fontSize: 80)),
                        );
                      },
                    ),
                    sizedBoxH(20),
                    GlobalText(
                      str: 'No poem could be found!',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3748),
                    ),
                    sizedBoxH(10),
                    GlobalText(
                      str: 'Try searching with a different name',
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: filteredPoems.length,
                itemBuilder: (context, index) {
                  final poem = filteredPoems[index];
                  final controllerIndex = englishPoemsData.indexOf(poem);

                  return AnimatedBuilder(
                    animation: animations.itemControllers[controllerIndex],
                    builder: (context, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animations.itemControllers[controllerIndex],
                          curve: Curves.elasticOut,
                        )),
                        child: FadeTransition(
                          opacity: animations.itemControllers[controllerIndex],
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
    final poemIcons = [
      '🛏️', // Early To Bed Early To Rise
      '🌟', // Twinkle Twinkle Little Star
      '🍬', // Johny Johny Yes Papa
      '👩‍👧', // Mommy and Daddy
      '🥚', // Humpty Dumpty
      '🌹', // Roses Are Red
      '🔔', // Ding Dong Bell
      '🤏', // Snap Yo Fingers

      '🐱', // One Little Kitten
      '🛁', // After A Bath
      '🎠', // Merry Go Round
      '🐦', // Once I saw a little Bird
      '🍎', // If I were an Apple
      '☁️', // Clouds
      '🪁', // A Kite
      '🦸‍♂️', // Flying Man
      '🛁', // After A Bath

      '🏫', // First Day At School
      '🍀', // I Am Lucky
      '😄', // A Smile
      '🌧️', // Rain
      '🦓', // Zoo Manners
      '👤', // Mr Nobody
      '✏️', // On My Blackboard I Can Draw
      '🎵', // I Am The Music Man
      '👵', // Granny Granny Please Comb My Hair
      '🗣️', // Strange Talk

      '🌞', // Good Morning
      '🐦', // Bird Talk
      '🐾', // Little by Little
      '🌊', // Sea Song
      '🎈', // The Balloon Man
      '🚂', // Trains
      '🐶', // Puppy and I
      '📬', // What’s in the Mailbox?
      '🤫', // Don’t Tell
      '🦎', // How Creatures Move
    ];

    final cardIcon = poemIcons[index % poemIcons.length];

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () {
          Get.to(
                () => EnglishFullPoemScreen(id: poem.id),
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GlobalText(
                            str: poem.title,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2D3748),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            isSelectable: false,
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
                            child: GlobalText(
                              str: 'Poem #${index + 1}',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: cardColors[0],
                              isSelectable: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedBuilder(
                      animation: animations.floatingController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(5 * animations.floatingController.value, 0),
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
}