import 'package:flutter/material.dart';
import '../../domain/entities/skill.dart';

class SkillChip extends StatelessWidget {
  final Skill skill;

  const SkillChip({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (skill.category != 'Soft Skills') ...[
            Icon(
              _getIconForSkill(skill.name),
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
            const SizedBox(width: 12),
          ],
          Text(
            skill.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForSkill(String name) {
    final lowerName = name.toLowerCase();
    if (lowerName.contains('flutter') || lowerName.contains('dart')) {
      return Icons.phone_android;
    } else if (lowerName.contains('firebase') ||
        lowerName.contains('api') ||
        lowerName.contains('backend')) {
      return Icons.cloud_queue;
    } else if (lowerName.contains('git')) {
      return Icons.code;
    } else if (lowerName.contains('design') || lowerName.contains('figma')) {
      return Icons.design_services;
    } else if (lowerName.contains('database') ||
        lowerName.contains('sql') ||
        lowerName.contains('hive')) {
      return Icons.storage;
    } else if (lowerName.contains('architecture') ||
        lowerName.contains('mvc') ||
        lowerName.contains('mvvm')) {
      return Icons.architecture;
    }
    return Icons.star_border; // Fallback for soft skills or others
  }
}
