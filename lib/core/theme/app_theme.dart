import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_palette.dart';
import 'app_tokens.dart';

/// Builds both themes from [AppPalette] so light and dark are structurally
/// identical and only differ by token values.
class AppTheme {
  AppTheme._();

  static ThemeData lightTheme() => _build(AppPalette.light);
  static ThemeData darkTheme() => _build(AppPalette.dark);

  static ThemeData _build(AppPalette p) {
    final isDark = p.isDark;

    final scheme = ColorScheme(
      brightness: p.brightness,
      primary: p.accent,
      onPrimary: isDark ? p.onGold : Colors.white,
      primaryContainer: p.gold,
      onPrimaryContainer: p.onGold,
      secondary: p.goldStrong,
      onSecondary: p.onGold,
      error: p.error,
      onError: isDark ? p.onGold : Colors.white,
      surface: p.surface,
      onSurface: p.textPrimary,
      onSurfaceVariant: p.textSecondary,
      surfaceContainerLowest: p.background,
      surfaceContainerLow: p.surface,
      surfaceContainer: p.card,
      surfaceContainerHigh: p.cardAlt,
      surfaceContainerHighest: p.subtle,
      outline: p.borderStrong,
      outlineVariant: p.border,
      shadow: Colors.black,
      scrim: Colors.black,
      // Material 3 tints elevated surfaces with the primary colour; that turns
      // gold cards muddy. Depth comes from border and (light only) shadow.
      surfaceTint: Colors.transparent,
    );

    final textTheme = _textTheme(p);
    final inputRadius = BorderRadius.circular(AppRadius.md);
    final neutralStrong = p.textTertiary.withValues(alpha: 0.55);

    OutlineInputBorder inputBorder(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: p.brightness,
      colorScheme: scheme,
      primaryColor: scheme.primary,
      scaffoldBackgroundColor: p.background,
      canvasColor: p.background,
      cardColor: p.card,
      dividerColor: p.border,
      dividerTheme: DividerThemeData(color: p.border, thickness: 1, space: 1),
      textTheme: textTheme,
      iconTheme: IconThemeData(color: p.textSecondary),
      extensions: <ThemeExtension<dynamic>>[p],

      splashColor: p.gold.withValues(alpha: 0.10),
      highlightColor: p.gold.withValues(alpha: 0.05),
      hoverColor: p.gold.withValues(alpha: 0.07),
      focusColor: p.gold.withValues(alpha: 0.16),

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: p.accent,
        selectionColor: p.gold.withValues(alpha: 0.30),
        selectionHandleColor: p.accent,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: p.background,
        surfaceTintColor: Colors.transparent,
        foregroundColor: p.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),

      cardTheme: CardThemeData(
        color: p.card,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: p.shadow,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.lgAll,
          side: BorderSide(color: p.border),
        ),
      ),

