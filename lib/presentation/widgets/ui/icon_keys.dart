import 'package:flutter/material.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/theme/app_tokens.dart';

/// Maps the plain-string icon keys used by pure-Dart data models to icons.
IconData iconForKey(String key) {
  switch (key) {
    // Skill categories
    case 'mobile':
      return Icons.smartphone_rounded;
    case 'state':
      return Icons.hub_outlined;
    case 'architecture':
      return Icons.account_tree_outlined;
    case 'backend':
      return Icons.storage_rounded;
    case 'media':
      return Icons.movie_filter_outlined;
    case 'tools':
      return Icons.handyman_outlined;
    // Engineering highlights
    case 'editor':
      return Icons.video_library_outlined;
    case 'export':
      return Icons.file_upload_outlined;
    case 'sync':
      return Icons.sync_alt_rounded;
    case 'playback':
      return Icons.play_circle_outline_rounded;
    case 'debug':
      return Icons.bug_report_outlined;
    default:
      return Icons.code_rounded;
  }
}

/// The rounded icon tile used at the top of skill and engineering cards.
class IconTile extends StatelessWidget {
  const IconTile(this.iconKey, {super.key});

  final String iconKey;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: p.gold.withValues(alpha: p.isDark ? 0.12 : 0.14),
        borderRadius: AppRadius.mdAll,
      ),
      child: Icon(iconForKey(iconKey), size: 22, color: p.accent),
    );
  }
}
