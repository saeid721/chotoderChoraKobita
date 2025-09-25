import 'package:flutter/material.dart';
import 'dart:math' show Random;

class RiddleRushScreen extends StatefulWidget {
  const RiddleRushScreen({super.key});

  @override
  State<RiddleRushScreen> createState() => _RiddleRushScreenState();
}

class _RiddleRushScreenState extends State<RiddleRushScreen> {
  int score = 0;
  late Riddle currentRiddle;
  bool isAnswered = false;
  String feedback = '';

  @override
  void initState() {
    super.initState();
    currentRiddle = generateRiddle();
  }

  // Generate a random riddle
  Riddle generateRiddle() {
    final riddles = [
      Riddle(
        question: 'What has a neck but no head, a body but no legs, and arms but no hands?',
        correctAnswer: 'Shirt',
        options: ['Shirt', 'Hat', 'Shoe', 'Glove'],
      ),
      Riddle(
        question: 'What has keys but can’t open locks?',
        correctAnswer: 'Piano',
        options: ['Piano', 'Door', 'Car', 'Box'],
      ),
      Riddle(
        question: 'What gets wetter the more it dries?',
        correctAnswer: 'Towel',
        options: ['Towel', 'Sponge', 'Soap', 'Brush'],
      ),
      Riddle(
        question: 'What has a heart that doesn’t beat?',
        correctAnswer: 'Artichoke',
        options: ['Artichoke', 'Apple', 'Carrot', 'Potato'],
      ),
      Riddle(
        question: 'What can fly without wings and cry without eyes?',
        correctAnswer: 'Cloud',
        options: ['Cloud', 'Bird', 'Plane', 'Kite'],
      ),
    ];
    return riddles[Random().nextInt(riddles.length)];
  }

  // Handle answer selection
  void checkAnswer(String selectedAnswer) {
    setState(() {
      isAnswered = true;
      if (selectedAnswer == currentRiddle.correctAnswer) {
        score += 10;
        feedback = 'Correct! 🎉';
      } else {
        feedback = 'Try again! 😊';
      }
    });

    // Move to next riddle after a delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          currentRiddle = generateRiddle();
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
                  _buildRiddleCard(),
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
                  colors: [Colors.tealAccent, Colors.cyanAccent],
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
                  'Riddle Rush',
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
        color: Colors.tealAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        'Score: $score 🌟',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20),
      ),
    );
  }

  // Riddle card
  Widget _buildRiddleCard() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Container(
        key: ValueKey(currentRiddle.question),
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
          currentRiddle.question,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20),
          textAlign: TextAlign.center,
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
      children: List.generate(currentRiddle.options.length, (index) {
        return AnswerButton(
          answer: currentRiddle.options[index],
          isAnswered: isAnswered,
          isCorrect: currentRiddle.options[index] == currentRiddle.correctAnswer,
          onPressed: () => checkAnswer(currentRiddle.options[index]),
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

// Riddle data model
class Riddle {
  final String question;
  final String correctAnswer;
  final List<String> options;

  Riddle({
    required this.question,
    required this.correctAnswer,
    required this.options,
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
    Color buttonColor = Colors.tealAccent.withOpacity(0.2);
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
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}