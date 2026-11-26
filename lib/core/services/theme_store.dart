/// Where the selected theme is remembered between visits.
abstract class ThemeStore {
  /// The saved value ('light' or 'dark'), or null if nothing is saved.
  String? read();

  void write(String value);
}

/// In-memory store: used off-web and in tests.
class MemoryThemeStore implements ThemeStore {
  MemoryThemeStore([this._value]);

  String? _value;

  @override
  String? read() => _value;

  @override
  void write(String value) => _value = value;
}
