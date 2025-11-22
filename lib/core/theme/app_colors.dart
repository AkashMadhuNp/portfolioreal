import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Luxury Gold
  static const Color primary = Color(0xFFD4AF37); // Classic gold
  static const Color primaryDark = Color(0xFFB8941E); // Dark gold
  static const Color primaryLight = Color(0xFFFFD700); // Bright gold

  // Accent Colors - Rose Gold
  static const Color accent = Color(0xFFE6C089); // Champagne gold
  static const Color accentLight = Color(0xFFFFC857); // Light gold

  // Background Colors - Light Theme
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFF8F9FA);
  static const Color lightCard = Color(0xFFFFFFFF);

  // Background Colors - Dark Theme (Extreme Black with Gold)
  static const Color darkBackground = Color(0xFF000000); // Pure black
  static const Color darkSurface = Color(0xFF0A0A0A); // Near black
  static const Color darkCard = Color(0xFF121212); // Deep black

  // Text Colors - Light Theme
  static const Color lightTextPrimary = Color(0xFF2D3748);
  static const Color lightTextSecondary = Color(0xFF718096);
  static const Color lightTextTertiary = Color(0xFFA0AEC0);

  // Text Colors - Dark Theme
  static const Color darkTextPrimary = Color(0xFFF7FAFC);
  static const Color darkTextSecondary = Color(0xFFE2E8F0);
  static const Color darkTextTertiary = Color(0xFFCBD5E0);

  // Semantic Colors
  static const Color success = Color(0xFF48BB78);
  static const Color warning = Color(0xFFED8936);
  static const Color error = Color(0xFFF56565);
  static const Color info = Color(0xFF4299E1);

  // Gradient Colors - Gold Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFFFD700)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFE6C089), Color(0xFFFFC857)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFE6C089), Color(0xFFFFD700)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Additional luxury gradients
  static const LinearGradient luxuryGradient = LinearGradient(
    colors: [Color(0xFFFFD700), Color(0xFFD4AF37), Color(0xFFB8941E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow Colors
  static Color lightShadow = Colors.black.withOpacity(0.08);
  static Color darkShadow = Colors.black.withOpacity(0.3);

  // Border Colors
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color darkBorder = Color(0xFF2D3748);
}

