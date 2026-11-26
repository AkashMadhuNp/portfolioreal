import 'package:flutter_test/flutter_test.dart';
import 'package:port_folio/core/constants/app_constants.dart';
import 'package:port_folio/data/models/case_study_model.dart';
import 'package:port_folio/data/models/engineering_model.dart';
import 'package:port_folio/data/models/experience_model.dart';
import 'package:port_folio/data/models/project_model.dart';
import 'package:port_folio/data/models/skill_model.dart';

/// Guards the portfolio's content: structure the UI relies on, and consistency
/// between sections, so a typo or a copy/paste cannot publish a broken page.
void main() {
  group('Skills', () {
    test('has exactly the six requested categories, in order', () {
      expect(SkillModel.getCategories().map((c) => c.title).toList(), [
        'Mobile Development',
        'State Management',
        'Architecture & Engineering',
        'Backend & Storage',
        'Media & Native Integration',
        'Development Tools',
      ]);
    });

    test('every category has items and no duplicates within it', () {
      for (final c in SkillModel.getCategories()) {
        expect(c.items, isNotEmpty, reason: c.title);
        expect(c.items.toSet().length, c.items.length, reason: c.title);
      }
    });

    test('includes the required core technologies', () {
      final all = SkillModel.allSkills().join(' | ').toLowerCase();
      for (final t in [
        'flutter',
        'dart',
        'bloc',
        'provider',
        'getx',
        'clean architecture',
        'firebase',
        'rest apis',
        'hive',
        'ffmpeg',
        'hls',
        'javascript interop',
        'git',
      ]) {
        expect(all, contains(t), reason: 'missing $t');
      }
    });
  });

  group('Engineering highlights', () {
    final highlights = EngineeringModel.getHighlights();

    test('has six unique, fully populated entries', () {
      expect(highlights.length, 6);
      expect(highlights.map((h) => h.id).toSet().length, 6);
      for (final h in highlights) {
        expect(h.title, isNotEmpty);
        expect(h.description.length, greaterThan(40), reason: h.id);
        expect(h.context, isNotEmpty, reason: h.id);
        expect(h.tags, isNotEmpty, reason: h.id);
      }
    });

    test('quoted figures match the experience content they come from', () {
      final emilo = ExperienceModel.getExperiences().first.responsibilities
          .join(' ');
      // The numbers used in highlights must exist in the source bullets.
      expect(emilo, contains('47 unit and widget test files'));
      expect(emilo, contains('70% dominance / 30% release'));
      final arch = highlights.firstWhere((h) => h.id == 'architecture');
      expect(arch.description, contains('47 unit and widget test files'));
      final playback = highlights.firstWhere((h) => h.id == 'playback');
      expect(playback.description, contains('70% dominance / 30% release'));
    });
  });

  group('Projects and case studies', () {
    final projects = ProjectModel.getSampleProjects();

    test('lists the four featured projects, Spotlight first', () {
      expect(projects.map((p) => p.title).toList(), [
        'Spotlight',
        'Healthcare Management Platform',
        'Connect',
        'Refine Spot',
      ]);
    });

    test('every project has a summary and 4–6 tags drawn from its stack', () {
      for (final p in projects) {
        expect(p.summary, isNotEmpty, reason: p.title);
        expect(p.highlightTags.length, inInclusiveRange(4, 6), reason: p.title);
        final stack = p.technologies.map((t) => t.toLowerCase()).toSet();
        for (final tag in p.highlightTags) {
          expect(
            stack,
            contains(tag.toLowerCase()),
            reason: '${p.title}: "$tag" is not in its technologies',
          );
        }
      }
    });

    test('every project has a case study with the core sections', () {
      for (final p in projects) {
        final s = CaseStudyModel.forProject(p.id);
        expect(s, isNotNull, reason: '${p.title} has no case study');
        expect(s!.problem.length, greaterThan(40), reason: p.title);
        expect(s.contribution, isNotEmpty, reason: p.title);
        expect(s.architecture, isNotEmpty, reason: p.title);
        expect(s.results, isNotEmpty, reason: p.title);
      }
    });

    test('all links are absolute https URLs', () {
      final urls = <String>[
        for (final p in projects) ...[?p.liveUrl, ?p.githubUrl],
        for (final s in CaseStudyModel.all()) ...[
          for (final l in s.links) l.url,
          for (final m in s.modules)
            for (final l in m.links) l.url,
        ],
      ];
      expect(urls, isNotEmpty);
      for (final u in urls) {
        final uri = Uri.parse(u);
        expect(uri.scheme, 'https', reason: u);
        expect(uri.host, isNotEmpty, reason: u);
      }
    });

    test('image assets exist as WebP (the originals are not shipped)', () {
      for (final p in projects.where((p) => p.imageUrl != null)) {
        expect(p.imageUrl, endsWith('.webp'), reason: p.title);
      }
    });
  });

  group('Experience', () {
    final experiences = ExperienceModel.getExperiences();

    test('keeps the recorded titles and dates', () {
      expect(
        experiences
            .map((e) => '${e.position} | ${e.company} | ${e.duration}')
            .toList(),
        [
          'Flutter Developer | Emilo Ventures Private Limited | Jun 2026 - Present',
          'Associate Flutter Developer | DimensionLeap | Sep 2025 - Jun 2026',
          'Flutter Developer Student | Brototype | Jun 2024 - Jul 2025',
        ],
      );
    });

    test('has concise highlights that are shorter than the full detail', () {
      for (final e in experiences) {
        expect(e.highlights, isNotEmpty, reason: e.company);
        expect(e.highlights.length, lessThanOrEqualTo(7), reason: e.company);
        expect(
          e.highlights.join().length,
          lessThan(e.responsibilities.join().length),
          reason: '${e.company}: highlights should be shorter than full detail',
        );
      }
    });

    test('exactly one role is current, and it matches the About copy', () {
      final current = experiences.where((e) => e.isCurrent).toList();
      expect(current.length, 1);
      expect(current.single.company, AppConstants.company);
    });
  });

  group('Site metadata', () {
    test('title and description are sensible lengths for search results', () {
      expect(AppConstants.siteTitle.length, lessThanOrEqualTo(60));
      expect(AppConstants.siteDescription.length, inInclusiveRange(70, 160));
    });

    test('canonical URL is https with no trailing slash', () {
      expect(AppConstants.siteUrl, startsWith('https://'));
      expect(AppConstants.siteUrl, isNot(endsWith('/')));
    });
  });
}
