import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Mode-aware colour roles. The single place that decides which token a role
/// resolves to in light vs dark, so widgets never branch on brightness:
///
/// ```dart
/// final p = context.palette;
/// Text('Hello', style: TextStyle(color: p.accent));
/// ```
///
/// Gold roles (they differ because gold fails contrast on light surfaces):
///  * [accent]     – gold for **small text and icons**. Always ≥ 4.5:1.
///  * [goldStrong] – gold for **large text (≥ 24px), icons, borders**. ≥ 3:1.
///  * [gold]       – gold as a **fill or tint** behind [onGold] content.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.brightness,
    required this.background,
    required this.surface,
    required this.card,
    required this.cardAlt,
    required this.subtle,
    required this.border,
    required this.borderStrong,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.gold,
    required this.goldBright,
    required this.goldStrong,
    required this.accent,
    required this.onGold,
    required this.shadow,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  final Brightness brightness;

  // Surfaces
  final Color background; // page
  final Color surface; // alternate section band
  final Color card; // cards
  final Color cardAlt; // elevated surface (hover, popovers)
  final Color subtle; // tags, inputs resting on a card

  // Lines
  final Color border;
  final Color borderStrong; // emphasis / hover / focus

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;

  // Gold
  final Color gold;
  final Color goldBright;
  final Color goldStrong;
  final Color accent;
  final Color onGold;

  // Depth
  final Color shadow;

  // Semantic (each is safe as text on [card])
  final Color success;
  final Color warning;
  final Color error;
  final Color info;

  bool get isDark => brightness == Brightness.dark;

  /// Obsidian & Champagne Gold.
  static const AppPalette dark = AppPalette(
    brightness: Brightness.dark,
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    card: AppColors.darkCard,
    cardAlt: AppColors.darkCardAlt,
    subtle: AppColors.darkCardAlt,
    border: AppColors.darkBorder,
    borderStrong: Color(0x66D9B96C), // gold @ 40%
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    textTertiary: AppColors.darkTextTertiary,
    gold: AppColors.primary,
    goldBright: AppColors.primaryLight,
    goldStrong: AppColors.primary,
    accent: AppColors.primary, // 10.3:1 on obsidian
    onGold: AppColors.onGold,
    shadow: Color(0x99000000),
    success: AppColors.successDark,
    warning: AppColors.warningDark,
    error: AppColors.errorDark,
    info: AppColors.infoDark,
  );

  /// Warm off-white with deep gold.
  static const AppPalette light = AppPalette(
    brightness: Brightness.light,
    background: AppColors.lightBackground,
    surface: AppColors.lightSurface,
    card: AppColors.lightCard,
    cardAlt: AppColors.lightCardAlt,
    subtle: AppColors.lightSurface,
    border: AppColors.lightBorder,
    borderStrong: Color(0x73A87900), // primary gold @ 45%
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    textTertiary: AppColors.lightTextTertiary,
    gold: AppColors.lightGold,
    goldBright: AppColors.lightGoldBright,
    goldStrong: AppColors.lightGoldDeep,
    accent: AppColors.lightAccentText,
    onGold: AppColors.onGold,
    shadow: Color(0x14191919), // ink @ 8%: shadows only where needed
    success: AppColors.successLight,
    warning: AppColors.warningLight,
    error: AppColors.errorLight,
    info: AppColors.infoLight,
  );

  @override
  AppPalette copyWith({
    Brightness? brightness,
    Color? background,
    Color? surface,
    Color? card,
    Color? cardAlt,
    Color? subtle,
    Color? border,
    Color? borderStrong,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? gold,
    Color? goldBright,
    Color? goldStrong,
    Color? accent,
    Color? onGold,
    Color? shadow,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
  }) {
    return AppPalette(
      brightness: brightness ?? this.brightness,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      cardAlt: cardAlt ?? this.cardAlt,
      subtle: subtle ?? this.subtle,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      gold: gold ?? this.gold,
      goldBright: goldBright ?? this.goldBright,
      goldStrong: goldStrong ?? this.goldStrong,
      accent: accent ?? this.accent,
      onGold: onGold ?? this.onGold,
      shadow: shadow ?? this.shadow,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppPalette(
      brightness: t < 0.5 ? brightness : other.brightness,
      background: c(background, other.background),
      surface: c(surface, other.surface),
      card: c(card, other.card),
      cardAlt: c(cardAlt, other.cardAlt),
      subtle: c(subtle, other.subtle),
      border: c(border, other.border),
      borderStrong: c(borderStrong, other.borderStrong),
      textPrimary: c(textPrimary, other.textPrimary),
      textSecondary: c(textSecondary, other.textSecondary),
      textTertiary: c(textTertiary, other.textTertiary),
      gold: c(gold, other.gold),
      goldBright: c(goldBright, other.goldBright),
      goldStrong: c(goldStrong, other.goldStrong),
      accent: c(accent, other.accent),
      onGold: c(onGold, other.onGold),
      shadow: c(shadow, other.shadow),
      success: c(success, other.success),
      warning: c(warning, other.warning),
      error: c(error, other.error),
      info: c(info, other.info),
    );
  }
}

extension AppPaletteContext on BuildContext {
  /// The active palette. Falls back to the matching built-in palette when the
  /// widget tree was built without [AppTheme] (e.g. a bare test harness).
  AppPalette get palette {
    final theme = Theme.of(this);
    return theme.extension<AppPalette>() ??
        (theme.brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
  }
}
