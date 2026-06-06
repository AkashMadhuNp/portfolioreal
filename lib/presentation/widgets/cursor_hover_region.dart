import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cursor_provider.dart';

class CursorHoverRegion extends StatelessWidget {
  final Widget child;
  final CursorType type;
  final double scale;
  final String? customText;
  final IconData? customIcon;
  final MouseCursor cursor;

  const CursorHoverRegion({
    super.key,
    required this.child,
    this.type = CursorType.hover,
    this.scale = 1.8,
    this.customText,
    this.customIcon,
    this.cursor = SystemMouseCursors.click,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: cursor,
      onEnter: (event) {
        Provider.of<CursorProvider>(context, listen: false).setHoverState(
          type: type,
          scale: scale,
          customText: customText,
          customIcon: customIcon,
        );
      },
      onExit: (event) {
        Provider.of<CursorProvider>(context, listen: false).reset();
      },
      child: child,
    );
  }
}
