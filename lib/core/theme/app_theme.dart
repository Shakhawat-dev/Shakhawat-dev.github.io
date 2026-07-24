import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Builds the light and dark [ThemeData] for the app. Typography uses
/// Google Fonts' Inter/Poppins pairing so the site never depends on
/// bundling font asset files.
class AppTheme {
  const AppTheme._();

  static ThemeData dark() => _build(Brightness.dark);
  static ThemeData light() => _build(Brightness.light);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: brightness,
      secondary: AppColors.accent,
    ).copyWith(
      surface: isDark ? AppColors.darkSurface : AppColors.lightSurface,
    );

    final baseTextTheme = GoogleFonts.interTextTheme(
      isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
    );
    final headlineFont = GoogleFonts.poppinsTextTheme(baseTextTheme);

    final textTheme = baseTextTheme.copyWith(
      displayLarge: headlineFont.displayLarge?.copyWith(fontWeight: FontWeight.w700),
      displayMedium: headlineFont.displayMedium?.copyWith(fontWeight: FontWeight.w700),
      displaySmall: headlineFont.displaySmall?.copyWith(fontWeight: FontWeight.w600),
      headlineLarge: headlineFont.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
      headlineMedium: headlineFont.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
      headlineSmall: headlineFont.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
      titleLarge: headlineFont.titleLarge?.copyWith(fontWeight: FontWeight.w600),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      textTheme: textTheme,
      dividerColor: colorScheme.outlineVariant.withValues(alpha: 0.4),
      splashFactory: InkRipple.splashFactory,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
          TargetPlatform.linux: ZoomPageTransitionsBuilder(),
          TargetPlatform.windows: ZoomPageTransitionsBuilder(),
        },
      ),
      chipTheme: ChipThemeData(
        backgroundColor:
            isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
        labelStyle: textTheme.labelLarge,
        side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      cardTheme: CardThemeData(
        color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.25)),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: textTheme.bodySmall,
      ),
    );
  }
}
