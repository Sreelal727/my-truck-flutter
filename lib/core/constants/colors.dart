import 'dart:ui';

abstract final class MtColors {
  // Core - Uber-inspired dark palette
  static const black = Color(0xFF000000);
  static const background = Color(0xFF000000);
  static const surface = Color(0xFF1C1C1E);
  static const surfaceElevated = Color(0xFF2C2C2E);
  static const surfaceHighlight = Color(0xFF3A3A3C);

  // Brand
  static const primary = Color(0xFF0066FF);
  static const primaryLight = Color(0xFF3385FF);
  static const primaryDark = Color(0xFF0052CC);

  // Accents
  static const green = Color(0xFF06C167);
  static const greenLight = Color(0xFF08DD76);
  static const orange = Color(0xFFFF9500);
  static const red = Color(0xFFFF3B30);
  static const yellow = Color(0xFFFFD60A);

  // Text
  static const white = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF8E8E93);
  static const textTertiary = Color(0xFF98989D);
  static const textDisabled = Color(0xFF48484A);

  // Borders & Dividers
  static const border = Color(0xFF2C2C2E);
  static const divider = Color(0xFF1C1C1E);

  // Status
  static const statusActive = Color(0xFF06C167);
  static const statusPending = Color(0xFFFF9500);
  static const statusCancelled = Color(0xFFFF3B30);
  static const statusCompleted = Color(0xFF0066FF);

  // Overlay
  static const overlay = Color(0xB3000000); // 0.7 opacity
  static const overlayLight = Color(0x66000000); // 0.4 opacity
}
