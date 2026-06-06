import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../providers/cursor_provider.dart';

class CustomCursor extends StatefulWidget {
  final Widget child;

  const CustomCursor({
    super.key,
    required this.child,
  });

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> with SingleTickerProviderStateMixin {
  final ValueNotifier<Offset> _targetPosition = ValueNotifier<Offset>(Offset.zero);
  final ValueNotifier<bool> _visible = ValueNotifier<bool>(false);
  bool _isMousePointer = false;

  @override
  void dispose() {
    _targetPosition.dispose();
    _visible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      cursor: _isMousePointer ? SystemMouseCursors.none : MouseCursor.defer,
      onHover: (event) {
        if (event.kind == PointerDeviceKind.mouse) {
          if (!_isMousePointer) {
            setState(() {
              _isMousePointer = true;
            });
          }
          _targetPosition.value = event.position;
          _visible.value = true;
        }
      },
      onExit: (event) {
        _visible.value = false;
      },
      child: Stack(
        children: [
          widget.child,
          if (_isMousePointer)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomCursorPainterWidget(
                  targetPosition: _targetPosition,
                  visible: _visible,
                  tickerProvider: this,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CustomCursorPainterWidget extends StatefulWidget {
  final ValueNotifier<Offset> targetPosition;
  final ValueNotifier<bool> visible;
  final TickerProvider tickerProvider;

  const CustomCursorPainterWidget({
    super.key,
    required this.targetPosition,
    required this.visible,
    required this.tickerProvider,
  });

  @override
  State<CustomCursorPainterWidget> createState() => _CustomCursorPainterWidgetState();
}

class _CustomCursorPainterWidgetState extends State<CustomCursorPainterWidget> {
  Offset _trailingPosition = Offset.zero;
  double _hoverProgress = 0.0;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _trailingPosition = widget.targetPosition.value;
    _ticker = widget.tickerProvider.createTicker((elapsed) {
      final target = widget.targetPosition.value;
      final distance = (target - _trailingPosition).distance;

      // Check if cursor provider state has changed
      final cursorProvider = Provider.of<CursorProvider>(context, listen: false);
      final targetHoverProgress = cursorProvider.type == CursorType.normal ? 0.0 : 1.0;

      // Smoothly update hover progress
      double nextHoverProgress = _hoverProgress;
      if ((_hoverProgress - targetHoverProgress).abs() > 0.01) {
        nextHoverProgress = _hoverProgress + (targetHoverProgress - _hoverProgress) * 0.15;
      } else {
        nextHoverProgress = targetHoverProgress;
      }

      if (distance > 0.1 || _hoverProgress != nextHoverProgress) {
        setState(() {
          _trailingPosition = Offset.lerp(_trailingPosition, target, 0.15)!;
          _hoverProgress = nextHoverProgress;
        });
      }
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cursorProvider = Provider.of<CursorProvider>(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // luxury theme adaptations
    final primaryColor = isDark ? const Color(0xFFD4AF37) : const Color(0xFF000000); // Gold in dark, Black in light
    final accentColor = isDark ? const Color(0xFFFFD700) : const Color(0xFFFFD700); // Bright gold/yellow

    return ValueListenableBuilder<bool>(
      valueListenable: widget.visible,
      builder: (context, visible, child) {
        if (!visible) return const SizedBox();

        return CustomPaint(
          painter: CursorPainter(
            targetPosition: widget.targetPosition.value,
            trailingPosition: _trailingPosition,
            hoverProgress: _hoverProgress,
            type: cursorProvider.type,
            scale: cursorProvider.scale,
            customText: cursorProvider.customText,
            customIcon: cursorProvider.customIcon,
            primaryColor: primaryColor,
            accentColor: accentColor,
          ),
        );
      },
    );
  }
}

class CursorPainter extends CustomPainter {
  final Offset targetPosition;
  final Offset trailingPosition;
  final double hoverProgress;
  final CursorType type;
  final double scale;
  final String? customText;
  final IconData? customIcon;
  final Color primaryColor;
  final Color accentColor;

  CursorPainter({
    required this.targetPosition,
    required this.trailingPosition,
    required this.hoverProgress,
    required this.type,
    required this.scale,
    this.customText,
    this.customIcon,
    required this.primaryColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw Outer Ring
    final baseOuterRadius = 14.0;
    final targetScale = 1.0 + (scale - 1.0) * hoverProgress;
    final outerRadius = baseOuterRadius * targetScale;

    final outerPaint = Paint()
      ..color = accentColor.withOpacity(0.3 + 0.4 * hoverProgress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5 + 0.5 * hoverProgress;

    final fillPaint = Paint()
      ..color = accentColor.withOpacity(0.04 + 0.08 * hoverProgress)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(trailingPosition, outerRadius, fillPaint);
    canvas.drawCircle(trailingPosition, outerRadius, outerPaint);

    // Decorative rotating accent dots on outer ring when hovered
    if (hoverProgress > 0.1) {
      const numTicks = 4;
      for (int i = 0; i < numTicks; i++) {
        final angle = (i * 2 * math.pi / numTicks) + (hoverProgress * math.pi / 2);
        final tickOffset = trailingPosition + Offset(math.cos(angle), math.sin(angle)) * outerRadius;
        canvas.drawCircle(
          tickOffset,
          2.0 * hoverProgress,
          Paint()..color = accentColor.withOpacity(0.8 * hoverProgress),
        );
      }
    }

    // 2. Draw Inner Tracking Dot
    final showOverlay = (customText != null || customIcon != null) && hoverProgress > 0.5;

    if (!showOverlay) {
      if (type == CursorType.text) {
        const lineLength = 12.0;
        canvas.drawLine(
          targetPosition - const Offset(0, lineLength / 2),
          targetPosition + const Offset(0, lineLength / 2),
          Paint()
            ..color = primaryColor
            ..strokeWidth = 2.0,
        );
      } else {
        final innerRadius = 3.0 * (1.0 - 0.4 * hoverProgress);
        final innerPaint = Paint()
          ..color = primaryColor.withOpacity(1.0 - 0.6 * hoverProgress)
          ..style = PaintingStyle.fill;
        canvas.drawCircle(targetPosition, innerRadius, innerPaint);
      }
    }

    // 3. Draw Text Overlay
    if (customText != null && hoverProgress > 0.3) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: customText,
          style: TextStyle(
            color: primaryColor.withOpacity(hoverProgress),
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontFamily: 'Poppins',
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        trailingPosition - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }

    // 4. Draw Icon Overlay
    if (customIcon != null && hoverProgress > 0.3) {
      final iconPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(customIcon!.codePoint),
          style: TextStyle(
            color: primaryColor.withOpacity(hoverProgress),
            fontSize: 14.0,
            fontFamily: customIcon!.fontFamily,
            package: customIcon!.fontPackage,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      iconPainter.layout();
      iconPainter.paint(
        canvas,
        trailingPosition - Offset(iconPainter.width / 2, iconPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(CursorPainter oldDelegate) {
    return oldDelegate.targetPosition != targetPosition ||
        oldDelegate.trailingPosition != trailingPosition ||
        oldDelegate.hoverProgress != hoverProgress ||
        oldDelegate.type != type ||
        oldDelegate.scale != scale ||
        oldDelegate.customText != customText ||
        oldDelegate.customIcon != customIcon ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.accentColor != accentColor;
  }
}
