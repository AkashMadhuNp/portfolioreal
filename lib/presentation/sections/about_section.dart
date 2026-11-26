import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_palette.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_tokens.dart';
import '../../data/models/about_stats_model.dart';
import '../widgets/ui/app_card.dart';
import '../widgets/ui/app_grid.dart';
import '../widgets/ui/app_section.dart';

/// About: a short introduction and career journey beside four headline
/// figures, with a quiet "at a glance" card under the text.
///
/// The figures describe the professional journey, not repository activity; see
/// [AboutStatsModel] for where each one comes from.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 900;

    return AppSection(
      eyebrow: '01 · About',
      title: 'About me',
      child: wide
          // Both columns share one height: the statistics grid stretches to the
          // bottom of the text column so their edges line up.
          ? const IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 6, child: _AboutCopy()),
                  SizedBox(width: AppSpace.x8),
                  Expanded(flex: 5, child: _AboutStats(stretch: true)),
                ],
              ),
            )
          : const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AboutCopy(),
                SizedBox(height: AppSpace.x5),
                _AboutStats(stretch: false),
              ],
            ),
    );
  }
}

class _AboutCopy extends StatelessWidget {
  const _AboutCopy();

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    final paragraphStyle = text.bodyLarge?.copyWith(
      color: p.textSecondary,
      height: 1.8,
    );

    return FadeInUp(
      from: 16,
      duration: const Duration(milliseconds: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // A comfortable reading measure even when the column is wide.
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (
                  var i = 0;
                  i < AppConstants.aboutParagraphs.length;
                  i++
                ) ...[
                  if (i > 0) const SizedBox(height: AppSpace.x3),
                  Text(AppConstants.aboutParagraphs[i], style: paragraphStyle),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpace.x4),
          AppCard(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.x3,
              vertical: AppSpace.x1,
            ),
            child: Column(
              // Stretch so short rows ("Based in: India") align left like the
              // long ones instead of being centred around their own width.
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Fact(
                  'Current role',
                  'Flutter Developer · ${AppConstants.company}',
                ),
                Divider(color: p.border, height: 1),
                const _Fact('Based in', AppConstants.location),
                Divider(color: p.border, height: 1),
                const _Fact(
                  'Core stack',
                  'Flutter · Dart · BLoC · Provider · Clean Architecture',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// One labelled row of the "at a glance" card.
class _Fact extends StatelessWidget {
  const _Fact(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    // Decided from the viewport, not a LayoutBuilder: this card sits inside an
    // IntrinsicHeight row, which cannot measure a LayoutBuilder.
    final stacked = MediaQuery.of(context).size.width < Breakpoints.mobile;

    final labelWidget = SizedBox(
      width: 112,
      child: Text(
        label,
        // Secondary (not tertiary) text keeps these labels comfortably legible.
        style: text.bodySmall?.copyWith(
          color: p.textSecondary,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
      ),
    );
    final valueWidget = Text(
      value,
      style: text.bodyMedium?.copyWith(
        color: p.textPrimary,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.x2),
      child: stacked
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelWidget,
                const SizedBox(height: AppSpace.x05),
                valueWidget,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelWidget,
                Expanded(child: valueWidget),
              ],
            ),
    );
  }
}

/// The 2×2 statistics grid.
///
/// [stretch] fills the height it is given (side-by-side layout, where it must
/// match the text column); otherwise cards take their natural height, equalised
/// per row.
class _AboutStats extends StatelessWidget {
  const _AboutStats({required this.stretch});

  final bool stretch;

  @override
  Widget build(BuildContext context) {
    final stats = AboutStatsModel.getStats();
    const gap = AppSpace.x2;

    Widget row(int a, int b) => Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: _Stat(stats[a])),
        const SizedBox(width: gap),
        Expanded(child: _Stat(stats[b])),
      ],
    );

    return FadeInUp(
      from: 16,
      delay: const Duration(milliseconds: 120),
      duration: const Duration(milliseconds: 600),
      child: stretch
          ? Column(
              children: [
                Expanded(child: row(0, 1)),
                const SizedBox(height: gap),
                Expanded(child: row(2, 3)),
              ],
            )
          : AppGrid(
              mobile: 2,
              tablet: 2,
              desktop: 2,
              spacing: gap,
              children: [for (final s in stats) _Stat(s)],
            ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.stat);

  final AboutStat stat;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final small = MediaQuery.of(context).size.width < Breakpoints.mobile;

    return Semantics(
      container: true,
      label: '${stat.value}. ${stat.label}',
      excludeSemantics: true,
      child: AppCard(
        // Same internal padding on every card; it steps down once, on phones.
        padding: EdgeInsets.all(small ? AppSpace.x2 : AppSpace.x3),
        hoverable: true,
        // A faint gold on hover: present, but not a highlight.
        hoverBorderColor: p.goldStrong.withValues(alpha: 0.35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Large display text may use the primary gold (≥ 3:1 is enough).
            // Scales down rather than wrapping, so a word such as "Production"
            // fits any card width while numbers keep their full size.
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                stat.value,
                maxLines: 1,
                softWrap: false,
                style: AppType.display(
                  context,
                  size: small ? 36 : 48,
                  color: p.goldStrong,
                  letterSpacing: -1,
                  fontFeatures: AppType.liningFigures,
                ),
              ),
            ),
            const SizedBox(height: AppSpace.x2),
            Text(
              stat.label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: p.textSecondary,
                fontWeight: FontWeight.w500,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
