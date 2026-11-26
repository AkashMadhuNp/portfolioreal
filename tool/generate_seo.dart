// Generates every SEO artefact from the same data the app renders, so the
// crawlable HTML can never drift from what visitors see.
//
//   dart run tool/generate_seo.dart
//
// Why this exists: Flutter web paints to a <canvas>, so a crawler that reads
// the DOM sees an empty page. This script writes real, semantic HTML (plus
// JSON-LD, canonical/Open Graph tags, robots.txt and sitemap.xml) into
// web/index.html and web/, which `flutter build web` then ships as-is.
//
// It only imports pure-Dart files (models/entities/constants), never Flutter.
import 'dart:convert';
import 'dart:io';

import 'package:port_folio/core/constants/app_constants.dart';
import 'package:port_folio/data/models/case_study_model.dart';
import 'package:port_folio/data/models/engineering_model.dart';
import 'package:port_folio/data/models/experience_model.dart';
import 'package:port_folio/data/models/project_model.dart';
import 'package:port_folio/data/models/skill_model.dart';

const _text = HtmlEscape(HtmlEscapeMode.element);
const _attr = HtmlEscape(HtmlEscapeMode.attribute);

String get _site => AppConstants.siteUrl;

void main() {
  final root = Directory.current.path;
  final indexFile = File('$root/web/index.html');
  if (!indexFile.existsSync()) {
    stderr.writeln('web/index.html not found. Run from the project root.');
    exit(1);
  }

  var html = indexFile.readAsStringSync();
  html = _replaceBlock(html, 'HEAD', _headTags());
  html = _replaceBlock(html, 'JSONLD', _jsonLd());
  html = _replaceBlock(html, 'BODY', _bodyContent());
  indexFile.writeAsStringSync(html);

  File('$root/web/robots.txt').writeAsStringSync(_robots());
  File('$root/web/sitemap.xml').writeAsStringSync(_sitemap());

  stdout.writeln('SEO files generated for $_site');
}

String _replaceBlock(String source, String name, String content) {
  final begin = '<!-- SEO:$name:BEGIN -->';
  final end = '<!-- SEO:$name:END -->';
  final a = source.indexOf(begin);
  final b = source.indexOf(end);
  if (a < 0 || b < a) {
    stderr.writeln('Missing marker pair for SEO:$name in web/index.html');
    exit(1);
  }
  return '${source.substring(0, a + begin.length)}\n$content\n  ${source.substring(b)}';
}

// ── <head>: URL-dependent tags ────────────────────────────────────────────

String _headTags() {
  final image = '$_site/og-image.jpg';
  final alt = _attr.convert(
    '${AppConstants.name}, ${AppConstants.role}, smiling in a cream suit',
  );
  final links = [AppConstants.github, AppConstants.linkedin]
      .where((u) => u.isNotEmpty)
      .map((u) => '  <link rel="me" href="${_attr.convert(u)}">')
      .join('\n');

  final title = _attr.convert(AppConstants.siteTitle);
  final description = _attr.convert(AppConstants.siteDescription);

  return '''
  <title>${_text.convert(AppConstants.siteTitle)}</title>
  <meta name="description" content="$description">
  <link rel="canonical" href="$_site/">
$links
  <meta property="og:type" content="website">
  <meta property="og:site_name" content="${_attr.convert(AppConstants.name)}">
  <meta property="og:locale" content="en_US">
  <meta property="og:title" content="$title">
  <meta property="og:description" content="$description">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="$title">
  <meta name="twitter:description" content="$description">
  <meta property="og:url" content="$_site/">
  <meta property="og:image" content="$image">
  <meta property="og:image:secure_url" content="$image">
  <meta property="og:image:type" content="image/jpeg">
  <meta property="og:image:width" content="1200">
  <meta property="og:image:height" content="630">
  <meta property="og:image:alt" content="$alt">
  <meta name="twitter:image" content="$image">
  <meta name="twitter:image:alt" content="$alt">''';
}

