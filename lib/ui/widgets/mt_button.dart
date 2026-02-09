import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';

enum MtButtonVariant { primary, secondary, outline, ghost, danger }
enum MtButtonSize { sm, md, lg }

class MtButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final MtButtonVariant variant;
  final MtButtonSize size;
  final bool loading;
  final bool fullWidth;
  final Widget? icon;

  const MtButton({
    super.key,
    required this.title,
    this.onPressed,
    this.variant = MtButtonVariant.primary,
    this.size = MtButtonSize.lg,
    this.loading = false,
    this.fullWidth = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final height = switch (size) {
      MtButtonSize.sm => 36.0,
      MtButtonSize.md => 44.0,
      MtButtonSize.lg => 52.0,
    };

    final hPadding = switch (size) {
      MtButtonSize.sm => MtSpacing.lg,
      MtButtonSize.md => MtSpacing.xl,
      MtButtonSize.lg => MtSpacing.xxl,
    };

    final fontSize = switch (size) {
      MtButtonSize.sm => 14.0,
      MtButtonSize.md => 15.0,
      MtButtonSize.lg => 17.0,
    };

    final (bg, fg, borderSide) = switch (variant) {
      MtButtonVariant.primary => (
          MtColors.white,
          MtColors.black,
          BorderSide.none,
        ),
      MtButtonVariant.secondary => (
          MtColors.surfaceElevated,
          MtColors.white,
          BorderSide.none,
        ),
      MtButtonVariant.outline => (
          Colors.transparent,
          MtColors.white,
          const BorderSide(color: MtColors.white, width: 1.5),
        ),
      MtButtonVariant.ghost => (
          Colors.transparent,
          MtColors.white,
          BorderSide.none,
        ),
      MtButtonVariant.danger => (
          MtColors.red,
          MtColors.white,
          BorderSide.none,
        ),
    };

    final child = loading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: fg,
            ),
          )
        : Row(
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: MtSpacing.sm)],
              Text(
                title,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
            ],
          );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: height,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(
          size == MtButtonSize.sm ? MtBorderRadius.sm : MtBorderRadius.md,
        ),
        child: InkWell(
          onTap: (loading || onPressed == null) ? null : onPressed,
          borderRadius: BorderRadius.circular(
            size == MtButtonSize.sm ? MtBorderRadius.sm : MtBorderRadius.md,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: hPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                size == MtButtonSize.sm ? MtBorderRadius.sm : MtBorderRadius.md,
              ),
              border: borderSide != BorderSide.none
                  ? Border.fromBorderSide(borderSide)
                  : null,
            ),
            alignment: Alignment.center,
            child: Opacity(
              opacity: onPressed == null ? 0.4 : 1.0,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
