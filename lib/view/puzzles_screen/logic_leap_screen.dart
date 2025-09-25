import 'package:flutter/material.dart';
import 'dart:math' show Random;

class LogicLeapScreen extends StatefulWidget {
  const LogicLeapScreen({super.key});

  @override
  State<LogicLeapScreen> createState() => _LogicLeapScreenState();
}

class _LogicLeapScreenState extends State<LogicLeapScreen> {
  int score = 0;
  late LogicPuzzle currentPuzzle;
  bool isAnswered = false;
  String feedback = '';

  @override
  void initState() {
    super.initState();
    currentPuzzle = generatePuzzle();
  }

  // Generate a random logic puzzle
  LogicPuzzle generatePuzzle() {
    final random = Random();
    final puzzleType = random.nextBool() ? 'number' : 'shape';
    List<String> sequence;
    String correctAnswer;
    List<String> options;

    if (puzzleType == 'number') {
      // Number sequence (e.g., 2, 4, 6, ?)
      final start = random.nextInt(10) + 1;
      final step = random.nextInt(3) + 1;
      sequence = [
        start.toString(),
        (start + step).toString(),
        (start + 2 * step).toString(),
      ];
      correctAnswer = (start + 3 * step).toString();
      options = {correctAnswer, (start + 3 * step + random.nextInt(5) - 2).toString(), (start + 3 * step + random.nextInt(5) - 2).toString(), (start + 3 * step + random.nextInt(5) - 2).toString()}.toList()..shuffle();
    } else {
      // Shape sequence (e.g., circle, square, triangle, ?)
      final shapes = ['⚪', '⬛', '🔺', '⭐'];
      final index = random.nextInt(shapes.length);
      sequence = [
        shapes[index % shapes.length],
        shapes[(index + 1) % shapes.length],
        shapes[(index + 2) % shapes.length],
      ];
      correctAnswer = shapes[(index + 3) % shapes.length];
      options = shapes..shuffle();
    }

    return LogicPuzzle(
      sequence: sequence,
      correctAnswer: correctAnswer,
      options: options,
      hint: puzzleType == 'number' ? 'What number comes next?' : 'What shape comes next?',
    );
  }

  // Handle answer selection
  void checkAnswer(String selectedAnswer) {
    setState(() {
      isAnswered = true;
      if (selectedAnswer == currentPuzzle.correctAnswer) {
        score += 10;
        feedback = 'Correct! 🎉';
      } else {
        feedback = 'Try again! 😊';
      }
    });

    // Move to next puzzle after a delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          currentPuzzle = generatePuzzle();
          isAnswered = false;
          feedback = '';
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
                  _buildSequenceCard(),
                  const SizedBox(height: 16),
                  _buildAnswerButtons(),
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
                  colors: [Colors.redAccent, Colors.pinkAccent],
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
                  'Logic Leap',
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
        color: Colors.redAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        'Score: $score 🌟',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20),
      ),
    );
  }

  // Sequence card
  Widget _buildSequenceCard() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Container(
        key: ValueKey(currentPuzzle.sequence.join()),
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
        child: Column(
          children: [
            Text(
              currentPuzzle.hint,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var item in currentPuzzle.sequence)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const Text(
                  '?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Answer buttons
  Widget _buildAnswerButtons() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: List.generate(currentPuzzle.options.length, (index) {
        return AnswerButton(
          answer: currentPuzzle.options[index],
          isAnswered: isAnswered,
          isCorrect: currentPuzzle.options[index] == currentPuzzle.correctAnswer,
          onPressed: () => checkAnswer(currentPuzzle.options[index]),
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

// Logic puzzle data model
class LogicPuzzle {
  final List<String> sequence;
  final String correctAnswer;
  final List<String> options;
  final String hint;

  LogicPuzzle({
    required this.sequence,
    required this.correctAnswer,
    required this.options,
    required this.hint,
  });
}

// Answer button widget
class AnswerButton extends StatefulWidget {
  final String answer;
  final bool isAnswered;
  final bool isCorrect;
  final VoidCallback onPressed;
  final int index;

  const AnswerButton({
    super.key,
    required this.answer,
    required this.isAnswered,
    required this.isCorrect,
    required this.onPressed,
    required this.index,
  });

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> with SingleTickerProviderStateMixin {
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
    Color buttonColor = Colors.redAccent.withOpacity(0.2);
    if (widget.isAnswered) {
      buttonColor = widget.isCorrect ? Colors.green.withOpacity(0.3) : Colors.redAccent.withOpacity(0.3);
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: ElevatedButton(
            onPressed: widget.isAnswered ? null : widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.white.withOpacity(0.3)),
              ),
              padding: const EdgeInsets.all(16),
              elevation: 0,
            ),
            child: Text(
              widget.answer,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}