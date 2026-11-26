import 'package:flutter/material.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_tokens.dart';

/// Page section scaffold: consistent vertical rhythm, gutters, max width and an
/// editorial header (eyebrow, serif title, short lede). Every section uses it,
/// so spacing and heading style cannot drift.
class AppSection extends StatelessWidget {
  const AppSection({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.child,
    this.subtitle,
    this.alt = false,
  });

  /// Small label above the title, e.g. "01 · About".
  final String eyebrow;
  final String title;
  final String? subtitle;
  final Widget child;

  /// Paints the secondary background band (rhythm between sections).
  final bool alt;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final p = context.palette;
    final isMobile = width < Breakpoints.mobile;
    final isTablet = width < Breakpoints.tablet;

    return Container(
      width: double.infinity,
      color: alt ? p.surface : null,
      padding: EdgeInsets.symmetric(
        vertical: AppSpace.section(width),
        horizontal: AppSpace.gutter(width),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppLayout.maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                eyebrow: eyebrow,
                title: title,
                subtitle: subtitle,
                titleSize: isMobile ? 32 : (isTablet ? 38 : 44),
              ),
              SizedBox(height: isMobile ? AppSpace.x5 : AppSpace.x6),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.titleSize = 44,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;
  final double titleSize;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: AppSpace.x3, height: 2, color: p.goldStrong),
            const SizedBox(width: AppSpace.x15),
            Flexible(
              child: Text(
                eyebrow.toUpperCase(),
                style: AppType.eyebrow(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpace.x2),
        // Semantic heading so assistive tech (and Flutter's web semantics tree)
        // exposes the section structure.
        Semantics(
          header: true,
          child: Text(title, style: AppType.display(context, size: titleSize)),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpace.x2),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              subtitle!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ],
    );
  }
}
