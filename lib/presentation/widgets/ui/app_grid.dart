import 'package:flutter/material.dart';
import '../../../core/theme/app_tokens.dart';

/// Tells grid children whether their height is being stretched to match the
/// other cards in their row.
///
/// Cards use this (instead of a LayoutBuilder, which IntrinsicHeight cannot
/// measure) to decide whether to pin their footer to the bottom with a Spacer.
/// A Spacer is only valid when the height is bounded, i.e. when [stretched].
class AppGridScope extends InheritedWidget {
  const AppGridScope({
    super.key,
    required this.stretched,
    required super.child,
  });

  final bool stretched;

  static bool stretchedOf(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<AppGridScope>()
            ?.stretched ??
        false;
  }

  @override
  bool updateShouldNotify(AppGridScope oldWidget) =>
      stretched != oldWidget.stretched;
}

/// Responsive equal-height grid. Unlike a fixed-aspect-ratio GridView, each row
/// is as tall as its tallest card, so content is never clipped regardless of
/// text length or viewport width.
///
/// Children must not contain a LayoutBuilder (rows are measured with
/// IntrinsicHeight); read [AppGridScope.stretchedOf] instead.
class AppGrid extends StatelessWidget {
  const AppGrid({
    super.key,
    required this.children,
    this.mobile = 1,
    this.tablet = 2,
    this.desktop = 3,
    this.spacing = AppSpace.x3,
  });

  final List<Widget> children;
  final int mobile;
  final int tablet;
  final int desktop;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cols = width < Breakpoints.mobile
        ? mobile
        : (width < Breakpoints.tablet ? tablet : desktop);

    if (cols <= 1) {
      return AppGridScope(
        stretched: false,
        child: Column(
          children: [
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0) SizedBox(height: spacing),
              SizedBox(width: double.infinity, child: children[i]),
            ],
          ],
        ),
      );
    }

    final rows = <Widget>[];
    for (var start = 0; start < children.length; start += cols) {
      final slice = children.skip(start).take(cols).toList();
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < cols; i++) ...[
                if (i > 0) SizedBox(width: spacing),
                Expanded(
                  child: i < slice.length ? slice[i] : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return AppGridScope(
      stretched: true,
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) SizedBox(height: spacing),
            rows[i],
          ],
        ],
      ),
    );
  }
}
