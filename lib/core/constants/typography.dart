import 'package:flutter/material.dart';
import 'colors.dart';

abstract final class MtTypography {
  // Headings
  static const h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
    letterSpacing: -0.5,
    color: MtColors.white,
  );

  static const h2 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 32 / 26,
    letterSpacing: -0.3,
    color: MtColors.white,
  );

  static const h3 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 28 / 22,
    color: MtColors.white,
  );

  static const h4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
    color: MtColors.white,
  );

  // Body
  static const bodyLarge = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 24 / 17,
    color: MtColors.white,
  );

  static const body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 22 / 15,
    color: MtColors.white,
  );

  static const bodySmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 18 / 13,
    color: MtColors.white,
  );

  // Labels
  static const label = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 20 / 15,
    color: MtColors.white,
  );

  static const labelSmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 18 / 13,
    color: MtColors.white,
  );

  static const labelTiny = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 14 / 11,
    letterSpacing: 0.5,
    color: MtColors.white,
  );

  // Caption
  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    color: MtColors.white,
  );
}
