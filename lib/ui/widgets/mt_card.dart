import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../core/constants/shadows.dart';

enum MtCardVariant { surface, elevated, outline }

class MtCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final MtCardVariant variant;
  final double padding;
  final BorderRadiusGeometry? borderRadius;

  const MtCard({
    super.key,
    required this.child,
    this.onTap,
    this.variant = MtCardVariant.surface,
    this.padding = MtSpacing.lg,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(MtBorderRadius.lg);

    final (bg, shadow, border) = switch (variant) {
      MtCardVariant.surface => (
          MtColors.surface,
          <BoxShadow>[],
          Border.all(color: Colors.transparent),
        ),
      MtCardVariant.elevated => (
          MtColors.surfaceElevated,
          MtShadows.md,
          Border.all(color: Colors.transparent),
        ),
      MtCardVariant.outline => (
          Colors.transparent,
          <BoxShadow>[],
          Border.all(color: MtColors.border),
        ),
    };

    final container = Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: radius,
        boxShadow: shadow,
        border: border,
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: container,
      );
    }
    return container;
  }
}
