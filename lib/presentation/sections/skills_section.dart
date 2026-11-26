import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_palette.dart';
import '../../core/theme/app_tokens.dart';
import '../../data/models/skill_model.dart';
import '../../domain/entities/skill.dart';
import '../widgets/ui/app_card.dart';
import '../widgets/ui/app_grid.dart';
import '../widgets/ui/app_section.dart';
import '../widgets/ui/icon_keys.dart';

/// Skills as six categorized cards (replaces the old scrolling marquee).
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = SkillModel.getCategories();

    return AppSection(
      alt: true,
      eyebrow: '02 · Skills',
      title: 'Skills & tools',
      subtitle: 'The technologies I work with, grouped by discipline.',
      child: AppGrid(
        children: [
          for (var i = 0; i < categories.length; i++)
            FadeInUp(
              from: 16,
              delay: Duration(milliseconds: 60 * i),
              duration: const Duration(milliseconds: 500),
              child: _SkillCard(category: categories[i]),
            ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  const _SkillCard({required this.category});

  final SkillCategory category;

  int get half => (category.items.length / 2).ceil();

  Widget _itemColumn(Iterable<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpace.x15),
            child: _SkillItem(item),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTile(category.iconKey),
          const SizedBox(height: AppSpace.x2),
          Text(category.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpace.x2),
          // Two even columns (first half / second half). Built from plain
          // Rows and Columns so the grid can measure the card's height.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _itemColumn(category.items.take(half))),
              const SizedBox(width: AppSpace.x2),
              Expanded(child: _itemColumn(category.items.skip(half))),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkillItem extends StatelessWidget {
  const _SkillItem(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: p.goldStrong,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: AppSpace.x15),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: p.textPrimary,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}
