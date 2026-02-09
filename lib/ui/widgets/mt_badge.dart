import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';

enum MtBadgeVariant { surface, success, warning, error, info }
enum MtBadgeSize { sm, md }

class MtBadge extends StatelessWidget {
  final String label;
  final MtBadgeVariant variant;
  final MtBadgeSize size;

  const MtBadge({
    super.key,
    required this.label,
    this.variant = MtBadgeVariant.surface,
    this.size = MtBadgeSize.sm,
  });

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (variant) {
      MtBadgeVariant.surface => (
          MtColors.surfaceHighlight,
          MtColors.textPrimary,
        ),
      MtBadgeVariant.success => (
          MtColors.green.withValues(alpha: 0.15),
          MtColors.green,
        ),
      MtBadgeVariant.warning => (
          MtColors.orange.withValues(alpha: 0.15),
          MtColors.orange,
        ),
      MtBadgeVariant.error => (
          MtColors.red.withValues(alpha: 0.15),
          MtColors.red,
        ),
      MtBadgeVariant.info => (
          MtColors.primary.withValues(alpha: 0.15),
          MtColors.primary,
        ),
    };

    final isSmall = size == MtBadgeSize.sm;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? MtSpacing.sm : MtSpacing.md,
        vertical: isSmall ? 2 : MtSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(MtBorderRadius.sm),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: isSmall ? 10 : 12,
          fontWeight: FontWeight.w600,
          height: 14 / 11,
          letterSpacing: 0.5,
          color: fg,
        ),
      ),
    );
  }
}
