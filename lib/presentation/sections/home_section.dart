import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_palette.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/utils/download_helper.dart';
import '../widgets/social_links.dart';
import '../widgets/ui/app_button.dart';

/// Hero: name, one-line positioning, CTAs and the portrait.
///
/// Wide screens place the portrait as a contained figure that dissolves into
/// the page (so its proportions are never cropped). Narrow screens keep the
/// text left-aligned with the portrait as a faint backdrop.
class HomeSection extends StatelessWidget {
  const HomeSection({super.key, required this.onViewProjects});

  final VoidCallback onViewProjects;

  static const _portrait = 'assets/images/profilerm.png';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final p = context.palette;
    final wide = size.width >= 900;
    final gutter = AppSpace.gutter(size.width);

    final available = size.height - AppLayout.navHeight;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: wide ? available.clamp(620.0, 860.0) : available,
      ),
      child: Stack(
        children: [
          if (!wide) _buildBackdrop(p),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: gutter),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppLayout.maxContentWidth,
                ),
                child: wide
                    ? _buildWide(context, p, available.clamp(620.0, 860.0))
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpace.x8,
                        ),
                        child: _buildText(context, p, compact: true),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWide(BuildContext context, AppPalette p, double height) {
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpace.x8),
              child: _buildText(context, p),
            ),
          ),
          const SizedBox(width: AppSpace.x4),
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FadeIn(
                duration: const Duration(milliseconds: 900),
                child: _FadedPortrait(height: height, image: _portrait),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Faint portrait behind the text on narrow screens.
  Widget _buildBackdrop(AppPalette p) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Opacity(
          opacity: p.isDark ? 0.2 : 0.24,
          child: _FadedPortrait(height: 520, image: _portrait),
        ),
      ),
    );
  }

  Widget _buildText(
    BuildContext context,
    AppPalette p, {
    bool compact = false,
  }) {
    final width = MediaQuery.of(context).size.width;
    final nameSize = width >= 1200
        ? 80.0
        : (width >= 900 ? 64.0 : (width >= 640 ? 60.0 : 44.0));
    final theme = Theme.of(context).textTheme;

    return FadeInUp(
      from: 16,
      duration: const Duration(milliseconds: 700),
      // Full width so the text block stays left-aligned instead of being
      // centred around its own intrinsic width by the parent.
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: AppSpace.x3, height: 2, color: p.goldStrong),
                const SizedBox(width: AppSpace.x15),
                Text('FLUTTER ENGINEER', style: AppType.eyebrow(context)),
              ],
            ),
            const SizedBox(height: AppSpace.x3),
            Semantics(
              header: true,
              // Stays on one line: scales down to the column instead of
              // wrapping the last initial onto its own line.
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  AppConstants.name,
                  maxLines: 1,
                  softWrap: false,
                  style: AppType.display(
                    context,
                    size: nameSize,
                    weight: FontWeight.w800,
                    height: 1.04,
                    letterSpacing: -2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpace.x3),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Text(
                AppConstants.headline,
                style: theme.headlineSmall?.copyWith(
                  color: p.textPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: compact ? 20 : 24,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: AppSpace.x2),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Text(AppConstants.bio, style: theme.bodyLarge),
            ),
            const SizedBox(height: AppSpace.x5),
            Wrap(
              spacing: AppSpace.x2,
              runSpacing: AppSpace.x2,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                AppButton(
                  label: 'Download CV',
                  icon: Icons.download_rounded,
                  onPressed: () => DownloadHelper.downloadCV(context),
                ),
                AppButton(
                  label: 'View projects',
                  icon: Icons.arrow_forward_rounded,
                  variant: AppButtonVariant.secondary,
                  onPressed: onViewProjects,
                ),
              ],
            ),
            const SizedBox(height: AppSpace.x4),
            const SocialLinks(),
          ],
        ),
      ),
    );
  }
}

/// Portrait that dissolves at its left and bottom edges so no hard rectangle
/// shows against either theme's background.
class _FadedPortrait extends StatelessWidget {
  const _FadedPortrait({required this.height, required this.image});

  final double height;
  final String image;

  @override
  Widget build(BuildContext context) {
    // Fades are gradient overlays in the page colour rather than alpha masks:
    // same look, but no offscreen layers, so it renders identically everywhere.
    final bg = context.palette.background;
    final clear = bg.withValues(alpha: 0);

    return Stack(
      children: [
        Image.asset(
          image,
          height: height,
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
          semanticLabel: '${AppConstants.name}, Flutter developer',
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [bg, clear],
                stops: const [0.0, 0.32],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [clear, bg],
                stops: const [0.78, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
