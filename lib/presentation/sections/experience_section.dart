import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive_helper.dart';
import '../../data/models/experience_model.dart';
import '../widgets/section_title.dart';
import '../widgets/experience_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveHelper.getPadding(context);
    final experiences = ExperienceModel.getExperiences();

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
                title: AppStrings.experienceTitle,
                subtitle: AppStrings.experienceSubtitle,
              ),
              const SizedBox(height: 60),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experiences.length,
                separatorBuilder: (context, index) => const SizedBox(height: 24),
                itemBuilder: (context, index) {
                  return ExperienceCard(
                    experience: experiences[index],
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

