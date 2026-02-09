import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';

class ShimmerLoading extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final EdgeInsets padding;

  const ShimmerLoading({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 100,
    this.padding = const EdgeInsets.symmetric(horizontal: MtSpacing.xl),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MtColors.surface,
      highlightColor: MtColors.surfaceElevated,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: padding,
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(height: MtSpacing.md),
        itemBuilder: (_, __) => Container(
          height: itemHeight,
          decoration: BoxDecoration(
            color: MtColors.surface,
            borderRadius: BorderRadius.circular(MtBorderRadius.lg),
          ),
        ),
      ),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = MtBorderRadius.md,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MtColors.surface,
      highlightColor: MtColors.surfaceElevated,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: MtColors.surface,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
