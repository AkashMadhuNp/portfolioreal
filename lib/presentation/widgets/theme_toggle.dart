import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_tokens.dart';
import '../providers/theme_provider.dart';
import 'cursor_hover_region.dart';

/// Light/dark switch. The choice is persisted by [ThemeProvider].
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final dark = theme.isDarkMode;

    return CursorHoverRegion(
      child: IconButton(
        tooltip: dark ? 'Switch to light theme' : 'Switch to dark theme',
        onPressed: theme.toggleTheme,
        icon: AnimatedSwitcher(
          duration: AppLayout.fast,
          transitionBuilder: (child, anim) =>
              FadeTransition(opacity: anim, child: child),
          child: Icon(
            dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            key: ValueKey(dark),
          ),
        ),
      ),
    );
  }
}
