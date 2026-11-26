import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_palette.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_tokens.dart';
import '../providers/scroll_provider.dart';
import 'cursor_hover_region.dart';
import 'theme_toggle.dart';

/// A navigation target: a label and the key of the section it scrolls to.
class NavItem {
  const NavItem(this.label, this.key);

  final String label;
  final GlobalKey key;
}

/// Fixed top navigation: wordmark, section links with an active indicator,
/// and the theme toggle. Collapses to a menu sheet below 900px.
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.items});

  final List<NavItem> items;

  static const _collapseWidth = 900.0;

  /// Index of the section currently under the nav: the last section whose top
  /// has scrolled to within a short distance of the bar.
  int _activeIndex() {
    var active = 0;
    for (var i = 0; i < items.length; i++) {
      final ctx = items[i].key.currentContext;
      final box = ctx?.findRenderObject();
      if (box is! RenderBox || !box.attached) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      if (top <= AppLayout.navHeight + 160) active = i;
    }
    return active;
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final width = MediaQuery.of(context).size.width;
    final collapsed = width < _collapseWidth;
    final scroll = context.watch<ScrollProvider>();
    final active = _activeIndex();
    const toggle = ThemeToggle();

    return Material(
      color: p.background,
      child: Container(
        height: AppLayout.navHeight,
        padding: EdgeInsets.symmetric(horizontal: AppSpace.gutter(width)),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: p.border)),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppLayout.maxContentWidth,
            ),
            child: Row(
              children: [
                _Wordmark(onTap: () => scroll.scrollToTop()),
                const Spacer(),
                if (!collapsed)
                  for (var i = 0; i < items.length; i++)
                    _NavLink(
                      label: items[i].label,
                      selected: i == active,
                      onTap: () => scroll.scrollToSection(
                        items[i].key,
                        extraOffset: i == 0 ? 0 : AppSpace.x4,
                      ),
                    ),
                if (!collapsed) const SizedBox(width: AppSpace.x1),
                toggle,
                if (collapsed)
                  CursorHoverRegion(
                    child: IconButton(
                      tooltip: 'Open menu',
                      icon: const Icon(Icons.menu_rounded),
                      onPressed: () => _showMenu(context, active),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMenu(BuildContext context, int active) {
    final scroll = context.read<ScrollProvider>();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        final p = sheetContext.palette;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: AppSpace.x2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < items.length; i++)
                  ListTile(
                    selected: i == active,
                    selectedColor: p.accent,
                    selectedTileColor: p.gold.withValues(alpha: 0.08),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpace.x4,
                    ),
                    title: Text(
                      items[i].label,
                      style: Theme.of(sheetContext).textTheme.titleMedium
                          ?.copyWith(
                            color: i == active ? p.accent : p.textPrimary,
                          ),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      scroll.scrollToSection(
                        items[i].key,
                        extraOffset: i == 0 ? 0 : AppSpace.x4,
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Wordmark extends StatelessWidget {
  const _Wordmark({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Semantics(
      button: true,
      label: '${AppConstants.name}, back to top',
      excludeSemantics: true,
      child: CursorHoverRegion(
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.smAll,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.x1,
              vertical: AppSpace.x1,
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Akash Madhu',
                    style: AppType.display(
                      context,
                      size: 22,
                      letterSpacing: -0.3,
                    ),
                  ),
                  TextSpan(
                    text: '.',
                    style: AppType.display(
                      context,
                      size: 22,
                      color: p.goldStrong,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final emphasised = widget.selected || _hovered || _focused;

    return Semantics(
      button: true,
      selected: widget.selected,
      label: widget.label,
      excludeSemantics: true,
      child: CursorHoverRegion(
        child: FocusableActionDetector(
          mouseCursor: SystemMouseCursors.click,
          onShowHoverHighlight: (v) => setState(() => _hovered = v),
          onShowFocusHighlight: (v) => setState(() => _focused = v),
          actions: {
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (_) {
                widget.onTap();
                return null;
              },
            ),
          },
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: AppLayout.fast,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpace.x15,
                vertical: AppSpace.x1,
              ),
              decoration: BoxDecoration(
                borderRadius: AppRadius.smAll,
                border: Border.all(
                  color: _focused ? p.goldStrong : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: emphasised ? p.textPrimary : p.textSecondary,
                      fontWeight: widget.selected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedContainer(
                    duration: AppLayout.fast,
                    height: 2,
                    width: widget.selected ? 16 : 0,
                    color: p.goldStrong,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
