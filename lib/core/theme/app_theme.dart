import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';
import '../constants/spacing.dart';
import '../constants/typography.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: MtColors.background,
      colorScheme: const ColorScheme.dark(
        primary: MtColors.primary,
        onPrimary: MtColors.white,
        secondary: MtColors.green,
        surface: MtColors.surface,
        onSurface: MtColors.white,
        error: MtColors.red,
        outline: MtColors.border,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: MtColors.background,
        foregroundColor: MtColors.white,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: MtTypography.h3,
      ),
      cardTheme: CardThemeData(
        color: MtColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MtBorderRadius.lg),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: MtColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MtBorderRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MtBorderRadius.md),
          borderSide: const BorderSide(color: MtColors.white, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MtBorderRadius.md),
          borderSide: const BorderSide(color: MtColors.red, width: 1.5),
        ),
        hintStyle: MtTypography.body.copyWith(color: MtColors.textTertiary),
        labelStyle: MtTypography.labelSmall.copyWith(color: MtColors.textSecondary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: MtSpacing.lg,
          vertical: MtSpacing.md,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MtColors.white,
          foregroundColor: MtColors.black,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MtBorderRadius.md),
          ),
          textStyle: MtTypography.label.copyWith(fontSize: 17),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MtColors.white,
          minimumSize: const Size(double.infinity, 52),
          side: const BorderSide(color: MtColors.white, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MtBorderRadius.md),
          ),
          textStyle: MtTypography.label.copyWith(fontSize: 17),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MtColors.white,
          textStyle: MtTypography.label,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: MtColors.surface,
        selectedItemColor: MtColors.white,
        unselectedItemColor: MtColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: MtColors.border,
        thickness: 0.5,
        space: 0,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: MtColors.white,
        unselectedLabelColor: MtColors.textTertiary,
        indicatorColor: MtColors.white,
        labelStyle: MtTypography.label,
        unselectedLabelStyle: MtTypography.body,
        dividerColor: Colors.transparent,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return MtColors.green;
          return MtColors.textTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return MtColors.green.withValues(alpha: 0.25);
          }
          return MtColors.surfaceHighlight;
        }),
      ),
    );
  }
}
