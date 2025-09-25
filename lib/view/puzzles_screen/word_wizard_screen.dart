import 'package:flutter/material.dart';
import 'dart:math' show Random;


class WordWizardScreen extends StatefulWidget {
  const WordWizardScreen({super.key});

  @override
  State<WordWizardScreen> createState() => _WordWizardScreenState();
}

class _WordWizardScreenState extends State<WordWizardScreen> {
  int score = 0;
  late WordPuzzle currentPuzzle;
  List<String> answerSlots = [];
  String feedback = '';
  bool isAnswered = false;

  @override
  void initState() {
    super.initState();
    currentPuzzle = generatePuzzle();
    answerSlots = List.filled(currentPuzzle.word.length, '');
  }

  // Generate a random word puzzle
  WordPuzzle generatePuzzle() {
    final words = [
      WordPuzzle(word: 'CAT', hint: 'A furry pet', letters: []),
      WordPuzzle(word: 'DOG', hint: 'Loyal friend', letters: []),
      WordPuzzle(word: 'SUN', hint: 'Shines in the sky', letters: []),
      WordPuzzle(word: 'MOON', hint: 'Glows at night', letters: []),
      WordPuzzle(word: 'STAR', hint: 'Twinkles above', letters: []),
    ];
    final puzzle = words[Random().nextInt(words.length)];
    final shuffledLetters = puzzle.word.split('')..shuffle();
    return WordPuzzle(word: puzzle.word, hint: puzzle.hint, letters: shuffledLetters);
  }

  // Handle letter drop
  void onLetterDropped(String letter, int index) {
    setState(() {
      answerSlots[index] = letter;
      if (answerSlots.every((slot) => slot.isNotEmpty)) {
        final answer = answerSlots.join();
        isAnswered = true;
        if (answer == currentPuzzle.word) {
          score += 10;
          feedback = 'Correct! 🎉';
        } else {
          feedback = 'Try again! 😊';
        }
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              currentPuzzle = generatePuzzle();
              answerSlots = List.filled(currentPuzzle.word.length, '');
              isAnswered = false;
              feedback = '';
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildScoreDisplay(),
                  const SizedBox(height: 16),
                  _buildHintCard(),
                  const SizedBox(height: 16),
                  _buildAnswerSlots(),
                  const SizedBox(height: 16),
                  _buildLetterBank(),
                  if (feedback.isNotEmpty) _buildFeedback(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SliverAppBar with glassmorphism
  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purpleAccent, Colors.pinkAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
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
                  'Word Wizard',
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
    );
  }

  // Score display
  Widget _buildScoreDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.purpleAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        'Score: $score 🌟',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20),
      ),
    );
  }

  // Hint card
  Widget _buildHintCard() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Container(
        key: ValueKey(currentPuzzle.hint),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Text(
          'Hint: ${currentPuzzle.hint}',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Answer slots for dragging letters
  Widget _buildAnswerSlots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(currentPuzzle.word.length, (index) {
        return AnswerSlot(
          letter: answerSlots[index],
          index: index,
          isAnswered: isAnswered,
          onLetterDropped: onLetterDropped,
        );
      }),
    );
  }

  // Letter bank for draggable letters
  Widget _buildLetterBank() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: List.generate(currentPuzzle.letters.length, (index) {
        final letter = currentPuzzle.letters[index];
        return answerSlots.contains(letter)
            ? const SizedBox.shrink()
            : LetterTile(
          letter: letter,
          index: index,
        );
      }),
    );
  }

  // Feedback text
  Widget _buildFeedback() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        feedback,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 18,
          color: feedback.contains('Correct') ? Colors.green : Colors.redAccent,
        ),
      ),
    );
  }
}

// Word puzzle data model
class WordPuzzle {
  final String word;
  final String hint;
  final List<String> letters;

  WordPuzzle({required this.word, required this.hint, required this.letters});
}

// Answer slot widget
class AnswerSlot extends StatefulWidget {
  final String letter;
  final int index;
  final bool isAnswered;
  final Function(String, int) onLetterDropped;

  const AnswerSlot({
    super.key,
    required this.letter,
    required this.index,
    required this.isAnswered,
    required this.onLetterDropped,
  });

  @override
  State<AnswerSlot> createState() => _AnswerSlotState();
}

class _AnswerSlotState extends State<AnswerSlot> with SingleTickerProviderStateMixin {
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
          child: DragTarget<String>(
            onAccept: (letter) => widget.onLetterDropped(letter, widget.index),
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: widget.letter.isEmpty
                      ? Colors.grey.withOpacity(0.2)
                      : Colors.purpleAccent.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.letter,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// Letter tile widget
class LetterTile extends StatefulWidget {
  final String letter;
  final int index;

  const LetterTile({super.key, required this.letter, required this.index});

  @override
  State<LetterTile> createState() => _LetterTileState();
}

class _LetterTileState extends State<LetterTile> with SingleTickerProviderStateMixin {
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
          child: Draggable<String>(
            data: widget.letter,
            feedback: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.purpleAccent.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    widget.letter,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            childWhenDragging: const SizedBox.shrink(),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.purpleAccent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  widget.letter,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}