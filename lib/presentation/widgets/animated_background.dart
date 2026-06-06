import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scroll_provider.dart';

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
      duration: const Duration(seconds: 25),
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
    final scrollProvider = Provider.of<ScrollProvider>(context);
    final scrollOffset = scrollProvider.scrollOffset;

    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: BackgroundPainter(
                animationValue: _controller.value,
                scrollOffset: scrollOffset,
                theme: Theme.of(context),
              ),
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
  final double scrollOffset;
  final ThemeData theme;

  BackgroundPainter({
    required this.animationValue,
    required this.scrollOffset,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final isDark = theme.brightness == Brightness.dark;
    
    // Luxury theme backgrounds: deep black sky for dark mode, soft yellow sky for light mode
    final skyColor = isDark ? const Color(0xFF000000) : const Color(0xFFFFFBF0);
    final canvasPaint = Paint()..color = skyColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), canvasPaint);

    // Dynamic colors
    final accentColor = isDark ? const Color(0xFFFFD700) : const Color(0xFFD4AF37); // Golden yellow
    final starColor = isDark ? const Color(0xFFFFE066) : const Color(0xFFFFD700);

    // Apply Parallax Translation to page-based cosmic elements
    canvas.save();
    canvas.translate(0, -scrollOffset * 0.35); // background scrolls at 35% speed (parallax)

    // 1. Draw Twinkling Starfield
    final numStars = 140;
    for (int i = 0; i < numStars; i++) {
      // Deterministic pseudo-random generation based on index
      final rx = (math.sin(i * 742.3) * 0.5 + 0.5) * size.width;
      final ry = (math.sin(i * 193.8) * 0.5 + 0.5) * 4400.0; // Cover total scroll length
      
      final twinkle = (0.25 + 0.75 * math.sin(animationValue * 2 * math.pi * 1.5 + i)).clamp(0.0, 1.0);
      final starSize = 0.6 + (math.sin(i * 482.1) * 0.5 + 0.5) * 1.4;
      
      final starPaint = Paint()
        ..color = starColor.withOpacity((twinkle * (isDark ? 0.35 : 0.25)).clamp(0.0, 1.0))
        ..style = PaintingStyle.fill;
        
      canvas.drawCircle(Offset(rx, ry), starSize, starPaint);
    }

    // 2. Draw Winding golden Constellation Pathway
    _drawPathway(canvas, size, accentColor);

    // 3. Draw Swirling Spiral Galaxies
    // Galaxy 1: Top-Right (Hero Section)
    _drawGalaxy(canvas, Offset(size.width * 0.82, 320), accentColor);
    
    // Galaxy 2: Middle-Left (Skills/About Section)
    _drawGalaxy(canvas, Offset(size.width * 0.16, 1500), accentColor);
    
    // Galaxy 3: Middle-Right (Projects Section)
    _drawGalaxy(canvas, Offset(size.width * 0.84, 2700), accentColor);

    // Galaxy 4: Bottom-Left (Contact Section)
    _drawGalaxy(canvas, Offset(size.width * 0.18, 3800), accentColor);

    // 4. Draw Glowing Constellation Nodes on the path
    final nodeDepths = [280.0, 1100.0, 1950.0, 2750.0, 3500.0, 4100.0];
    for (final depth in nodeDepths) {
      final nodePos = _getPathCoordinate(depth, size.width);
      _drawConstellationNode(canvas, nodePos, accentColor);
    }

    canvas.restore();
  }

  Offset _getPathCoordinate(double y, double width) {
    // Math wave function to generate winding curve
    final x = width * 0.5 + 
              math.sin(y * 0.0016) * width * 0.24 + 
              math.cos(y * 0.0006 + animationValue * 2 * math.pi * 0.04) * width * 0.06;
    return Offset(x, y);
  }

  void _drawPathway(Canvas canvas, Size size, Color color) {
    final path = Path();
    final glowPath = Path();
    bool first = true;
    
    const double totalHeight = 4400.0;
    for (double y = 0; y < totalHeight; y += 20) {
      final pos = _getPathCoordinate(y, size.width);
      if (first) {
        path.moveTo(pos.dx, pos.dy);
        glowPath.moveTo(pos.dx, pos.dy);
        first = false;
      } else {
        path.lineTo(pos.dx, pos.dy);
        glowPath.lineTo(pos.dx, pos.dy);
      }
    }

    // Outer soft pathway glow
    final glowPaint = Paint()
      ..color = color.withOpacity(theme.brightness == Brightness.dark ? 0.05 : 0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawPath(glowPath, glowPaint);

    // Inner glowing core line
    final corePaint = Paint()
      ..color = color.withOpacity(theme.brightness == Brightness.dark ? 0.25 : 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, corePaint);
  }

  void _drawGalaxy(Canvas canvas, Offset center, Color color) {
    // 1. Core Glow (deep cosmic light source)
    final corePaint = Paint()
      ..color = color.withOpacity(theme.brightness == Brightness.dark ? 0.06 : 0.03)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    canvas.drawCircle(center, 55, corePaint);
    
    final corePaint2 = Paint()
      ..color = color.withOpacity(theme.brightness == Brightness.dark ? 0.18 : 0.12)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
    canvas.drawCircle(center, 16, corePaint2);

    // 2. Swirling spiral arms (Archimedean spiral math with custom speeds)
    const numParticles = 80;
    for (int i = 0; i < numParticles; i++) {
      final arm = i % 2; // 2 spiral arms
      final theta = (i * 0.12) + (arm * math.pi);
      final r = 10.0 + i * 2.0;

      // Closer particles spin faster (creates fluid shear effect)
      final speedCoeff = 1.0 + (160 - r) / 100.0;
      final rotation = animationValue * 2 * math.pi * speedCoeff * 0.035;

      final x = center.dx + math.cos(theta + rotation) * r;
      final y = center.dy + math.sin(theta + rotation) * r;

      final size = 0.8 + (i % 3) * 0.6;
      final twinkle = (0.4 + 0.6 * math.sin(animationValue * 2 * math.pi * 2 + i)).clamp(0.0, 1.0);

      // Fade particles out towards edge of galaxy
      final fade = (1.0 - r / 160.0).clamp(0.0, 1.0);
      final opacity = (twinkle * fade * (theme.brightness == Brightness.dark ? 0.55 : 0.4)).clamp(0.0, 1.0);

      final particlePaint = Paint()
        ..color = color.withOpacity(opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), size, particlePaint);
    }
  }

  void _drawConstellationNode(Canvas canvas, Offset pos, Color color) {
    final starPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
      
    final glowPaint = Paint()
      ..color = color.withOpacity(theme.brightness == Brightness.dark ? 0.3 : 0.2)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      
    // Soft blur core
    canvas.drawCircle(pos, 8, glowPaint);
    
    // Core center star
    canvas.drawCircle(pos, 2.5, starPaint);
    
    // Compass constellation ticks
    final linePaint = Paint()
      ..color = color.withOpacity(theme.brightness == Brightness.dark ? 0.65 : 0.45)
      ..strokeWidth = 1.0;
    
    final armLength = 8.0 + math.sin(animationValue * 2 * math.pi * 1.5) * 2.0;
    canvas.drawLine(pos - Offset(armLength, 0), pos + Offset(armLength, 0), linePaint);
    canvas.drawLine(pos - Offset(0, armLength), pos + Offset(0, armLength), linePaint);
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.scrollOffset != scrollOffset ||
        oldDelegate.theme.brightness != theme.brightness;
  }
}
