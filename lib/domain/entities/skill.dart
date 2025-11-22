class Skill {
  final String name;
  final double proficiency; // 0.0 to 1.0
  final String category;
  final String? iconPath;

  const Skill({
    required this.name,
    required this.proficiency,
    required this.category,
    this.iconPath,
  });
}

