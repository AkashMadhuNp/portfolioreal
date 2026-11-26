import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_palette.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_tokens.dart';
import '../../data/models/case_study_model.dart';
import '../../data/models/project_model.dart';
import '../../domain/entities/case_study.dart';
import '../../domain/entities/project.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/ui/app_button.dart';
import '../widgets/ui/app_card.dart';
import '../widgets/ui/open_link.dart';
import '../widgets/ui/tech_tag.dart';

/// Case study for one project. Sections without content are not rendered, so a
/// thinly documented project shows less rather than padding with filler.
class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final width = MediaQuery.of(context).size.width;
    final study = CaseStudyModel.forProject(project.id);
    final wide = width >= 900;
    final gutter = AppSpace.gutter(width);

    final sections = _sections(context, study);

    return Scaffold(
      body: Column(
        children: [
          _TopBar(gutter: gutter),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  // The gutters sit inside the max width here, so the body's
                  // left edge matches the top bar (which pads outside its
                  // 1100px box) at every viewport width.
                  constraints: BoxConstraints(maxWidth: 1100 + gutter * 2),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      gutter,
                      AppSpace.x6,
                      gutter,
                      AppSpace.x10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInUp(
                          from: 16,
                          duration: const Duration(milliseconds: 500),
                          child: _Hero(project: project, study: study),
                        ),
                        const SizedBox(height: AppSpace.x6),
                        if (wide)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 7,
                                child: _SectionColumn(sections: sections),
                              ),
                              const SizedBox(width: AppSpace.x6),
                              Expanded(
                                flex: 3,
                                child: _AtAGlance(
                                  project: project,
                                  study: study,
                                ),
                              ),
                            ],
                          )
                        else ...[
                          _AtAGlance(project: project, study: study),
                          const SizedBox(height: AppSpace.x5),
                          _SectionColumn(sections: sections),
                        ],
                        const SizedBox(height: AppSpace.x8),
                        Divider(color: p.border, height: 1),
                        const SizedBox(height: AppSpace.x5),
                        _NextProject(current: project),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Ordered, non-empty sections as (title, content builder).
  List<_Section> _sections(BuildContext context, CaseStudy? s) {
    if (s == null) {
      return [
        _Section(
          'Overview',
          (c) =>
              Text(project.description, style: Theme.of(c).textTheme.bodyLarge),
        ),
      ];
    }
    TextTheme text(BuildContext c) => Theme.of(c).textTheme;
    return [
      _Section(
        'Problem & goal',
        (c) => Text(s.problem, style: text(c).bodyLarge),
      ),
      if (s.contribution.isNotEmpty)
        _Section('My contribution', (c) => _Bullets(s.contribution)),
      if (s.architecture.isNotEmpty)
        _Section('Technical architecture', (c) => _Bullets(s.architecture)),
      if (s.decisions.isNotEmpty)
        _Section('Implementation decisions', (c) => _Bullets(s.decisions)),
      if (s.challenges.isNotEmpty)
        _Section('Challenges & solutions', (c) => _Challenges(s.challenges)),
      if (s.modules.isNotEmpty)
        _Section('Applications', (c) => _Modules(s.modules)),
      if (s.results.isNotEmpty) _Section('Results', (c) => _Bullets(s.results)),
      if (s.features.isNotEmpty)
        _Section('Key features', (c) => _Bullets(s.features, quiet: true)),
    ];
  }
}

class _Section {
  const _Section(this.title, this.build);

  final String title;
  final Widget Function(BuildContext context) build;
}

class _SectionColumn extends StatelessWidget {
  const _SectionColumn({required this.sections});

