import 'package:flutter/material.dart';
import '../../core/theme/app_palette.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_tokens.dart';
import '../../data/models/case_study_model.dart';
import '../../domain/entities/project.dart';
import '../screens/project_detail_screen.dart';
import 'ui/app_button.dart';
import 'ui/app_card.dart';
import 'ui/app_grid.dart' show AppGridScope;
import 'ui/open_link.dart';
import 'ui/tech_tag.dart';

void openCaseStudy(BuildContext context, Project project) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => ProjectDetailScreen(project: project)),
  );
}

/// Standard project card: thumbnail, category, title, summary, 4–6 tags and
/// links. Rows of these stretch to equal height, so nothing is ever clipped.
class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    // Cards in a row are stretched to equal height; pin the actions to the
    // bottom there. In the single-column layout the height is unbounded.
    final stretched = AppGridScope.stretchedOf(context);

    final body = Padding(
      padding: const EdgeInsets.all(AppSpace.x3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectMeta(project: project),
          const SizedBox(height: AppSpace.x1),
          Text(project.title, style: text.titleLarge),
          const SizedBox(height: AppSpace.x15),
          Text(project.summary, style: text.bodyMedium),
          const SizedBox(height: AppSpace.x2),
          TechTagWrap(project.highlightTags, max: 6),
          if (stretched)
            const Spacer()
          else
            const SizedBox(height: AppSpace.x3),
          const SizedBox(height: AppSpace.x2),
          ProjectActions(project: project),
        ],
      ),
    );

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectThumbnail(project: project, height: 176),
          if (stretched) Expanded(child: body) else body,
        ],
      ),
    );
  }
}

/// Large lead card for the flagship project (Spotlight).
class FeaturedProjectCard extends StatelessWidget {
  const FeaturedProjectCard({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    final wide = MediaQuery.of(context).size.width >= 900;
    final study = CaseStudyModel.forProject(project.id);

    final content = Padding(
      padding: EdgeInsets.all(wide ? AppSpace.x5 : AppSpace.x3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: AppSpace.x3, height: 2, color: p.goldStrong),
              const SizedBox(width: AppSpace.x15),
              Flexible(
                child: Text(
                  'FLAGSHIP PROJECT',
                  style: AppType.eyebrow(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpace.x2),
          Text(
            project.title,
            style: AppType.display(context, size: wide ? 40 : 32),
          ),
          const SizedBox(height: AppSpace.x1),
          ProjectMeta(project: project),
          const SizedBox(height: AppSpace.x2),
          Text(project.summary, style: text.bodyLarge),
          if (study != null && study.contribution.isNotEmpty) ...[
            const SizedBox(height: AppSpace.x3),
            Text(
              'What I built',
              style: text.labelLarge?.copyWith(color: p.textPrimary),
            ),
            const SizedBox(height: AppSpace.x15),
            for (final item in study.contribution.take(3))
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpace.x1),
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
                    Expanded(child: Text(item, style: text.bodyMedium)),
                  ],
                ),
              ),
          ],
          const SizedBox(height: AppSpace.x2),
          TechTagWrap(project.highlightTags, max: 6),
          const SizedBox(height: AppSpace.x3),
          ProjectActions(project: project, primary: true),
        ],
      ),
    );

    return AppCard(
      featured: true,
      padding: EdgeInsets.zero,
      child: wide
          ? IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 5,
                    child: ProjectThumbnail(
                      project: project,
                      fill: true,
                      rounded: const BorderRadius.horizontal(
                        left: Radius.circular(AppRadius.lg),
                      ),
                    ),
                  ),
                  Expanded(flex: 6, child: content),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProjectThumbnail(
                  project: project,
                  height: 200,
                  rounded: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.lg),
                  ),
                ),
                content,
              ],
            ),
    );
  }
}

/// "AI PLATFORM · COMPANY PROJECT" style label.
class ProjectMeta extends StatelessWidget {
  const ProjectMeta({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Text(
      '${project.category} · ${project.isCompanyProject ? 'Company project' : 'Personal project'}',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: p.textTertiary,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
    );
  }
}

/// Project thumbnail. Uses the real asset when one exists; otherwise a quiet
/// neutral placeholder. It never invents a screenshot.
class ProjectThumbnail extends StatelessWidget {
  const ProjectThumbnail({
    super.key,
    required this.project,
    this.height,
    this.fill = false,
    this.rounded = const BorderRadius.vertical(
      top: Radius.circular(AppRadius.lg),
    ),
  });

  final Project project;
  final double? height;

  /// Expand to the parent's height (side-by-side layouts).
  final bool fill;
  final BorderRadius rounded;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final image = project.imageUrl;

    final inner = image != null
        ? Padding(
            padding: const EdgeInsets.all(AppSpace.x4),
            child: Center(
              // The logos are designed on white, so they sit on a white tile in
              // both themes rather than being recoloured.
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 360,
                  maxHeight: 160,
                ),
                padding: const EdgeInsets.all(AppSpace.x2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.mdAll,
                  border: Border.all(color: p.border),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  semanticLabel: '${project.title} logo',
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                ),
              ),
            ),
          )
        : Center(
            child: Icon(
              Icons.layers_outlined,
              size: 40,
              color: p.textTertiary,
              semanticLabel: '${project.title} (no preview available)',
            ),
          );

    return Container(
      height: fill ? null : height,
      constraints: fill ? const BoxConstraints(minHeight: 280) : null,
      decoration: BoxDecoration(color: p.subtle, borderRadius: rounded),
      child: inner,
    );
  }
}

/// Case-study CTA plus any source / live links.
class ProjectActions extends StatelessWidget {
  const ProjectActions({
    super.key,
    required this.project,
    this.primary = false,
  });

  final Project project;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final study = CaseStudyModel.forProject(project.id);
    final live = project.liveUrl;
    final github = project.githubUrl;
    final hasModules = study != null && study.modules.isNotEmpty;

    return Wrap(
      spacing: AppSpace.x15,
      runSpacing: AppSpace.x15,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppButton(
          label: 'View case study',
          icon: Icons.arrow_forward_rounded,
          variant: primary
              ? AppButtonVariant.primary
              : AppButtonVariant.secondary,
          compact: !primary,
          onPressed: () => openCaseStudy(context, project),
        ),
        if (live != null)
          AppButton(
            label: 'Live app',
            icon: Icons.open_in_new_rounded,
            variant: AppButtonVariant.ghost,
            compact: true,
            onPressed: () => openLink(context, live),
          ),
        if (github != null)
          AppButton(
            label: 'GitHub',
            icon: Icons.code_rounded,
            variant: AppButtonVariant.ghost,
            compact: true,
            onPressed: () => openLink(context, github),
          ),
        if (hasModules && live == null && github == null)
          Text(
            '${study.modules.length} apps · links inside',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.palette.textTertiary,
            ),
          ),
      ],
    );
  }
}
