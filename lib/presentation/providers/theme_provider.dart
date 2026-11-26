import 'package:flutter/material.dart';
import '../../core/services/theme_store.dart';

/// Holds the selected theme and remembers it across reloads.
///
/// Dark is the default (the brand's primary look) until the visitor chooses.
/// The choice is stored through a [ThemeStore]; on web that is localStorage,
/// which web/index.html also reads to paint the splash screen in the right
/// theme before Flutter boots.
class ThemeProvider extends ChangeNotifier {
  ThemeProvider({ThemeStore? store}) : this._(store ?? MemoryThemeStore());

  ThemeProvider._(this._store) : _isDarkMode = _store.read() != 'light';

  final ThemeStore _store;
  bool _isDarkMode;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() => setTheme(!_isDarkMode);

  void setTheme(bool isDark) {
    if (isDark == _isDarkMode) return;
    _isDarkMode = isDark;
    notifyListeners();
    _store.write(isDark ? 'dark' : 'light');
  }
}
