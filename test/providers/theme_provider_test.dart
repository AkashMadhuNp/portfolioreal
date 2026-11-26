import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:port_folio/core/services/theme_store.dart';
import 'package:port_folio/presentation/providers/theme_provider.dart';

void main() {
  group('ThemeProvider', () {
    test('defaults to dark when nothing is saved', () {
      final provider = ThemeProvider(store: MemoryThemeStore());
      expect(provider.isDarkMode, isTrue);
      expect(provider.themeMode, ThemeMode.dark);
    });

    test('restores a saved light preference', () {
      final provider = ThemeProvider(store: MemoryThemeStore('light'));
      expect(provider.isDarkMode, isFalse);
      expect(provider.themeMode, ThemeMode.light);
    });

    test('restores a saved dark preference', () {
      expect(ThemeProvider(store: MemoryThemeStore('dark')).isDarkMode, isTrue);
    });

    test('ignores an unrecognised saved value', () {
      expect(
        ThemeProvider(store: MemoryThemeStore('purple')).isDarkMode,
        isTrue,
      );
    });

    test('toggling persists, so a "reload" keeps the choice', () {
      final store = MemoryThemeStore();
      final first = ThemeProvider(store: store);

      first.toggleTheme();
      expect(first.isDarkMode, isFalse);
      expect(store.read(), 'light');

      // A new provider over the same store simulates a page reload.
      final reloaded = ThemeProvider(store: store);
      expect(reloaded.isDarkMode, isFalse);

      reloaded.toggleTheme();
      expect(store.read(), 'dark');
      expect(ThemeProvider(store: store).isDarkMode, isTrue);
    });

    test('setting the current theme does not notify or write', () {
      final store = MemoryThemeStore();
      final provider = ThemeProvider(store: store);
      var notified = 0;
      provider.addListener(() => notified++);

      provider.setTheme(true); // already dark
      expect(notified, 0);
      expect(store.read(), isNull);

      provider.setTheme(false);
      expect(notified, 1);
      expect(store.read(), 'light');
    });

    test('works with no store at all', () {
      final provider = ThemeProvider();
      provider.toggleTheme();
      expect(provider.isDarkMode, isFalse);
    });
  });
}
