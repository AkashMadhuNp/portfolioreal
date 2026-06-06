import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scroll_provider.dart';

class CustomScrollbar extends StatefulWidget {
  const CustomScrollbar({super.key});

  @override
  State<CustomScrollbar> createState() => _CustomScrollbarState();
}

class _CustomScrollbarState extends State<CustomScrollbar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    // Animation controller for continuous physics simulation (Zzz, swaying, flames)
    _animController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context);
    
    // Fallback if scrollController isn't attached yet
    if (!scrollProvider.scrollController.hasClients) {
      return const SizedBox();
    }

    final scrollController = scrollProvider.scrollController;
    
    // Fallback if content dimensions are not calculated yet
    if (!scrollController.position.hasContentDimensions) {
      return const SizedBox();
    }

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollProvider.scrollOffset;
    
    // Scroll progress (0.0 to 1.0)
    final progress = maxScroll > 0 ? (currentScroll / maxScroll).clamp(0.0, 1.0) : 0.0;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Colors matching the luxury gold & yellow themes
    final primaryColor = isDark ? const Color(0xFFD4AF37) : const Color(0xFF000000); // Gold in dark, Black in light
    final accentColor = isDark ? const Color(0xFFFFD700) : const Color(0xFFFFD700); // Bright gold

    // Scrollbar state visibility: fade out when inactive, fade in on scroll/hover
    final isScrolling = scrollProvider.scrollState != ScrollDirectionState.idle;
    final double opacity = (_isHovered || isScrolling) ? 1.0 : 0.35;

    return Positioned(
      top: 100,
      bottom: 100,
      right: 12,
      width: 40,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 300),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final trackHeight = constraints.maxHeight;
              const thumbHeight = 70.0;
              final maxThumbY = trackHeight - thumbHeight;
              final thumbY = progress * maxThumbY;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // 1. Scroll Track (Removed to hide vertical path line)

                  // 2. Interactive Clickable Track (Invisible but wider for easy clicks)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTapDown: (details) {
                        final localY = details.localPosition.dy;
                        final relativeY = (localY - thumbHeight / 2).clamp(0.0, maxThumbY);
                        final newProgress = maxThumbY > 0 ? relativeY / maxThumbY : 0.0;
                        final targetOffset = newProgress * maxScroll;
                        scrollController.jumpTo(targetOffset);
                      },
                      onVerticalDragUpdate: (details) {
                        if (maxThumbY <= 0) return;
                        final deltaProgress = details.delta.dy / maxThumbY;
                        final newProgress = (progress + deltaProgress).clamp(0.0, 1.0);
                        final targetOffset = newProgress * maxScroll;
                        scrollController.jumpTo(targetOffset);
                      },
                    ),
                  ),

                  // 3. Animated Thumb Character
                  Positioned(
                    top: thumbY,
                    left: 0,
                    right: 0,
                    height: thumbHeight,
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        if (maxThumbY <= 0) return;
                        final deltaProgress = details.delta.dy / maxThumbY;
                        final newProgress = (progress + deltaProgress).clamp(0.0, 1.0);
                        final targetOffset = newProgress * maxScroll;
                        scrollController.jumpTo(targetOffset);
                      },
                      child: AnimatedBuilder(
                        animation: _animController,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: ScrollbarThumbPainter(
                              state: scrollProvider.scrollState,
                              animationValue: _animController.value,
                              primaryColor: primaryColor,
                              accentColor: accentColor,
                              theme: theme,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ScrollbarThumbPainter extends CustomPainter {
  final ScrollDirectionState state;
  final double animationValue;
  final Color primaryColor;
  final Color accentColor;
  final ThemeData theme;

  ScrollbarThumbPainter({
    required this.state,
    required this.animationValue,
    required this.primaryColor,
    required this.accentColor,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Subtle background capsule removed to show only the character icons

    if (state == ScrollDirectionState.scrollingDown) {
      // --- PARACHUTE CHARACTER ---
      // Sway angle back and forth using sine
      final swayAngle = math.sin(animationValue * 2 * math.pi * 2) * 0.15;
      
      canvas.save();
      // Rotate around the top suspension point
      canvas.translate(center.dx, 12);
      canvas.rotate(swayAngle);

      // Draw parachute canopy (semi-circle at top)
      final canopyPaint = Paint()
        ..color = accentColor
        ..style = PaintingStyle.fill;
      final canopyRect = Rect.fromCenter(center: Offset.zero, width: 28, height: 16);
      canvas.drawArc(canopyRect, math.pi, math.pi, true, canopyPaint);

      // Draw suspension lines
      final linePaint = Paint()
        ..color = primaryColor.withOpacity(0.4)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      const attachmentPoint = Offset(0, 16);
      canvas.drawLine(const Offset(-14, 0), attachmentPoint, linePaint);
      canvas.drawLine(const Offset(-7, 0), attachmentPoint, linePaint);
      canvas.drawLine(const Offset(7, 0), attachmentPoint, linePaint);
      canvas.drawLine(const Offset(14, 0), attachmentPoint, linePaint);

      // Draw the character hanging
      final personPaint = Paint()
        ..color = primaryColor
        ..style = PaintingStyle.fill;

      // Head
      canvas.drawCircle(attachmentPoint + const Offset(0, 3), 3.0, personPaint);
      
      // Body & Limbs
      final bodyPaint = Paint()
        ..color = primaryColor
        ..strokeWidth = 1.8
        ..style = PaintingStyle.stroke;
      // Spine
      canvas.drawLine(attachmentPoint + const Offset(0, 6), attachmentPoint + const Offset(0, 13), bodyPaint);
      // Arms grabbing strings
      canvas.drawLine(attachmentPoint + const Offset(0, 8), const Offset(-5, 5), bodyPaint);
      canvas.drawLine(attachmentPoint + const Offset(0, 8), const Offset(5, 5), bodyPaint);
      // Dangling legs
      canvas.drawLine(attachmentPoint + const Offset(0, 13), attachmentPoint + const Offset(-4, 19), bodyPaint);
      canvas.drawLine(attachmentPoint + const Offset(0, 13), attachmentPoint + const Offset(4, 19), bodyPaint);

      canvas.restore();
    } else if (state == ScrollDirectionState.scrollingUp) {
      // --- JET BOOSTER CHARACTER ---
      canvas.save();
      canvas.translate(center.dx, center.dy);

      // Pulse exhaust flames based on animation value
      final flameScale = 0.8 + math.sin(animationValue * 2 * math.pi * 4) * 0.2;
      final flameHeight = 18.0 * flameScale;

      final flamePaint = Paint()
        ..shader = LinearGradient(
          colors: [accentColor, Colors.orange, Colors.red.withOpacity(0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(-6, 8, 12, flameHeight))
        ..style = PaintingStyle.fill;

      // Flame Path
      final flamePath = Path()
        ..moveTo(-5, 8)
        ..quadraticBezierTo(0, 8 + flameHeight * 1.15, 0, 8 + flameHeight)
        ..quadraticBezierTo(0, 8 + flameHeight * 1.15, 5, 8)
        ..close();
      canvas.drawPath(flamePath, flamePaint);

      // Jetpack body
      final personPaint = Paint()
        ..color = primaryColor
        ..style = PaintingStyle.fill;
      
      final jetpackRect = Rect.fromCenter(center: const Offset(0, 0), width: 10, height: 16);
      canvas.drawRRect(RRect.fromRectAndRadius(jetpackRect, const Radius.circular(2)), personPaint);

      // Head
      canvas.drawCircle(const Offset(0, -11), 3.0, personPaint);

      // Thruster details
      final thrusterPaint = Paint()
        ..color = primaryColor.withOpacity(0.6)
        ..style = PaintingStyle.fill;
      canvas.drawRect(const Rect.fromLTWH(-4, 6, 3, 2), thrusterPaint);
      canvas.drawRect(const Rect.fromLTWH(1, 6, 3, 2), thrusterPaint);

      canvas.restore();
    } else {
      // --- IDLE / SNOOZING CHARACTER ---
      canvas.save();
      canvas.translate(center.dx, center.dy);

      final personPaint = Paint()
        ..color = primaryColor
        ..style = PaintingStyle.fill;

      // Sleeping head tilted slightly to the right
      canvas.drawCircle(const Offset(1, -2), 4.5, personPaint);
      
      // Closed sleepy eyes (arched down)
      final eyePaint = Paint()
        ..color = accentColor
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawArc(const Rect.fromLTWH(-1.5, -3.5, 1.8, 1.8), 0, math.pi, false, eyePaint);
      canvas.drawArc(const Rect.fromLTWH(1.5, -3.5, 1.8, 1.8), 0, math.pi, false, eyePaint);

      // Slumped shoulders/sleeping posture
      final bodyRect = Rect.fromCenter(center: const Offset(0, 6), width: 14, height: 8);
      canvas.drawRRect(RRect.fromRectAndRadius(bodyRect, const Radius.circular(3)), personPaint);

      canvas.restore();

      // Deterministic floating Z's drifting up
      final phases = [0.0, 0.33, 0.66];
      for (int i = 0; i < phases.length; i++) {
        final progress = (animationValue + phases[i]) % 1.0;
        
        // Float upwards above the head
        final y = -6.0 - progress * 32.0;
        // Wiggle horizontally
        final x = 4.0 + math.sin(progress * 2.5 * math.pi + i) * 5.0;
        // Fade in/out smoothly
        final opacity = math.sin(progress * math.pi) * (theme.brightness == Brightness.dark ? 0.75 : 0.9);
        // Size grows as it drifts up
        final zSize = 7.0 + progress * 5.0;

        final textPainter = TextPainter(
          text: TextSpan(
            text: i == 0 ? 'z' : (i == 1 ? 'z' : 'Z'),
            style: TextStyle(
              color: accentColor.withOpacity(opacity),
              fontSize: zSize,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          center + Offset(x - textPainter.width / 2, y - textPainter.height / 2),
        );
      }
    }
  }

  @override
  bool shouldRepaint(ScrollbarThumbPainter oldDelegate) {
    return oldDelegate.state != state ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.accentColor != accentColor;
  }
}
