class AppConstants {
  // Personal information
  static const String name = 'Akash Madhu N P';
  static const String role = 'Flutter Developer';
  static const String company = 'Emilo Ventures Private Limited';

  /// Year Flutter work began (Brototype program, Jun 2024).
  static const int flutterSince = 2024;

  /// Hero headline.
  static const String headline =
      'Production Flutter applications, engineered for performance and scale.';

  /// One-paragraph professional summary (hero, structured data).
  static const String bio =
      'Flutter and Dart engineer building production mobile and web apps: '
      'video editing and media pipelines, real-time features and third-party '
      'integrations, structured with Clean Architecture, BLoC and Provider.';

  /// About-section copy.
  static const List<String> aboutParagraphs = [
    'I build production Flutter applications for mobile and web. My work spans '
        'video editing and media pipelines, real-time features, payments and '
        'third-party SDK integrations, structured with Clean Architecture and '
        'BLoC or Provider.',
    'I started learning Flutter in 2024 through Brototype, joined '
        'DimensionLeap in 2025, and now work at Emilo Ventures in Raipur. I '
        'write unit and widget tests for what I build and verify media and '
        'real-time behaviour on physical devices.',
  ];

  /// Start of professional (employed) Flutter work: the DimensionLeap role
  /// (Sep 2025). Brototype, the training program before it, is deliberately
  /// not counted. A test keeps this in sync with the experience data.
  static const int professionalSinceYear = 2025;
  static const int professionalSinceMonth = 9;

  // Contact information
  static const String email = '002akashakz@gmail.com';
  static const String phone = '+91 7025522432';
  static const String location = 'India';

  // Canonical public URL (no trailing slash). Used by tool/generate_seo.dart
  // for canonical/Open Graph tags, the sitemap and structured data. Update it
  // here if the site moves to a custom domain.
  static const String siteUrl = 'https://akashmadhu-dev.vercel.app';
  static const String siteTitle =
      'Akash Madhu N P | Flutter Developer Portfolio';
  static const String siteDescription =
      'Flutter engineer building production mobile and web apps: video '
      'editing, FFmpeg media pipelines, real-time features and Clean '
      'Architecture.';

  // Résumé served by "Download CV". It is the only PDF in assets/files. To
  // update it, replace that file (keep the name) and redeploy. A test checks
  // that it exists, is a PDF, and that no other résumé ships alongside it.
  static const String resumeAsset = 'assets/files/Akash_Madhu_Resume.pdf';
  static const String resumeFileName = 'Akash_Madhu_Resume.pdf';

  /// Where the browser fetches [resumeAsset]: Flutter web serves bundled assets
  /// under an extra "assets/" prefix.
  static const String resumeWebUrl = 'assets/$resumeAsset';

  // Social profiles
  static const String github = 'https://github.com/AkashMadhuNp/';
  static const String linkedin =
      'https://www.linkedin.com/in/akash-madhu-flutter';

  // Animation durations
  static const Duration shortDuration = Duration(milliseconds: 300);
  static const Duration mediumDuration = Duration(milliseconds: 500);
  static const Duration longDuration = Duration(milliseconds: 800);
}