// ── <head>: structured data ───────────────────────────────────────────────

String _jsonLd() {
  final current = ExperienceModel.getExperiences()
      .where((e) => e.isCurrent)
      .toList();
  final skills = SkillModel.allSkills();

  final person = <String, dynamic>{
    '@type': 'Person',
    '@id': '$_site/#person',
    'name': AppConstants.name,
    'url': '$_site/',
    'image': '$_site/og-image.jpg',
    'jobTitle': AppConstants.role,
    'description': AppConstants.bio,
    if (current.isNotEmpty)
      'worksFor': {'@type': 'Organization', 'name': current.first.company},
    'knowsAbout': skills,
    'sameAs': [
      AppConstants.github,
      AppConstants.linkedin,
    ].where((u) => u.isNotEmpty).toList(),
    'address': {'@type': 'PostalAddress', 'addressCountry': 'IN'},
  };

  final graph = {
    '@context': 'https://schema.org',
    '@graph': [
      {
        '@type': 'WebSite',
        '@id': '$_site/#website',
        'url': '$_site/',
        'name': AppConstants.siteTitle,
        'inLanguage': 'en',
        'publisher': {'@id': '$_site/#person'},
      },
      {
        '@type': 'ProfilePage',
        '@id': '$_site/#profilepage',
        'url': '$_site/',
        'name': AppConstants.siteTitle,
        'description': AppConstants.siteDescription,
        'inLanguage': 'en',
        'isPartOf': {'@id': '$_site/#website'},
        'mainEntity': {'@id': '$_site/#person'},
      },
      person,
    ],
  };

  // "<" is escaped (as the six characters \ u 0 0 3 c) so no value can ever
  // close the script element early. Built from char codes to avoid an escape
  // sequence in source that tooling may rewrite.
  final escapedLt = String.fromCharCodes([0x5c, 0x75, 0x30, 0x30, 0x33, 0x63]);
  final json = const JsonEncoder.withIndent(
    '  ',
  ).convert(graph).replaceAll('<', escapedLt);
  final indented = json.split('\n').map((l) => '  $l').join('\n');
  return '  <script type="application/ld+json">\n$indented\n  </script>';
}

// ── <body>: semantic, crawlable copy of the portfolio ─────────────────────

