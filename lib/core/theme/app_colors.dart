import 'package:flutter/material.dart';

/// Raw colour tokens. Widgets must not read these for anything that changes
/// between light and dark; use `context.palette` ([AppPalette]) instead.
///
/// Identity: black and gold. Dark is **Obsidian & Champagne Gold**; light is a
/// warm off-white with deep gold, designed independently (not inverted):
/// white cards, neutral borders, and gold reserved for emphasis.
class AppColors {
  AppColors._();

  // ── Dark: obsidian + champagne gold ───────────────────────────────────────
  static const Color darkBackground = Color(0xFF0C0C0F);
  static const Color darkSurface = Color(0xFF131317);
  static const Color darkCard = Color(0xFF1A1A1F);
  static const Color darkCardAlt = Color(0xFF222228);
  static const Color darkBorder = Color(0xFF2C2C34);

  static const Color darkTextPrimary = Color(0xFFF4F0E6); // 17.2:1 on bg
  static const Color darkTextSecondary = Color(0xFFCBC5B6); // 11.4:1
  static const Color darkTextTertiary = Color(0xFF9A9484); // 6.5:1

  static const Color primary = Color(0xFFD9B96C); // gold
  static const Color primaryLight = Color(0xFFEBD08F); // highlight
  static const Color primaryDark = Color(0xFFA8823A); // deep gold
  static const Color accent = Color(0xFFE8D5AE); // champagne
  static const Color accentLight = Color(0xFFF3E6C8);

  // ── Light: warm off-white + deep gold ─────────────────────────────────────
  static const Color lightBackground = Color(0xFFF7F6F2);
  static const Color lightSurface = Color(0xFFF0EFE9); // secondary background
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardAlt = Color(0xFFFAFAF8); // elevated surface
  static const Color lightBorder = Color(0xFFE5E2D9);

  static const Color lightTextPrimary = Color(0xFF191919); // 16.3:1 on bg
  static const Color lightTextSecondary = Color(0xFF626262); // 5.6:1
  static const Color lightTextTertiary = Color(0xFF6B6B6B); // 4.6:1 on bg2

  /// Primary gold. 3.4–3.9:1 on the light surfaces, so it is for large display
  /// text, icons, borders and emphasis; never for small body text.
  static const Color lightGoldDeep = Color(0xFFA87900);

  /// Accent gold: fills and tints.
  static const Color lightGold = Color(0xFFC69B22);
  static const Color lightGoldBright = Color(0xFFDDB84A);

  /// Gold for SMALL text and icons on light surfaces (≥ 4.5:1 on all of them).
  /// A touch deeper than [lightGoldDeep], which fails AA below 24px.
  static const Color lightAccentText = Color(0xFF8F6500);

  /// Text/icon colour on any gold fill (6.8:1 on [lightGold], 10:1 on dark gold).
  static const Color onGold = Color(0xFF14110A);

  // ── Semantic colours, tuned per mode so each clears 4.5:1 as text ─────────
  static const Color successDark = Color(0xFF4FC48A);
  static const Color warningDark = Color(0xFFF0A04B);
  static const Color errorDark = Color(0xFFF2766E);
  static const Color infoDark = Color(0xFF6FB3F2);

  static const Color successLight = Color(0xFF1F7A4D);
  static const Color warningLight = Color(0xFF9A5B00);
  static const Color errorLight = Color(0xFFB3261E);
  static const Color infoLight = Color(0xFF1F5FA8);

  /// Solid error fill that carries white text at ≥ 6:1 (toasts float over
  /// arbitrary backgrounds).
  static const Color errorStrong = Color(0xFFB3261E);
}
