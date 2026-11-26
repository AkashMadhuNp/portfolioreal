import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;
import 'theme_store.dart';

/// Persists the theme in the browser's localStorage under `theme_mode`.
///
/// web/index.html reads the same key before Flutter boots so the splash screen
/// is painted in the right theme. Every access is guarded: storage can be
/// unavailable (private browsing, blocked cookies) and must never break the app.
class LocalStorageThemeStore implements ThemeStore {
  static const key = 'theme_mode';

  @override
  String? read() {
    try {
      return web.window.localStorage.getItem(key);
    } catch (e) {
      debugPrint('Theme preference unreadable: $e');
      return null;
    }
  }

  @override
  void write(String value) {
    try {
      web.window.localStorage.setItem(key, value);
    } catch (e) {
      debugPrint('Theme preference not saved: $e');
    }
  }
}

ThemeStore createThemeStore() => LocalStorageThemeStore();
