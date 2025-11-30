import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Luxury shimmer/glacier effect text widget
class ShimmerText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final List<Color>? shimmerColors;
  final Duration duration;

  const ShimmerText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.shimmerColors,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<ShimmerText> createState() => _ShimmerTextState();
}

class _ShimmerTextState extends State<ShimmerText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = widget.shimmerColors ?? (isDark
        ? const [
            Color(0xFFFFD700), // Bright gold (dark mode)
            Color(0xFFFFFFFF), // White shine
            Color(0xFFD4AF37), // Classic gold
            Color(0xFFFFF8DC), // Cornsilk shine
            Color(0xFFD4AF37), // Classic gold
          ]
        : const [
            Color(0xFF000000), // Black (light mode)
            Color(0xFFFFD700), // Yellow highlight
            Color(0xFF1A1A1A), // Near black
            Color(0xFFFFE066), // Light yellow
            Color(0xFF000000), // Black
          ]);
    
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
              stops: [
                0.0,
                math.max(0.0, _animation.value - 0.3),
                _animation.value,
                math.min(1.0, _animation.value + 0.3),
                1.0,
              ],
              transform: GradientRotation(_animation.value * math.pi / 4),
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: widget.style,
            textAlign: widget.textAlign,
          ),
        );
      },
    );
  }
}

/// Advanced glacier effect with multiple layers
class GlacierText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const GlacierText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
  });

  @override
  State<GlacierText> createState() => _GlacierTextState();
}

class _GlacierTextState extends State<GlacierText>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    
    // Shimmer animation
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();

    _shimmerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _shimmerController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = isDark
        ? const [
            Color(0xFFB8941E), // Dark gold (dark mode)
            Color(0xFFD4AF37), // Classic gold
            Color(0xFFFFFFFF), // White shine
            Color(0xFFFFD700), // Bright gold
            Color(0xFFFFFFFF), // White shine
            Color(0xFFD4AF37), // Classic gold
            Color(0xFFB8941E), // Dark gold
          ]
        : const [
            Color(0xFF000000), // Black (light mode)
            Color(0xFF2A2A2A), // Dark gray
            Color(0xFFFFD700), // Yellow shine
            Color(0xFF000000), // Black
            Color(0xFFFFE066), // Light yellow shine
            Color(0xFF2A2A2A), // Dark gray
            Color(0xFF000000), // Black
          ];
    
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            final double position = _shimmerAnimation.value * 3 - 1;
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
              stops: [
                _clamp(position - 0.6, 0.0, 1.0),
                _clamp(position - 0.4, 0.0, 1.0),
                _clamp(position - 0.2, 0.0, 1.0),
                _clamp(position, 0.0, 1.0),
                _clamp(position + 0.2, 0.0, 1.0),
                _clamp(position + 0.4, 0.0, 1.0),
                _clamp(position + 0.6, 0.0, 1.0),
              ],
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: widget.style,
            textAlign: widget.textAlign,
          ),
        );
      },
    );
  }

  double _clamp(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }
}


