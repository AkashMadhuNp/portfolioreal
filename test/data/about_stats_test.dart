import 'package:flutter_test/flutter_test.dart';
import 'package:port_folio/core/constants/app_constants.dart';
import 'package:port_folio/data/models/about_stats_model.dart';
import 'package:port_folio/data/models/experience_model.dart';
import 'package:port_folio/data/models/project_model.dart';

void main() {
  group('Professional years', () {
    test('count completed years from the first employed role (Sep 2025)', () {
      expect(AboutStatsModel.professionalYears(DateTime(2025, 8, 31)), 0);
      expect(AboutStatsModel.professionalYears(DateTime(2025, 9, 1)), 0);
      expect(AboutStatsModel.professionalYears(DateTime(2026, 8, 31)), 0);
      expect(AboutStatsModel.professionalYears(DateTime(2026, 9, 1)), 1);
      expect(AboutStatsModel.professionalYears(DateTime(2026, 11, 26)), 1);
      expect(AboutStatsModel.professionalYears(DateTime(2027, 9, 1)), 2);
    });

    test(
      'the start date matches the DimensionLeap role in the experience data',
      () {
        final first = ExperienceModel.getExperiences().firstWhere(
          (e) => e.company == 'DimensionLeap',
        );
        const months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        final expected =
            '${months[AppConstants.professionalSinceMonth - 1]} '
            '${AppConstants.professionalSinceYear}';
        expect(first.duration, startsWith(expected));
      },
    );

    test('Brototype (training) is not counted as professional experience', () {
      final brototype = ExperienceModel.getExperiences().firstWhere(
        (e) => e.company == 'Brototype',
      );
      expect(brototype.position, contains('Student'));
      // Professional time must start after the Brototype program began.
      expect(AppConstants.professionalSinceYear, greaterThan(2024));
    });
  });

  group('About statistics', () {
    final stats = AboutStatsModel.getStats(now: DateTime(2026, 11, 26));

    test('are exactly the four journey statistics, in order', () {
      expect(stats.map((s) => '${s.value} | ${s.label}').toList(), [
        '2024 | Flutter development journey started',
        '1+ | Years of professional experience',
        '4 | Featured projects',
        'Production | Application development experience',
      ]);
    });

    test('contain no commit counts, test-file counts or module metrics', () {
      final text = stats
          .map((s) => '${s.value} ${s.label}')
          .join(' ')
          .toLowerCase();
      for (final banned in [
        'commit',
        'test file',
        'unit and widget',
        'module',
        '47',
        '87',
      ]) {
        expect(text, isNot(contains(banned)), reason: banned);
      }
    });

    test('the project count equals what the Projects section lists', () {
      final projects = ProjectModel.getSampleProjects();
      expect(stats[2].value, '${projects.length}');
      // No trailing "+": the site cannot back "more than N".
      expect(stats[2].value, isNot(contains('+')));
    });

    test('"Production" is backed by company projects', () {
      expect(
        ProjectModel.getSampleProjects().any((p) => p.isCompanyProject),
        isTrue,
      );
    });

    test('the start year matches the earliest role', () {
      final earliest = ExperienceModel.getExperiences().last;
      expect(earliest.duration, contains('${AppConstants.flutterSince}'));
    });

    test('shows "<1" rather than overstating before a full year', () {
      final early = AboutStatsModel.getStats(now: DateTime(2026, 3, 1));
      expect(early[1].value, '<1');
    });
  });

  group('About copy', () {
    final paragraphs = AppConstants.aboutParagraphs;

    test('keeps the agreed positioning statement', () {
      expect(
        paragraphs.first,
        'I build production Flutter applications for mobile and web. My work '
        'spans video editing and media pipelines, real-time features, payments '
        'and third-party SDK integrations, structured with Clean Architecture '
        'and BLoC or Provider.',
      );
    });

    test('preserves the career progression in order', () {
      final journey = paragraphs[1];
      final brototype = journey.indexOf('Brototype');
      final dimension = journey.indexOf('DimensionLeap');
      final emilo = journey.indexOf('Emilo Ventures in Raipur');
      expect(brototype, isNonNegative);
      expect(dimension, greaterThan(brototype));
      expect(emilo, greaterThan(dimension));
      expect(journey, contains('2024'));
      expect(journey, contains('2025'));
    });

    test('avoids generic marketing language', () {
      final text = paragraphs.join(' ').toLowerCase();
      for (final w in [
        'passionate',
        'world-class',
        'cutting-edge',
        'rockstar',
        'guru',
        'ninja',
        'best-in-class',
      ]) {
        expect(text, isNot(contains(w)), reason: w);
      }
    });
  });
}
