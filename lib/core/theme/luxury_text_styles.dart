import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Luxury text styles for premium black & gold theme
class LuxuryTextStyles {
  // Display styles - Ultra premium for hero section
  static TextStyle displayLarge(BuildContext context, {Color? color}) {
    return GoogleFonts.playfairDisplay(
      fontSize: 72,
      fontWeight: FontWeight.w900,
      color: color ?? AppColors.primaryLight,
      letterSpacing: -2,
      height: 1.1,
    );
  }

  static TextStyle displayMedium(BuildContext context, {Color? color}) {
    return GoogleFonts.playfairDisplay(
      fontSize: 56,
      fontWeight: FontWeight.w800,
      color: color ?? AppColors.primary,
      letterSpacing: -1.5,
      height: 1.2,
    );
  }

  // Headline styles - For section titles
  static TextStyle headlineLarge(BuildContext context, {Color? color}) {
    return GoogleFonts.montserrat(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      color: color ?? AppColors.primaryLight,
      letterSpacing: -1,
      height: 1.2,
    );
  }

  static TextStyle headlineMedium(BuildContext context, {Color? color}) {
    return GoogleFonts.montserrat(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: color ?? AppColors.primary,
      letterSpacing: -0.5,
      height: 1.3,
    );
  }

  // Title styles - For cards and components
  static TextStyle titleLarge(BuildContext context, {Color? color}) {
    return GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors.darkTextPrimary,
      letterSpacing: 0,
      height: 1.4,
    );
  }

  static TextStyle titleMedium(BuildContext context, {Color? color}) {
    return GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors.darkTextSecondary,
      letterSpacing: 0.15,
      height: 1.4,
    );
  }

  // Body styles - For content
  static TextStyle bodyLarge(BuildContext context, {Color? color}) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.darkTextSecondary,
      letterSpacing: 0.5,
      height: 1.8,
    );
  }

  static TextStyle bodyMedium(BuildContext context, {Color? color}) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.darkTextTertiary,
      letterSpacing: 0.25,
      height: 1.6,
    );
  }

  // Label styles - For buttons and small text
  static TextStyle labelLarge(BuildContext context, {Color? color}) {
    return GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: color ?? Colors.white,
      letterSpacing: 1.2,
      height: 1.2,
    );
  }

  // Special luxury accent style
  static TextStyle luxuryAccent(BuildContext context, {Color? color}) {
    return GoogleFonts.playfairDisplay(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors.primaryLight,
      fontStyle: FontStyle.italic,
      letterSpacing: 0.5,
    );
  }
}

