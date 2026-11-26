class Project {
  final String id;
  final String title;

  /// Full description (used on the case-study page and in SEO content).
  final String description;

  /// One or two sentences for the project card.
  final String summary;
  final List<String> technologies;

  /// The 4–6 tags shown on the card (a curated subset of [technologies]).
  final List<String> highlightTags;

  /// Thumbnail shown on the card. When null the card shows a neutral
  /// placeholder; no screenshot is ever fabricated.
  final String? imageUrl;
  final String? liveUrl;
  final String? githubUrl;
  final String category;
  final bool isFeatured;
  final String type;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    this.summary = '',
    required this.technologies,
    this.highlightTags = const [],
    this.imageUrl,
    this.liveUrl,
    this.githubUrl,
    required this.category,
    this.isFeatured = false,
    this.type = 'Demo Project',
  });

  /// Whether this was built for an employer (vs a personal/demo project).
  bool get isCompanyProject => type.contains('Company');
}
