/// A challenge and how it was addressed.
class CaseStudyChallenge {
  final String challenge;
  final String solution;

  const CaseStudyChallenge({required this.challenge, required this.solution});
}

/// An external link attached to a project (live demo, source, APK, video).
class CaseStudyLink {
  final String label;
  final String url;

  /// One of: live, github, apk, video.
  final String kind;

  const CaseStudyLink({
    required this.label,
    required this.url,
    required this.kind,
  });
}

/// One deliverable of a multi-app project (e.g. Refine Spot's user app).
class CaseStudyModule {
  final String name;
  final List<CaseStudyLink> links;

  const CaseStudyModule({required this.name, this.links = const []});
}

/// Structured write-up of a project. Sections that are empty are not rendered,
/// so a thinly documented project shows less instead of padding with claims.
class CaseStudy {
  final String projectId;
  final String subtitle;
  final String tagline;

  /// e.g. "Flutter Developer · DimensionLeap".
  final String role;

  /// Problem and goal.
  final String problem;

  /// What I personally built.
  final List<String> contribution;
  final List<String> architecture;
  final List<String> decisions;
  final List<CaseStudyChallenge> challenges;

  /// Verifiable outcomes only (no invented metrics).
  final List<String> results;
  final List<String> features;
  final List<CaseStudyLink> links;
  final List<CaseStudyModule> modules;

  const CaseStudy({
    required this.projectId,
    required this.subtitle,
    required this.tagline,
    required this.role,
    required this.problem,
    this.contribution = const [],
    this.architecture = const [],
    this.decisions = const [],
    this.challenges = const [],
    this.results = const [],
    this.features = const [],
    this.links = const [],
    this.modules = const [],
  });
}
