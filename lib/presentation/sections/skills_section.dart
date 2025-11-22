import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive_helper.dart';
import '../../data/models/skill_model.dart';
import '../widgets/section_title.dart';
import '../widgets/skill_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveHelper.getPadding(context);
    final technicalSkills = SkillModel.getTechnicalSkills();
    final softSkills = SkillModel.getSoftSkills();

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
                title: AppStrings.skillsTitle,
                subtitle: AppStrings.skillsSubtitle,
              ),
              const SizedBox(height: 60),

              // Technical Skills
              Text(
                AppStrings.technicalSkills,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 32),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveHelper.getCrossAxisCount(context),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 3.5,
                ),
                itemCount: technicalSkills.length,
                itemBuilder: (context, index) {
                  return SkillCard(
                    skill: technicalSkills[index],
                    index: index,
                  );
                },
              ),
              const SizedBox(height: 60),

              // Soft Skills
              Text(
                AppStrings.softSkills,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 32),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveHelper.getCrossAxisCount(context),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 3.5,
                ),
                itemCount: softSkills.length,
                itemBuilder: (context, index) {
                  return SkillCard(
                    skill: softSkills[index],
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