      // Primary action: gold fill + ink text in both modes (one brand CTA).
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: p.gold,
          foregroundColor: p.onGold,
          disabledBackgroundColor: p.subtle,
          disabledForegroundColor: p.textTertiary,
          elevation: 0,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.x4,
            vertical: AppSpace.x2,
          ),
          shape: RoundedRectangleBorder(borderRadius: inputRadius),
          textStyle: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Secondary: neutral border, so gold stays reserved for emphasis.
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: p.textPrimary,
          disabledForegroundColor: p.textTertiary,
          side: BorderSide(color: neutralStrong),
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.x4,
            vertical: AppSpace.x2,
          ),
          shape: RoundedRectangleBorder(borderRadius: inputRadius),
          textStyle: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: p.accent,
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: p.textPrimary,
          hoverColor: p.gold.withValues(alpha: 0.12),
          highlightColor: p.gold.withValues(alpha: 0.18),
          minimumSize: const Size(48, 48),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: p.gold,
        foregroundColor: p.onGold,
        elevation: isDark ? 0 : 2,
        hoverElevation: isDark ? 0 : 4,
        focusElevation: isDark ? 0 : 4,
        shape: const CircleBorder(),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? p.surface : p.cardAlt,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpace.x2,
          vertical: AppSpace.x2,
        ),
        border: inputBorder(p.border),
        enabledBorder: inputBorder(p.border),
        focusedBorder: inputBorder(p.goldStrong, 2),
        errorBorder: inputBorder(p.error, 1.5),
        focusedErrorBorder: inputBorder(p.error, 2),
        hintStyle: GoogleFonts.poppins(color: p.textTertiary, fontSize: 14),
        labelStyle: GoogleFonts.poppins(color: p.textSecondary, fontSize: 14),
        floatingLabelStyle: GoogleFonts.poppins(
          color: p.accent,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        errorStyle: GoogleFonts.poppins(color: p.error, fontSize: 12),
        helperStyle: GoogleFonts.poppins(color: p.textTertiary, fontSize: 12),
        counterStyle: GoogleFonts.poppins(color: p.textTertiary, fontSize: 12),
        prefixIconColor: p.textTertiary,
        suffixIconColor: p.textTertiary,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: p.accent,
        linearTrackColor: p.subtle,
        circularTrackColor: p.subtle,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: p.surface,
        modalBackgroundColor: p.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: p.border,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: p.card,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: p.border),
        ),
      ),

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: p.textPrimary,
          borderRadius: AppRadius.smAll,
        ),
        textStyle: GoogleFonts.poppins(color: p.background, fontSize: 12),
      ),

      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(p.gold.withValues(alpha: 0.55)),
        thickness: const WidgetStatePropertyAll(6),
        radius: const Radius.circular(3),
      ),
    );
  }

  /// Hierarchy by colour: headings use the primary text colour, running copy
  /// the secondary one (still ≥ 5.6:1), so pages scan without relying on size.
  static TextTheme _textTheme(AppPalette p) {
    TextStyle s(
      double size,
      FontWeight weight,
      Color color, [
      double height = 1.4,
    ]) => GoogleFonts.poppins(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );

    return TextTheme(
      displayLarge: s(57, FontWeight.bold, p.textPrimary, 1.15),
      displayMedium: s(45, FontWeight.bold, p.textPrimary, 1.15),
      displaySmall: s(36, FontWeight.bold, p.textPrimary, 1.2),
      headlineLarge: s(32, FontWeight.w600, p.textPrimary, 1.25),
      headlineMedium: s(28, FontWeight.w600, p.textPrimary, 1.3),
      headlineSmall: s(24, FontWeight.w600, p.textPrimary, 1.3),
      titleLarge: s(20, FontWeight.w600, p.textPrimary),
      titleMedium: s(16, FontWeight.w600, p.textPrimary),
      titleSmall: s(14, FontWeight.w600, p.textPrimary),
      bodyLarge: s(16, FontWeight.normal, p.textSecondary, 1.7),
      bodyMedium: s(14, FontWeight.normal, p.textSecondary, 1.65),
      bodySmall: s(12, FontWeight.normal, p.textSecondary, 1.6),
      labelLarge: s(14, FontWeight.w600, p.textPrimary, 1.3),
      labelMedium: s(12, FontWeight.w600, p.textPrimary, 1.3),
      labelSmall: s(11, FontWeight.w600, p.textSecondary, 1.3),
    );
  }
}

/// Display typography: Playfair Display for editorial headings, Poppins
/// (the theme text) for everything else.
class AppType {
  AppType._();

  static TextStyle display(
    BuildContext context, {
    required double size,
    FontWeight weight = FontWeight.w700,
    Color? color,
    double height = 1.12,
    double letterSpacing = -0.5,
    List<FontFeature>? fontFeatures,
  }) {
    return GoogleFonts.playfairDisplay(
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: letterSpacing,
      color: color ?? context.palette.textPrimary,
      fontFeatures: fontFeatures,
    );
  }

  /// Lining (full-height) figures. Playfair's default figures are old-style,
  /// where "4" and "1" shrink and drop below the baseline; that suits running
  /// text but makes standalone numbers look uneven.
  static const List<FontFeature> liningFigures = [FontFeature.liningFigures()];

  /// Small uppercase label that precedes headings ("01 · About").
  static TextStyle eyebrow(BuildContext context) {
    return GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 2.4,
      color: context.palette.accent,
    );
  }
}
