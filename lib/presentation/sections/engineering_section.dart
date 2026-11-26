import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_palette.dart';
import '../../core/theme/app_tokens.dart';
import '../../data/models/engineering_model.dart';
import '../../domain/entities/engineering_highlight.dart';
import '../widgets/ui/app_card.dart';
import '../widgets/ui/app_grid.dart' show AppGrid, AppGridScope;
import '../widgets/ui/app_section.dart';
import '../widgets/ui/icon_keys.dart';
import '../widgets/ui/tech_tag.dart';

/// Engineering highlights: concrete capabilities, each attributed to where the
/// work was done. Content comes from [EngineeringModel].
class EngineeringSection extends StatelessWidget {
  const EngineeringSection({super.key});

  @override
  Widget build(BuildContext context) {
    final highlights = EngineeringModel.getHighlights();

    return AppSection(
      eyebrow: '03 · Engineering',
      title: 'Engineering highlights',
      subtitle:
          'Selected technical work from production applications: media pipelines, real-time systems and architecture.',
      child: AppGrid(
        children: [
          for (var i = 0; i < highlights.length; i++)
            FadeInUp(
              from: 16,
              delay: Duration(milliseconds: 60 * i),
              duration: const Duration(milliseconds: 500),
              child: _HighlightCard(highlight: highlights[i]),
            ),
        ],
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  const _HighlightCard({required this.highlight});

  final EngineeringHighlight highlight;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;

    // In the multi-column grid every card in a row is stretched to the same
    // height, so the tags and attribution are pinned to the bottom. In the
    // single-column layout the height is unbounded, so no spacer is used.
    final stretched = AppGridScope.stretchedOf(context);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTile(highlight.iconKey),
          const SizedBox(height: AppSpace.x2),
          Text(highlight.title, style: text.titleMedium),
          const SizedBox(height: AppSpace.x15),
          Text(highlight.description, style: text.bodyMedium),
          if (stretched) const Spacer(),
          const SizedBox(height: AppSpace.x2),
          TechTagWrap(highlight.tags),
          const SizedBox(height: AppSpace.x2),
          Divider(color: p.border, height: 1),
          const SizedBox(height: AppSpace.x15),
          Text(
            highlight.context,
            style: text.bodySmall?.copyWith(color: p.textTertiary),
          ),
        ],
      ),
    );
  }
}
