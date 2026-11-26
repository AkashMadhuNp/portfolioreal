import 'package:flutter/material.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/theme/app_tokens.dart';
import '../cursor_hover_region.dart';

enum AppButtonVariant {
  /// Brand CTA: gold fill, ink label.
  primary,

  /// Neutral outline; gold appears only on hover/focus.
  secondary,

  /// Text-only, for low-emphasis actions.
  ghost,
}

/// The one button used across the site. Keyboard accessible (Tab to focus,
/// Enter/Space to activate), with a visible focus ring and a 48px touch target.
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.loading = false,
    this.expand = false,
    this.compact = false,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool loading;
  final bool expand;
  final bool compact;
  final String? semanticLabel;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _hovered = false;
  bool _focused = false;

  bool get _enabled => widget.onPressed != null && !widget.loading;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final neutral = p.textTertiary.withValues(alpha: 0.55);

    late Color bg;
    late Color fg;
    late Color border;
    switch (widget.variant) {
      case AppButtonVariant.primary:
        bg = !_enabled ? p.subtle : (_hovered ? p.goldBright : p.gold);
        fg = !_enabled ? p.textTertiary : p.onGold;
        border = Colors.transparent;
      case AppButtonVariant.secondary:
        bg = _hovered && _enabled
            ? p.gold.withValues(alpha: 0.08)
            : Colors.transparent;
        fg = !_enabled ? p.textTertiary : p.textPrimary;
        border = _hovered && _enabled ? p.goldStrong : neutral;
      case AppButtonVariant.ghost:
        bg = _hovered && _enabled
            ? p.gold.withValues(alpha: 0.10)
            : Colors.transparent;
        fg = !_enabled ? p.textTertiary : p.accent;
        border = Colors.transparent;
    }

    final labelStyle = Theme.of(context).textTheme.labelLarge!.copyWith(
      color: fg,
      fontSize: widget.compact ? 13 : 15,
      fontWeight: FontWeight.w600,
    );

    final content = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.loading)
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2, color: fg),
          )
        else if (widget.icon != null)
          Icon(widget.icon, size: widget.compact ? 16 : 18, color: fg),
        if (widget.loading || widget.icon != null)
          const SizedBox(width: AppSpace.x1),
        Flexible(
          child: Text(
            widget.label,
            style: labelStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

    // Text-style buttons are pulled left by their own inset (padding + border +
    // focus ring) so the label lines up with the surrounding content edge while
    // the hover area stays generous.
    final ghost = widget.variant == AppButtonVariant.ghost;

    return Transform.translate(
      offset: Offset(ghost ? -(_ghostInset + 2 + 1.5) : 0, 0),
      child: _buildButton(context, content, bg, border, ghost),
    );
  }

  static const double _ghostInset = AppSpace.x1;

  Widget _buildButton(
    BuildContext context,
    Widget content,
    Color bg,
    Color border,
    bool ghost,
  ) {
    final p = context.palette;
    return Semantics(
      button: true,
      enabled: _enabled,
      label: widget.semanticLabel ?? widget.label,
      excludeSemantics: true,
      child: CursorHoverRegion(
        child: FocusableActionDetector(
          enabled: _enabled,
          mouseCursor: _enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.forbidden,
          onShowHoverHighlight: (v) => setState(() => _hovered = v),
          onShowFocusHighlight: (v) => setState(() => _focused = v),
          actions: {
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (_) {
                widget.onPressed?.call();
                return null;
              },
            ),
          },
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _enabled ? widget.onPressed : null,
            child: AnimatedContainer(
              duration: AppLayout.fast,
              curve: AppLayout.curve,
              // The ring sits outside the button so layout never shifts.
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.md + 2),
                border: Border.all(
                  color: _focused ? p.goldStrong : Colors.transparent,
                  width: 2,
                ),
              ),
              child: AnimatedContainer(
                duration: AppLayout.fast,
                curve: AppLayout.curve,
                constraints: BoxConstraints(
                  minHeight: widget.compact ? 40 : 48,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: ghost
                      ? _ghostInset
                      : (widget.compact ? AppSpace.x2 : AppSpace.x3),
                  vertical: AppSpace.x15 - 2,
                ),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: AppRadius.mdAll,
                  border: Border.all(color: border, width: 1.5),
                ),
                child: content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
