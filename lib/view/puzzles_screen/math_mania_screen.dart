import 'package:flutter/material.dart';
import 'dart:math' show Random;

class MathManiaScreen extends StatefulWidget {
  const MathManiaScreen({super.key});

  @override
  State<MathManiaScreen> createState() => _MathManiaScreenState();
}

class _MathManiaScreenState extends State<MathManiaScreen> {
  int score = 0;
  late MathQuestion currentQuestion;
  bool isAnswered = false;
  String feedback = '';

  @override
  void initState() {
    super.initState();
    currentQuestion = generateQuestion();
  }

  // Generate a random math question
  MathQuestion generateQuestion() {
    final random = Random();
    final operations = ['+', '-', '*'];
    final operation = operations[random.nextInt(3)];
    final num1 = random.nextInt(20) + 1; // Numbers between 1 and 20
    final num2 = random.nextInt(20) + 1;
    int correctAnswer;

    switch (operation) {
      case '+':
        correctAnswer = num1 + num2;
        break;
      case '-':
        correctAnswer = num1 - num2;
        break;
      case '*':
        correctAnswer = num1 * num2;
        break;
      default:
        correctAnswer = num1 + num2;
    }

    // Generate multiple-choice options
    final options = <int>{correctAnswer};
    while (options.length < 4) {
      final offset = random.nextInt(10) - 5; // Random offset ±5
      options.add(correctAnswer + offset);
    }
    return MathQuestion(
      question: '$num1 $operation $num2 = ?',
      correctAnswer: correctAnswer,
      options: options.toList()..shuffle(),
    );
  }

  // Handle answer selection
  void checkAnswer(int selectedAnswer) {
    setState(() {
      isAnswered = true;
      if (selectedAnswer == currentQuestion.correctAnswer) {
        score += 10;
        feedback = 'Correct! 🎉';
      } else {
        feedback = 'Oops, try again! 😊';
      }
    });

    // Move to next question after a delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          currentQuestion = generateQuestion();
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
                  _buildQuestionCard(),
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
                  colors: [Colors.blueAccent, Colors.cyanAccent],
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
                  'Math Mania',
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
        color: Colors.blueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        'Score: $score 🌟',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20),
      ),
    );
  }

  // Question card with animation
  Widget _buildQuestionCard() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Container(
        key: ValueKey(currentQuestion.question),
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
          currentQuestion.question,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Answer buttons with staggered animations
  Widget _buildAnswerButtons() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: List.generate(currentQuestion.options.length, (index) {
        return AnswerButton(
          answer: currentQuestion.options[index],
          isAnswered: isAnswered,
          isCorrect: currentQuestion.options[index] == currentQuestion.correctAnswer,
          onPressed: () => checkAnswer(currentQuestion.options[index]),
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

// Math question data model
class MathQuestion {
  final String question;
  final int correctAnswer;
  final List<int> options;

  MathQuestion({
    required this.question,
    required this.correctAnswer,
    required this.options,
  });
}

// Answer button widget with animation
class AnswerButton extends StatefulWidget {
  final int answer;
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

class _AnswerButtonState extends State<AnswerButton>
    with SingleTickerProviderStateMixin {
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
    Color buttonColor = Colors.blueAccent.withOpacity(0.2);
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
              widget.answer.toString(),
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