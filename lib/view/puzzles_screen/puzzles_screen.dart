import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'logic_leap_screen.dart';
import 'math_mania_screen.dart';
import 'memory_match_screen.dart';
import 'riddle_rush_screen.dart';
import 'shape_shifter_screen.dart';
import 'word_wizard_screen.dart';

class PuzzlesScreen extends StatelessWidget {
  const PuzzlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Background gradient
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.purpleAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Glassmorphism effect
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Puzzles & Brain Games',
                        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 28,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: _buildCategoryHeader()),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverMasonryGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childCount: puzzleData.length,
              itemBuilder: (context, index) => PuzzleCard(
                puzzle: puzzleData[index],
                index: index,
              ),
            ),
          ),
        ],
      ),
    );
  }


  // Category header
  Widget _buildCategoryHeader() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Choose Your Puzzle',
        style: TextStyle(
          fontFamily: 'ComicNeue',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

}

// Puzzle data model
class Puzzle {
  final String title;
  final String slug;
  final String icon;
  final Color color;

  Puzzle({required this.title, required this.slug, required this.icon, required this.color});
}

final List<Puzzle> puzzleData = [
  Puzzle(title: 'Math Mania', slug:'mathMania', icon: '➕', color: Colors.blueAccent),
  Puzzle(title: 'Word Wizard', slug:'wordWizard', icon: '📜', color: Colors.purpleAccent),
  Puzzle(title: 'Memory Match', slug:'memoryMatch', icon: '🧠', color: Colors.orangeAccent),
  Puzzle(title: 'Shape Shifter', slug:'shapeShifter', icon: '🔶', color: Colors.greenAccent),
  Puzzle(title: 'Logic Leap', slug:'logicLeap', icon: '⚙️', color: Colors.redAccent),
  Puzzle(title: 'Riddle Rush', slug:'riddleRush', icon: '❓', color: Colors.tealAccent),
];

class PuzzleCard extends StatefulWidget {
  final Puzzle puzzle;
  final int index;

  const PuzzleCard({super.key, required this.puzzle, required this.index});

  @override
  State<PuzzleCard> createState() => _PuzzleCardState();
}

class _PuzzleCardState extends State<PuzzleCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    // Staggered animation start
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              _puzzlesCategoryTap(widget.puzzle);
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.puzzle.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.puzzle.icon,
                    style: const TextStyle(fontSize: 40),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.puzzle.title,
                    style: const TextStyle(
                      fontFamily: 'ComicNeue',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _puzzlesCategoryTap(Puzzle puzzle) {
    switch (puzzle.slug) {
      case 'mathMania':
        Get.to(() => const MathManiaScreen());
        break;
      case 'wordWizard':
        Get.to(() => const WordWizardScreen());
        break;
      case 'memoryMatch':
        Get.to(() => const MemoryMatchScreen());
        break;
      case 'shapeShifter':
        Get.to(() => const ShapeShifterScreen());
        break;
      case 'logicLeap':
        Get.to(() => const LogicLeapScreen());
        break;
      case 'riddleRush':
        Get.to(() => const RiddleRushScreen());
        break;
      default:
        Get.to(() => const PuzzlesScreen());
    }
  }
}
