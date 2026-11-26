import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../data/models/experience_model.dart';
import '../widgets/experience_card.dart';
import '../widgets/ui/app_section.dart';

/// Experience: a timeline of roles, newest first.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final experiences = ExperienceModel.getExperiences();

    return AppSection(
      eyebrow: '05 · Experience',
      title: 'Experience',
      subtitle:
          'Production Flutter work in media, real-time features and healthcare, from first project to current role.',
      child: Column(
        children: [
          for (var i = 0; i < experiences.length; i++)
            FadeInUp(
              from: 16,
              delay: Duration(milliseconds: 80 * i),
              duration: const Duration(milliseconds: 500),
              child: ExperienceEntry(
                experience: experiences[i],
                isLast: i == experiences.length - 1,
              ),
            ),
        ],
      ),
    );
  }
}
