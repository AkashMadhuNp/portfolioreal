class Experience {
  final String id;
  final String company;
  final String position;
  final String duration;
  final String location;

  /// Full, detailed list of responsibilities.
  final List<String> responsibilities;

  /// Concise, impact-oriented summary shown on the timeline. When empty the
  /// timeline falls back to [responsibilities].
  final List<String> highlights;
  final bool isCurrent;
  final String? logoUrl;
  final String? certificateUrl;

  const Experience({
    required this.id,
    required this.company,
    required this.position,
    required this.duration,
    required this.location,
    required this.responsibilities,
    this.highlights = const [],
    this.isCurrent = false,
    this.logoUrl,
    this.certificateUrl,
  });
}
