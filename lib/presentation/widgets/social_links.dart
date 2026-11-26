import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_palette.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/utils/toast_helper.dart';
import '../../core/utils/url_helper.dart';
import 'cursor_hover_region.dart';

/// Icon links to profiles. Entries with no URL are skipped, so an unset
/// profile never renders as a dead button.
class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key, this.alignment = WrapAlignment.start});

  final WrapAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final links = <_Link>[
      const _Link('GitHub', FontAwesomeIcons.github, AppConstants.github),
      const _Link(
        'LinkedIn',
        FontAwesomeIcons.linkedinIn,
        AppConstants.linkedin,
      ),
    ].where((l) => l.url.isNotEmpty).toList();

    return Wrap(
      alignment: alignment,
      spacing: AppSpace.x15,
      runSpacing: AppSpace.x15,
      children: [for (final l in links) _SocialButton(link: l)],
    );
  }
}

class _Link {
  const _Link(this.label, this.icon, this.url);
  final String label;
  final IconData icon;
  final String url;
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({required this.link});

  final _Link link;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;
  bool _focused = false;

  Future<void> _open() async {
    try {
      await UrlHelper.launchURL(widget.link.url);
    } catch (_) {
      if (mounted) {
        ToastHelper.showErrorToast(
          context,
          'Could not open ${widget.link.label}.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final active = _hovered || _focused;

    return Tooltip(
      message: widget.link.label,
      child: Semantics(
        button: true,
        link: true,
        label: '${widget.link.label} profile',
        excludeSemantics: true,
        child: CursorHoverRegion(
          child: FocusableActionDetector(
            mouseCursor: SystemMouseCursors.click,
            onShowHoverHighlight: (v) => setState(() => _hovered = v),
            onShowFocusHighlight: (v) => setState(() => _focused = v),
            actions: {
              ActivateIntent: CallbackAction<ActivateIntent>(
                onInvoke: (_) {
                  _open();
                  return null;
                },
              ),
            },
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _open,
              child: AnimatedContainer(
                duration: AppLayout.fast,
                curve: AppLayout.curve,
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: active ? p.gold.withValues(alpha: 0.10) : p.card,
                  borderRadius: AppRadius.mdAll,
                  border: Border.all(
                    color: _focused
                        ? p.goldStrong
                        : (_hovered ? p.borderStrong : p.border),
                    width: _focused ? 2 : 1,
                  ),
                ),
                child: Center(
                  child: FaIcon(
                    widget.link.icon,
                    size: 18,
                    color: active ? p.accent : p.textSecondary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
