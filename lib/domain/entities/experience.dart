class Experience {
  final String id;
  final String company;
  final String position;
  final String duration;
  final String location;
  final List<String> responsibilities;
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
    this.isCurrent = false,
    this.logoUrl,
    this.certificateUrl,
  });
}

