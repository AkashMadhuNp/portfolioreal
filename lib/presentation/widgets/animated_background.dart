import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: BackgroundPainter(_controller.value),
              child: Container(),
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    // Create multiple animated circles
    final circles = [
      _Circle(
        color: Colors.purple.withOpacity(0.1),
        radius: 200,
        offset: Offset(
          size.width * 0.2 + math.sin(animationValue * 2 * math.pi) * 50,
          size.height * 0.3 + math.cos(animationValue * 2 * math.pi) * 50,
        ),
      ),
      _Circle(
        color: Colors.blue.withOpacity(0.1),
        radius: 150,
        offset: Offset(
          size.width * 0.8 + math.cos(animationValue * 2 * math.pi) * 70,
          size.height * 0.2 + math.sin(animationValue * 2 * math.pi) * 70,
        ),
      ),
      _Circle(
        color: Colors.pink.withOpacity(0.1),
        radius: 180,
        offset: Offset(
          size.width * 0.6 + math.sin(animationValue * 2 * math.pi + 1) * 60,
          size.height * 0.7 + math.cos(animationValue * 2 * math.pi + 1) * 60,
        ),
      ),
    ];

    for (final circle in circles) {
      paint.color = circle.color;
      canvas.drawCircle(circle.offset, circle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class _Circle {
  final Color color;
  final double radius;
  final Offset offset;

  _Circle({
    required this.color,
    required this.radius,
    required this.offset,
  });
}

