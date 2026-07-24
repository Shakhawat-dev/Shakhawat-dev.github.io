import 'package:flutter/material.dart';

/// Brand palette for the portfolio. Kept separate from [ThemeData] so any
/// section widget can reach for a specific accent without threading it
/// through the whole theme extension mechanism.
class AppColors {
  const AppColors._();

  // A cool indigo/cyan pairing reads as "engineering / iOS" without
  // leaning on Apple's own blue.
  static const Color seed = Color(0xFF5B6CFF);
  static const Color accent = Color(0xFF20C4C8);

  static const Color darkBackground = Color(0xFF0B0E14);
  static const Color darkSurface = Color(0xFF12161F);
  static const Color darkSurfaceAlt = Color(0xFF1A1F2C);

  static const Color lightBackground = Color(0xFFF7F8FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceAlt = Color(0xFFEFF1F8);
}
