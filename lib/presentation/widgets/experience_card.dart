import 'package:flutter/material.dart';
import '../../core/theme/app_palette.dart';
import '../../core/theme/app_tokens.dart';
import '../../domain/entities/experience.dart';
import 'ui/app_button.dart';
import 'ui/app_card.dart';
import 'ui/open_link.dart';

/// One role on the timeline: a spine with a marker, and a card holding the
/// concise highlights. The full responsibility list expands on demand.
class ExperienceEntry extends StatefulWidget {
  const ExperienceEntry({
    super.key,
    required this.experience,
    required this.isLast,
  });

  final Experience experience;
  final bool isLast;

  @override
  State<ExperienceEntry> createState() => _ExperienceEntryState();
}

class _ExperienceEntryState extends State<ExperienceEntry> {
  bool _expanded = false;

  Experience get e => widget.experience;

  List<String> get _highlights =>
      e.highlights.isNotEmpty ? e.highlights : e.responsibilities;

  /// Detail list only makes sense when it adds something beyond the highlights.
  bool get _hasMoreDetail =>
      e.highlights.isNotEmpty && e.responsibilities.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final narrow = MediaQuery.of(context).size.width < Breakpoints.mobile;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline spine + marker.
          SizedBox(
            width: narrow ? 20 : 32,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if (!widget.isLast)
                  Positioned(
                    top: 28,
                    bottom: 0,
                    child: Container(width: 1, color: p.border),
                  ),
                Positioned(
                  top: 22,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      color: e.isCurrent ? p.gold : p.card,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: e.isCurrent ? p.goldStrong : p.borderStrong,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: widget.isLast ? 0 : AppSpace.x3),
              child: AppCard(
                padding: EdgeInsets.all(narrow ? AppSpace.x2 : AppSpace.x3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(context, p),
                    const SizedBox(height: AppSpace.x2),
                    for (final item in _highlights) _bullet(context, p, item),
                    if (_hasMoreDetail) ...[
                      const SizedBox(height: AppSpace.x05),
                      AnimatedSize(
                        duration: AppLayout.fast,
                        curve: AppLayout.curve,
                        alignment: Alignment.topCenter,
                        child: _expanded
                            ? _details(context, p)
                            : const SizedBox(width: double.infinity),
                      ),
                    ],
                    if (_hasMoreDetail || e.certificateUrl != null) ...[
                      const SizedBox(height: AppSpace.x1),
                      Wrap(
                        spacing: AppSpace.x15,
                        runSpacing: AppSpace.x1,
                        children: [
                          if (_hasMoreDetail)
                            AppButton(
                              label: _expanded
                                  ? 'Hide full details'
                                  : 'Show full details',
                              icon: _expanded
                                  ? Icons.expand_less_rounded
                                  : Icons.expand_more_rounded,
                              variant: AppButtonVariant.ghost,
                              compact: true,
                              onPressed: () =>
                                  setState(() => _expanded = !_expanded),
                            ),
                          if (e.certificateUrl != null)
                            AppButton(
                              label: 'View certificate',
                              icon: Icons.verified_outlined,
                              variant: AppButtonVariant.ghost,
                              compact: true,
                              onPressed: () =>
                                  openLink(context, e.certificateUrl!),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, AppPalette p) {
    final text = Theme.of(context).textTheme;
    final narrow = MediaQuery.of(context).size.width < Breakpoints.mobile;

    final title = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(e.position, style: text.titleLarge),
        const SizedBox(height: AppSpace.x05),
        Text(
          e.company,
          style: text.bodyMedium?.copyWith(
            color: p.accent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    final meta = Column(
      crossAxisAlignment: narrow
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(
          e.duration,
          style: text.bodySmall?.copyWith(
            color: p.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpace.x05),
        Text(
          e.isCurrent ? '${e.location} · Current role' : e.location,
          style: text.bodySmall?.copyWith(color: p.textTertiary),
        ),
      ],
    );

    final logo = _Logo(e.logoUrl, e.company);

    if (narrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              logo,
              const SizedBox(width: AppSpace.x15),
              Expanded(child: title),
            ],
          ),
          const SizedBox(height: AppSpace.x15),
          meta,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        logo,
        const SizedBox(width: AppSpace.x2),
        Expanded(child: title),
        const SizedBox(width: AppSpace.x2),
        meta,
      ],
    );
  }

  Widget _bullet(BuildContext context, AppPalette p, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.x15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 9),
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
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _details(BuildContext context, AppPalette p) {
    final text = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: AppSpace.x1, bottom: AppSpace.x1),
      padding: const EdgeInsets.all(AppSpace.x2),
      decoration: BoxDecoration(color: p.subtle, borderRadius: AppRadius.mdAll),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Full responsibilities',
            style: text.labelLarge?.copyWith(color: p.textPrimary),
          ),
          const SizedBox(height: AppSpace.x15),
          for (final r in e.responsibilities)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpace.x1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      width: 3,
                      height: 3,
                      decoration: BoxDecoration(
                        color: p.textTertiary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpace.x15),
                  Expanded(child: Text(r, style: text.bodySmall)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo(this.asset, this.company);

  final String? asset;
  final String company;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        // Company logos are designed on white; keep them on white in both themes.
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: p.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: asset == null
          ? Icon(Icons.work_outline_rounded, size: 20, color: p.textTertiary)
          : Image.asset(
              asset!,
              fit: BoxFit.cover,
              semanticLabel: '$company logo',
              errorBuilder: (_, _, _) => Icon(
                Icons.work_outline_rounded,
                size: 20,
                color: p.textTertiary,
              ),
            ),
    );
  }
}
