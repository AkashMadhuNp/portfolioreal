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
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveHelper.responsive(
                    context: context,
                    mobile: 1,
                    desktop: 3,
                  ),
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: ResponsiveHelper.isMobile(context) ? 0.85 : 0.75,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return ProjectCard(
                    project: projects[index],
                    index: index,
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

