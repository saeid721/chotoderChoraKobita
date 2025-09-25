import 'package:flutter/material.dart';

class MemoryMatchScreen extends StatefulWidget {
  const MemoryMatchScreen({super.key});

  @override
  State<MemoryMatchScreen> createState() => _MemoryMatchScreenState();
}

class _MemoryMatchScreenState extends State<MemoryMatchScreen> {
  int score = 0;
  late List<CardData> cards;
  CardData? firstFlipped;
  CardData? secondFlipped;
  bool isProcessing = false;
  String feedback = '';

  @override
  void initState() {
    super.initState();
    cards = generateCards();
  }

  // Generate a 4x4 grid of card pairs
  List<CardData> generateCards() {
    final emojis = ['🐶', '🐱', '🐰', '🦁', '🐻', '🦒', '🐘', '🦊'];
    final pairs = [...emojis, ...emojis]..shuffle();
    return List.generate(16, (index) => CardData(emoji: pairs[index], id: index));
  }

  // Handle card tap
  void onCardTapped(CardData card) {
    if (isProcessing || card.isFlipped || card.isMatched) return;

    setState(() {
      card.isFlipped = true;
      if (firstFlipped == null) {
        firstFlipped = card;
      } else {
        secondFlipped = card;
        isProcessing = true;
        if (firstFlipped!.emoji == secondFlipped!.emoji) {
          // Match found
          firstFlipped!.isMatched = true;
          secondFlipped!.isMatched = true;
          score += 20;
          feedback = 'Match! 🎉';
          firstFlipped = null;
          secondFlipped = null;
          isProcessing = false;
          if (cards.every((card) => card.isMatched)) {
            feedback = 'You Win! 🌟';
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  cards = generateCards();
                  score = 0;
                  feedback = '';
                });
              }
            });
          }
        } else {
          // No match
          feedback = 'Try again! 😊';
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              setState(() {
                firstFlipped!.isFlipped = false;
                secondFlipped!.isFlipped = false;
                firstFlipped = null;
                secondFlipped = null;
                isProcessing = false;
                feedback = '';
              });
            }
          });
        }
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
                  _buildCardGrid(),
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
                  colors: [Colors.orangeAccent, Colors.yellowAccent],
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
                  'Memory Match',
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
        color: Colors.orangeAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        'Score: $score 🌟',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20),
      ),
    );
  }

  // Card grid
  Widget _buildCardGrid() {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1,
      children: List.generate(cards.length, (index) {
        return MemoryCard(
          card: cards[index],
          onTap: () => onCardTapped(cards[index]),
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
          color: feedback.contains('Match') || feedback.contains('Win')
              ? Colors.green
              : Colors.redAccent,
        ),
      ),
    );
  }
}

// Card data model
class CardData {
  final String emoji;
  final int id;
  bool isFlipped;
  bool isMatched;

  CardData({
    required this.emoji,
    required this.id,
    this.isFlipped = false,
    this.isMatched = false,
  });
}

// Memory card widget with flip animation
class MemoryCard extends StatefulWidget {
  final CardData card;
  final VoidCallback onTap;
  final int index;

  const MemoryCard({
    super.key,
    required this.card,
    required this.onTap,
    required this.index,
  });

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    // Staggered initial animation
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void didUpdateWidget(MemoryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.card.isFlipped != oldWidget.card.isFlipped) {
      if (widget.card.isFlipped) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
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
        final isFlipped = _flipAnimation.value > 0.5;
        final angle = _flipAnimation.value * 3.14159; // 180 degrees in radians

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective
            ..rotateY(angle),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: widget.card.isMatched ? null : widget.onTap,
            child: Container(
              decoration: BoxDecoration(
                color: isFlipped || widget.card.isMatched
                    ? Colors.orangeAccent.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  isFlipped || widget.card.isMatched ? widget.card.emoji : '❓',
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