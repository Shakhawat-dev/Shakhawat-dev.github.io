import 'package:flutter/widgets.dart';

/// Central place for the responsive breakpoints used across every section
/// widget, so the mobile/tablet/desktop cutoffs stay consistent site-wide.
class Breakpoints {
  const Breakpoints._();

  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1400;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobile;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= mobile && w < tablet;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tablet;

  /// Clamp content to a comfortable reading width on very large screens.
  static double contentWidth(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w > desktop ? desktop : w;
  }
}
