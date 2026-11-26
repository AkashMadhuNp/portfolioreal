/// A group of related technologies (e.g. "State Management").
///
/// [iconKey] is a plain string so this entity stays free of Flutter imports
/// (the SEO generator reuses it); the UI maps it to an icon.
class SkillCategory {
  final String title;
  final String iconKey;
  final List<String> items;

  const SkillCategory({
    required this.title,
    required this.iconKey,
    required this.items,
  });
}
