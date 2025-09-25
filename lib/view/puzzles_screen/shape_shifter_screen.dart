import 'package:flutter/material.dart';

class ShapeShifterScreen extends StatefulWidget {
  const ShapeShifterScreen({super.key});

  @override
  State<ShapeShifterScreen> createState() => _ShapeShifterScreenState();
}

class _ShapeShifterScreenState extends State<ShapeShifterScreen> {
  int score = 0;
  late List<ShapeData> shapes;
  late List<ShapeData> slots;
  String feedback = '';
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  // Initialize or reset the game
  void _initializeGame() {
    shapes = generateShapes();
    slots = List.from(shapes)..shuffle();
  }

  // Generate shape pairs
  List<ShapeData> generateShapes() {
    final shapeTypes = [
      ShapeType.circle,
      ShapeType.square,
      ShapeType.triangle,
      ShapeType.star,
    ];
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
    ];
    final selectedShapes = List.generate(4, (index) {
      return ShapeData(
        type: shapeTypes[index],
        color: colors[index],
        id: index,
      );
    });
    return selectedShapes;
  }

  // Handle shape drop
  void onShapeDropped(ShapeData shape, ShapeData slot) {
    if (isProcessing) return;

    setState(() {
      isProcessing = true;
      if (shape.type == slot.type) {
        slot.isMatched = true;
        shapes.remove(shape);
        score += 15;
        feedback = 'Match! 🎉';
        if (shapes.isEmpty) {
          feedback = 'You Win! 🌟';
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                _initializeGame();
                score = 0;
                feedback = '';
                isProcessing = false;
              });
            }
          });
        } else {
          isProcessing = false;
        }
      } else {
        feedback = 'Try again! 😊';
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              feedback = '';
              isProcessing = false;
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
                  _buildSlotArea(),
                  const SizedBox(height: 16),
                  _buildShapeBank(),
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
                  colors: [Colors.greenAccent, Colors.tealAccent],
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
                  'Shape Shifter',
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
        color: Colors.greenAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        'Score: $score 🌟',
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20),
      ),
    );
  }

  // Shape slots
  Widget _buildSlotArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(slots.length, (index) {
        return ShapeSlot(
          shape: slots[index],
          index: index,
          onShapeDropped: onShapeDropped,
        );
      }),
    );
  }

  // Shape bank for draggable shapes
  Widget _buildShapeBank() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: List.generate(shapes.length, (index) {
        return ShapeTile(
          shape: shapes[index],
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

// Shape data model
enum ShapeType { circle, square, triangle, star }

class ShapeData {
  final ShapeType type;
  final Color color;
  final int id;
  bool isMatched;

  ShapeData({
    required this.type,
    required this.color,
    required this.id,
    this.isMatched = false,
  });
}

// Shape slot widget
class ShapeSlot extends StatefulWidget {
  final ShapeData shape;
  final int index;
  final Function(ShapeData, ShapeData) onShapeDropped;

  const ShapeSlot({
    super.key,
    required this.shape,
    required this.index,
    required this.onShapeDropped,
  });

  @override
  State<ShapeSlot> createState() => _ShapeSlotState();
}

class _ShapeSlotState extends State<ShapeSlot> with SingleTickerProviderStateMixin {
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
          child: DragTarget<ShapeData>(
            onAccept: (shape) => widget.onShapeDropped(shape, widget.shape),
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: widget.shape.isMatched
                      ? widget.shape.color.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.2),
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
                  child: _buildShapeIcon(widget.shape.type),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Shape icon renderer
  Widget _buildShapeIcon(ShapeType type) {
    switch (type) {
      case ShapeType.circle:
        return const Icon(Icons.circle, size: 40, color: Colors.white);
      case ShapeType.square:
        return const Icon(Icons.square, size: 40, color: Colors.white);
      case ShapeType.triangle:
        return const Icon(Icons.change_history, size: 40, color: Colors.white);
      case ShapeType.star:
        return const Icon(Icons.star, size: 40, color: Colors.white);
    }
  }
}

// Shape tile widget
class ShapeTile extends StatefulWidget {
  final ShapeData shape;
  final int index;

  const ShapeTile({super.key, required this.shape, required this.index});

  @override
  State<ShapeTile> createState() => _ShapeTileState();
}

class _ShapeTileState extends State<ShapeTile> with SingleTickerProviderStateMixin {
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
          child: Draggable<ShapeData>(
            data: widget.shape,
            feedback: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: widget.shape.color.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: _buildShapeIcon(widget.shape.type),
                ),
              ),
            ),
            childWhenDragging: const SizedBox.shrink(),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: widget.shape.color.withOpacity(0.3),
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
                child: _buildShapeIcon(widget.shape.type),
              ),
            ),
          ),
        );
      },
    );
  }

  // Shape icon renderer
  Widget _buildShapeIcon(ShapeType type) {
    switch (type) {
      case ShapeType.circle:
        return const Icon(Icons.circle, size: 40, color: Colors.white);
      case ShapeType.square:
        return const Icon(Icons.square, size: 40, color: Colors.white);
      case ShapeType.triangle:
        return const Icon(Icons.change_history, size: 40, color: Colors.white);
      case ShapeType.star:
        return const Icon(Icons.star, size: 40, color: Colors.white);
    }
  }
}