import 'package:flutter/material.dart';

abstract final class MtShadows {
  static const sm = [
    BoxShadow(
      color: Color(0x4D000000),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  static const md = [
    BoxShadow(
      color: Color(0x66000000),
      offset: Offset(0, 2),
      blurRadius: 6,
    ),
  ];

  static const lg = [
    BoxShadow(
      color: Color(0x80000000),
      offset: Offset(0, 4),
      blurRadius: 12,
    ),
  ];
}