String _bodyContent() {
  final b = StringBuffer();
  void line(String s) => b.writeln('    $s');

  line('<main id="seo-content" class="seo-only">');
  line('  <header>');
  line(
    '    <h1>${_text.convert(AppConstants.name)} – '
    '${_text.convert(AppConstants.role)}</h1>',
  );
  line('    <p>${_text.convert(AppConstants.bio)}</p>');
  line('  </header>');

  // About
  line('  <section aria-labelledby="seo-about">');
  line('    <h2 id="seo-about">About</h2>');
  for (final paragraph in AppConstants.aboutParagraphs) {
    line('    <p>${_text.convert(paragraph)}</p>');
  }
  line('  </section>');

  // Skills, by category
  line('  <section aria-labelledby="seo-skills">');
  line('    <h2 id="seo-skills">Skills and tools</h2>');
  for (final category in SkillModel.getCategories()) {
    line('    <h3>${_text.convert(category.title)}</h3>');
    line('    <ul>');
    for (final item in category.items) {
      line('      <li>${_text.convert(item)}</li>');
    }
    line('    </ul>');
  }
  line('  </section>');

  // Engineering highlights
  line('  <section aria-labelledby="seo-engineering">');
  line('    <h2 id="seo-engineering">Engineering highlights</h2>');
  for (final h in EngineeringModel.getHighlights()) {
    line('    <article>');
    line('      <h3>${_text.convert(h.title)}</h3>');
    line('      <p>${_text.convert(h.description)}</p>');
    line('      <p>${_text.convert(h.context)}</p>');
    line('    </article>');
  }
  line('  </section>');

  // Projects with their case studies
  line('  <section aria-labelledby="seo-projects">');
  line('    <h2 id="seo-projects">Featured projects</h2>');
  for (final p in ProjectModel.getSampleProjects()) {
    final study = CaseStudyModel.forProject(p.id);
    line('    <article>');
    line('      <h3>${_text.convert(p.title)}</h3>');
    line(
      '      <p>${_text.convert(p.category)} – ${_text.convert(p.type)}</p>',
    );
    line('      <p>${_text.convert(p.description)}</p>');
    line(
      '      <p>Technologies: ${_text.convert(p.technologies.join(', '))}.</p>',
    );
    if (study != null) {
      void list(String heading, List<String> items) {
        if (items.isEmpty) return;
        line('      <h4>${_text.convert(heading)}</h4>');
        line('      <ul>');
        for (final i in items) {
          line('        <li>${_text.convert(i)}</li>');
        }
        line('      </ul>');
      }

      line('      <h4>Problem and goal</h4>');
      line('      <p>${_text.convert(study.problem)}</p>');
      list('My contribution', study.contribution);
      list('Technical architecture', study.architecture);
      list('Implementation decisions', study.decisions);
      if (study.challenges.isNotEmpty) {
        line('      <h4>Challenges and solutions</h4>');
        line('      <ul>');
        for (final c in study.challenges) {
          line(
            '        <li>${_text.convert(c.challenge)} ${_text.convert(c.solution)}</li>',
          );
        }
        line('      </ul>');
      }
      list('Results', study.results);
    }
    final links = <String>[
      if (p.liveUrl != null)
        '<a href="${_attr.convert(p.liveUrl!)}" rel="noopener">Live demo</a>',
      if (p.githubUrl != null)
        '<a href="${_attr.convert(p.githubUrl!)}" rel="noopener">Source code</a>',
    ];
    if (links.isNotEmpty) line('      <p>${links.join(' · ')}</p>');
    line('    </article>');
  }
  line('  </section>');

  // Experience
  line('  <section aria-labelledby="seo-experience">');
  line('    <h2 id="seo-experience">Work experience</h2>');
  for (final e in ExperienceModel.getExperiences()) {
    line('    <article>');
    line(
      '      <h3>${_text.convert(e.position)} at ${_text.convert(e.company)}</h3>',
    );
    line(
      '      <p>${_text.convert(e.duration)} · ${_text.convert(e.location)}</p>',
    );
    line('      <ul>');
    for (final r in e.responsibilities) {
      line('        <li>${_text.convert(r)}</li>');
    }
    line('      </ul>');
    line('    </article>');
  }
  line('  </section>');

  // Contact: profiles only. Email and phone are deliberately left out of the
  // crawlable HTML so they cannot be harvested by scrapers; the on-page
  // contact form covers enquiries.
  line('  <section aria-labelledby="seo-contact">');
  line('    <h2 id="seo-contact">Contact</h2>');
  line(
    '    <p>Use the contact form on this page, or find '
    '${_text.convert(AppConstants.name)} online:</p>',
  );
  line('    <ul>');
  line(
    '      <li><a href="${_attr.convert(AppConstants.github)}" rel="me noopener">GitHub</a></li>',
  );
  line(
    '      <li><a href="${_attr.convert(AppConstants.linkedin)}" rel="me noopener">LinkedIn</a></li>',
  );
  line('    </ul>');
  line('  </section>');
  line('</main>');

  return b.toString().trimRight();
}

// ── robots.txt / sitemap.xml ──────────────────────────────────────────────

String _robots() =>
    '''
User-agent: *
Allow: /

Sitemap: $_site/sitemap.xml
''';

String _sitemap() {
  final today = DateTime.now().toUtc().toIso8601String().substring(0, 10);
  return '''
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>$_site/</loc>
    <lastmod>$today</lastmod>
    <changefreq>monthly</changefreq>
    <priority>1.0</priority>
  </url>
</urlset>
''';
}