  final List<_Section> sections;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < sections.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpace.x6),
          Row(
            children: [
              Text(
                (i + 1).toString().padLeft(2, '0'),
                style: AppType.eyebrow(context),
              ),
              const SizedBox(width: AppSpace.x15),
              Expanded(child: Divider(color: p.border, height: 1)),
            ],
          ),
          const SizedBox(height: AppSpace.x15),
          Semantics(
            header: true,
            child: Text(
              sections[i].title,
              style: AppType.display(context, size: 28),
            ),
          ),
          const SizedBox(height: AppSpace.x2),
          sections[i].build(context),
        ],
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.gutter});

  final double gutter;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Material(
      color: p.background,
      child: Container(
        height: AppLayout.navHeight,
        padding: EdgeInsets.symmetric(horizontal: gutter),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: p.border)),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Row(
              children: [
                AppButton(
                  label: 'Back to portfolio',
                  icon: Icons.arrow_back_rounded,
                  variant: AppButtonVariant.ghost,
                  compact: true,
                  onPressed: () => Navigator.maybePop(context),
                ),
                const Spacer(),
                const ThemeToggle(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.project, required this.study});

  final Project project;
  final CaseStudy? study;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    final small = MediaQuery.of(context).size.width < Breakpoints.mobile;
    final links = [
      ...?study?.links,
      // Fall back to the project's own URLs when there is no case study.
      if (study == null && project.liveUrl != null)
        CaseStudyLink(label: 'Live app', url: project.liveUrl!, kind: 'live'),
      if (study == null && project.githubUrl != null)
        CaseStudyLink(
          label: 'Source code',
          url: project.githubUrl!,
          kind: 'github',
        ),
    ];

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
                '${project.category} · ${project.isCompanyProject ? 'Company project' : 'Personal project'}'
                    .toUpperCase(),
                style: AppType.eyebrow(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpace.x2),
        Semantics(
          header: true,
          child: Text(
            project.title,
            style: AppType.display(
              context,
              size: small ? 38 : 56,
              weight: FontWeight.w800,
              height: 1.06,
              letterSpacing: -1.5,
            ),
          ),
        ),
        if (study != null) ...[
          const SizedBox(height: AppSpace.x15),
          Text(
            study!.subtitle,
            style: text.titleLarge?.copyWith(
              color: p.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpace.x2),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(study!.tagline, style: text.bodyLarge),
          ),
        ],
        if (links.isNotEmpty) ...[
          const SizedBox(height: AppSpace.x4),
          Wrap(
            spacing: AppSpace.x15,
            runSpacing: AppSpace.x15,
            children: [
              for (var i = 0; i < links.length; i++)
                AppButton(
                  label: links[i].label,
                  icon: _iconForKind(links[i].kind),
                  variant: i == 0
                      ? AppButtonVariant.primary
                      : AppButtonVariant.secondary,
                  onPressed: () => openLink(context, links[i].url),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

IconData _iconForKind(String kind) {
  switch (kind) {
    case 'github':
      return Icons.code_rounded;
    case 'apk':
      return Icons.android_rounded;
    case 'video':
      return Icons.play_circle_outline_rounded;
    default:
      return Icons.open_in_new_rounded;
  }
}

/// Role, type and stack at a glance.
class _AtAGlance extends StatelessWidget {
  const _AtAGlance({required this.project, required this.study});

  final Project project;
  final CaseStudy? study;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;

    Widget label(String t) => Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.x1),
      child: Text(
        t.toUpperCase(),
        style: text.bodySmall?.copyWith(
          color: p.textTertiary,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (study != null) ...[
            label('Role'),
            Text(study!.role, style: text.titleSmall),
            const SizedBox(height: AppSpace.x3),
          ],
          label('Type'),
          Text(
            project.isCompanyProject ? 'Company project' : 'Personal project',
            style: text.titleSmall,
          ),
          const SizedBox(height: AppSpace.x3),
          label('Stack'),
          TechTagWrap(project.technologies),
        ],
      ),
    );
  }
}

class _Bullets extends StatelessWidget {
  const _Bullets(this.items, {this.quiet = false});

  final List<String> items;

  /// Smaller, secondary-weight list (used for the long feature list).
  final bool quiet;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpace.x15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: quiet ? 9 : 11),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: quiet ? p.textTertiary : p.goldStrong,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpace.x15),
                Expanded(
                  child: Text(
                    item,
                    style: quiet ? text.bodyMedium : text.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Challenges extends StatelessWidget {
  const _Challenges(this.items);

  final List<CaseStudyChallenge> items;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final text = Theme.of(context).textTheme;
    return Column(
      children: [
        for (final c in items)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpace.x2),
            child: SizedBox(
              width: double.infinity,
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CHALLENGE',
                      style: text.bodySmall?.copyWith(
                        color: p.textTertiary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: AppSpace.x05),
                    Text(
                      c.challenge,
                      style: text.titleSmall?.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: AppSpace.x2),
                    Text(
                      'SOLUTION',
                      style: text.bodySmall?.copyWith(
                        color: p.accent,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: AppSpace.x05),
                    Text(c.solution, style: text.bodyMedium),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _Modules extends StatelessWidget {
  const _Modules(this.modules);

  final List<CaseStudyModule> modules;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      children: [
        for (var i = 0; i < modules.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpace.x2),
            child: SizedBox(
              width: double.infinity,
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${i + 1}. ${modules[i].name}',
                      style: text.titleMedium,
                    ),
                    const SizedBox(height: AppSpace.x15),
                    Wrap(
                      spacing: AppSpace.x15,
                      runSpacing: AppSpace.x1,
                      children: [
                        for (final l in modules[i].links)
                          AppButton(
                            label: l.label,
                            icon: _iconForKind(l.kind),
                            variant: AppButtonVariant.secondary,
                            compact: true,
                            onPressed: () => openLink(context, l.url),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Link to the next project in the list, so case studies can be read in turn.
class _NextProject extends StatelessWidget {
  const _NextProject({required this.current});

  final Project current;

  @override
  Widget build(BuildContext context) {
    final projects = ProjectModel.getSampleProjects();
    final index = projects.indexWhere((p) => p.id == current.id);
    if (index < 0 || projects.length < 2) return const SizedBox.shrink();
    final next = projects[(index + 1) % projects.length];
    final p = context.palette;
    final text = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: AppCard(
        onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ProjectDetailScreen(project: next)),
        ),
        semanticLabel: 'Next project: ${next.title}',
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NEXT PROJECT',
                    style: text.bodySmall?.copyWith(
                      color: p.textTertiary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: AppSpace.x05),
                  Text(next.title, style: AppType.display(context, size: 26)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_rounded, color: p.accent),
          ],
        ),
      ),
    );
  }
}
