import '../../core/constants/app_constants.dart';
import 'project_model.dart';

/// One headline figure in the About section.
class AboutStat {
  final String value;
  final String label;

  const AboutStat({required this.value, required this.label});
}

/// The About statistics. Each describes the professional journey, and each is
/// derived from data the rest of the site already shows, so none can drift:
///
///  * the start year  ← [AppConstants.flutterSince]
///  * years worked    ← [AppConstants.professionalSinceYear]/[…Month]
///  * featured count  ← [ProjectModel] (exactly what the Projects section lists)
///  * "Production"    ← company projects exist in [ProjectModel]
///
/// Repository activity (commit counts, test-file counts) is intentionally not
/// shown: it changes constantly and says little about experience.
class AboutStatsModel {
  /// Whole years of professional experience as of [now].
  static int professionalYears(DateTime now) {
    final months =
        (now.year - AppConstants.professionalSinceYear) * 12 +
        (now.month - AppConstants.professionalSinceMonth);
    return months < 0 ? 0 : months ~/ 12;
  }

  static List<AboutStat> getStats({DateTime? now}) {
    final years = professionalYears(now ?? DateTime.now());
    final projects = ProjectModel.getSampleProjects();

    return [
      const AboutStat(
        value: '${AppConstants.flutterSince}',
        label: 'Flutter development journey started',
      ),
      AboutStat(
        // "1+" once a full year is completed; honest "<1" before that.
        value: years >= 1 ? '$years+' : '<1',
        label: 'Years of professional experience',
      ),
      // The exact count shown in Projects. A trailing "+" would claim more
      // projects than the site can back.
      AboutStat(value: '${projects.length}', label: 'Featured projects'),
      const AboutStat(
        value: 'Production',
        label: 'Application development experience',
      ),
    ];
  }
}
