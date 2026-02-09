import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';

class AnimatedCounter extends StatelessWidget {
  final int value;
  final TextStyle? style;
  final String? prefix;
  final String? suffix;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.prefix,
    this.suffix,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: value),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, val, _) {
        return Text(
          '${prefix ?? ''}$val${suffix ?? ''}',
          style: style ?? MtTypography.h3.copyWith(color: MtColors.white),
        );
      },
    );
  }
}
