import 'package:flutter/widgets.dart';

/// Spacing on an 8px grid. Use these instead of ad-hoc numbers so rhythm stays
/// consistent from the hero to the footer.
class AppSpace {
  AppSpace._();

  static const double x05 = 4;
  static const double x1 = 8;
  static const double x15 = 12;
  static const double x2 = 16;
  static const double x3 = 24;
  static const double x4 = 32;
  static const double x5 = 40;
  static const double x6 = 48;
  static const double x8 = 64;
  static const double x10 = 80;
  static const double x12 = 96;

  /// Vertical padding of a page section.
  static double section(double width) => width < Breakpoints.mobile
      ? x8
      : (width < Breakpoints.tablet ? x10 : x12);

  /// Horizontal page gutter.
  static double gutter(double width) =>
      width < Breakpoints.mobile ? x2 : (width < Breakpoints.tablet ? x4 : x8);
}

class AppRadius {
  AppRadius._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;

  static BorderRadius get smAll => BorderRadius.circular(sm);
  static BorderRadius get mdAll => BorderRadius.circular(md);
  static BorderRadius get lgAll => BorderRadius.circular(lg);
}

class Breakpoints {
  Breakpoints._();

  static const double mobile = 640;
  static const double tablet = 1024;
}

class AppLayout {
  AppLayout._();

  /// Maximum width of page content (keeps 1920px screens from stretching).
  static const double maxContentWidth = 1200;

  /// Height of the fixed top navigation.
  static const double navHeight = 72;

  /// Duration for theme and hover transitions.
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration theme = Duration(milliseconds: 350);
  static const Curve curve = Curves.easeOutCubic;
}
