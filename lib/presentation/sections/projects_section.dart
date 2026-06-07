import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive_helper.dart';
import '../../data/models/project_model.dart';
import '../widgets/section_title.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveHelper.getPadding(context);
    final projects = ProjectModel.getSampleProjects();

    return Container(
      padding: padding,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxWidth(context),
          ),
          child: Column(
            children: [
              const SectionTitle(
                title: AppStrings.projectsTitle,
                subtitle: AppStrings.projectsSubtitle,
              ),
              const SizedBox(height: 60),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = ResponsiveHelper.getCrossAxisCount(context);
                  const double spacing = 24.0;
                  final double totalSpacing = (crossAxisCount - 1) * spacing;
                  final double cardWidth = (constraints.maxWidth - totalSpacing) / crossAxisCount;
                  
                  final double targetHeight = ResponsiveHelper.responsive(
                    context: context,
                    mobile: 430,
                    tablet: 450,
                    desktop: 480,
                  );
                  
                  final double childAspectRatio = cardWidth / targetHeight;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      return ProjectCard(
                        project: projects[index],
                        index: index,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

