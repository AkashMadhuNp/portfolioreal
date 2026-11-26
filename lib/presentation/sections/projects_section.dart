import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_tokens.dart';
import '../../data/models/project_model.dart';
import '../widgets/project_card.dart';
import '../widgets/ui/app_grid.dart';
import '../widgets/ui/app_section.dart';

/// Projects: the flagship (Spotlight) leads at full width, followed by the
/// remaining projects in an equal-height grid.
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = ProjectModel.getSampleProjects();
    final flagship = projects.first;
    final others = projects.skip(1).toList();

    return AppSection(
      alt: true,
      eyebrow: '04 · Projects',
      title: 'Featured projects',
      subtitle:
          'Production work and personal builds, each with a case study covering the problem, my contribution and the architecture.',
      child: Column(
        children: [
          FadeInUp(
            from: 16,
            duration: const Duration(milliseconds: 600),
            child: FeaturedProjectCard(project: flagship),
          ),
          const SizedBox(height: AppSpace.x3),
          AppGrid(
            children: [
              for (var i = 0; i < others.length; i++)
                FadeInUp(
                  from: 16,
                  delay: Duration(milliseconds: 80 * i),
                  duration: const Duration(milliseconds: 500),
                  child: ProjectCard(project: others[i]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
