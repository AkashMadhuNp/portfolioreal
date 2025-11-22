class Project {
  final String id;
  final String title;
  final String description;
  final List<String> technologies;
  final String? imageUrl;
  final String? liveUrl;
  final String? githubUrl;
  final String category;
  final bool isFeatured;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    this.imageUrl,
    this.liveUrl,
    this.githubUrl,
    required this.category,
    this.isFeatured = false,
  });
}

