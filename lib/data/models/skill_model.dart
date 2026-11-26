import '../../domain/entities/skill.dart';

/// Technologies grouped by discipline. Every item appears in the experience
/// or project content (or, for HLS, in the engineering brief) so the page
/// never lists a skill that isn't backed by real work.
class SkillModel {
  static List<SkillCategory> getCategories() {
    return const [
      SkillCategory(
        title: 'Mobile Development',
        iconKey: 'mobile',
        items: [
          'Flutter',
          'Dart',
          'Responsive layouts',
          'Custom animations',
          'Custom UI components',
        ],
      ),
      SkillCategory(
        title: 'State Management',
        iconKey: 'state',
        items: ['BLoC', 'Provider', 'GetX'],
      ),
      SkillCategory(
        title: 'Architecture & Engineering',
        iconKey: 'architecture',
        items: [
          'Clean Architecture',
          'MVVM',
          'MVP',
          'Dependency injection (GetIt)',
          'Unit & widget testing',
        ],
      ),
      SkillCategory(
        title: 'Backend & Storage',
        iconKey: 'backend',
        items: [
          'Firebase',
          'REST APIs',
          'Socket.IO',
          'Hive',
          'Shared Preferences',
          'SQL / NoSQL',
          'Razorpay',
          'Stripe',
        ],
      ),
      SkillCategory(
        title: 'Media & Native Integration',
        iconKey: 'media',
        items: [
          'FFmpeg / FFmpegKit',
          'HLS',
          'JavaScript Interop',
          'Kotlin (Android)',
          'Media3 ExoPlayer',
          'Agora SDK',
        ],
      ),
      SkillCategory(
        title: 'Development Tools',
        iconKey: 'tools',
        items: ['Git & GitHub', 'Figma', 'Jira', 'CI/CD pipelines'],
      ),
    ];
  }

  /// Flat list of every technology (used for structured data).
  static List<String> allSkills() => [
    for (final c in getCategories()) ...c.items,
  ];
}
