import 'package:flutter/material.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/theme/app_tokens.dart';

/// Small neutral label for a technology. Deliberately quiet (no border, no
/// gold) so tags support content instead of competing with it.
class TechTag extends StatelessWidget {
  const TechTag(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.x15 - 2,
        vertical: AppSpace.x05,
      ),
      decoration: BoxDecoration(
        color: p.subtle,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: p.textSecondary,
          fontWeight: FontWeight.w500,
          height: 1.4,
        ),
      ),
    );
  }
}

/// A wrapped row of [TechTag]s.
class TechTagWrap extends StatelessWidget {
  const TechTagWrap(this.tags, {super.key, this.max});

  final List<String> tags;

  /// Optionally cap how many tags are shown.
  final int? max;

  @override
  Widget build(BuildContext context) {
    final shown = max == null ? tags : tags.take(max!).toList();
    return Wrap(
      spacing: AppSpace.x1,
      runSpacing: AppSpace.x1,
      children: [for (final t in shown) TechTag(t)],
    );
  }
}
