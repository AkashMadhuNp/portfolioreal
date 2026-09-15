import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive_helper.dart';
import '../../data/models/skill_model.dart';
import '../widgets/section_title.dart';
import '../widgets/skill_chip.dart';
import '../widgets/infinite_scrolling_list.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveHelper.getPadding(context);
    final technicalSkills = SkillModel.getTechnicalSkills();
    final softSkills = SkillModel.getSoftSkills();

    final technicalSkillChips = technicalSkills.map((skill) => SkillChip(skill: skill)).toList();
    final softSkillChips = softSkills.map((skill) => SkillChip(skill: skill)).toList();

    return Container(
      padding: EdgeInsets.symmetric(vertical: padding.top),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding.left),
              child: const SectionTitle(
                title: AppStrings.skillsTitle,
                subtitle: AppStrings.skillsSubtitle,
              ),
            ),
            const SizedBox(height: 60),

            // Technical Skills Slider
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding.left),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.technicalSkills,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 60, // Fixed height for the chips
              child: InfiniteScrollingList(
                children: technicalSkillChips,
                speed: 40.0,
                gap: 20.0,
              ),
            ),
            const SizedBox(height: 60),

            // Soft Skills Slider
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding.left),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.softSkills,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 60,
              child: InfiniteScrollingList(
                children: softSkillChips,
                speed: 35.0,
                gap: 20.0,
                reverse: true, // Move in opposite direction for visual variety
              ),
            ),
          ],
        ),
      ),
    );
  }
}

