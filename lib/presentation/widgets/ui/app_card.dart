import 'package:flutter/material.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/theme/app_tokens.dart';
import '../cursor_hover_region.dart';

/// The one card surface used across the site: card colour, neutral hairline
/// border, no glow. Gold appears only when [featured] or while hovered, and a
/// soft shadow is used in light mode only (on dark it would be invisible).
///
/// When [onTap] is set the card is a keyboard-focusable button. Set [hoverable]
/// for a card that reacts to the pointer (a small lift and border tint) without
/// being a button: it adds no focus stop and no button semantics.
class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpace.x3),
    this.onTap,
    this.featured = false,
    this.hoverable = false,
    this.hoverBorderColor,
    this.semanticLabel,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool featured;

  /// Lift and tint on hover without becoming interactive.
  final bool hoverable;

  /// Border colour while hovered. Defaults to the palette's gold-tinted
  /// emphasis border; pass a fainter one for a more understated card.
  final Color? hoverBorderColor;
  final String? semanticLabel;
  final Color? color;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _hovered = false;
  bool _focused = false;

  bool get _interactive => widget.onTap != null;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final reactive = _interactive || widget.hoverable;
    final lifted = reactive && (_hovered || _focused);
    final emphasis = widget.hoverBorderColor ?? p.borderStrong;

    final borderColor = _focused
        ? p.goldStrong
        : (widget.featured ? p.borderStrong : (lifted ? emphasis : p.border));

    final card = AnimatedContainer(
      duration: AppLayout.fast,
      curve: AppLayout.curve,
      transform: Matrix4.translationValues(0, lifted ? -2 : 0, 0),
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.color ?? p.card,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: borderColor, width: _focused ? 2 : 1),
        // Shadow only while lifted (light mode): resting cards rely on the
        // hairline border alone.
        boxShadow: (p.isDark || !lifted)
            ? null
            : [
                BoxShadow(
                  color: p.shadow,
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: widget.child,
    );

    if (!_interactive) {
      if (!widget.hoverable) return card;
      return MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: card,
      );
    }

    return Semantics(
      button: true,
      label: widget.semanticLabel,
      child: CursorHoverRegion(
        child: FocusableActionDetector(
          mouseCursor: SystemMouseCursors.click,
          onShowHoverHighlight: (v) => setState(() => _hovered = v),
          onShowFocusHighlight: (v) => setState(() => _focused = v),
          actions: {
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (_) {
                widget.onTap?.call();
                return null;
              },
            ),
          },
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onTap,
            child: card,
          ),
        ),
      ),
    );
  }
}
