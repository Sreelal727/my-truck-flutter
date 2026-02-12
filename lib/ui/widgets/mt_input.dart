import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../core/constants/typography.dart';

class MtInput extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final int? maxLength;
  final String? error;
  final Widget? prefix;
  final Widget? suffix;
  final bool multiline;
  final int maxLines;
  final bool enabled;

  const MtInput({
    super.key,
    this.label,
    this.placeholder,
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.error,
    this.prefix,
    this.suffix,
    this.multiline = false,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  State<MtInput> createState() => _MtInputState();
}

class _MtInputState extends State<MtInput> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.error != null
        ? MtColors.red
        : _focused
            ? MtColors.white
            : Colors.transparent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: MtSpacing.sm),
            child: Text(
              widget.label!,
              style: MtTypography.labelSmall.copyWith(
                color: MtColors.textSecondary,
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: MtColors.surface,
            borderRadius: BorderRadius.circular(MtBorderRadius.md),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Opacity(
            opacity: widget.enabled ? 1.0 : 0.5,
            child: Row(
              children: [
                if (widget.prefix != null)
                  Padding(
                    padding: const EdgeInsets.only(left: MtSpacing.lg),
                    child: widget.prefix,
                  ),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    onChanged: widget.onChanged,
                    keyboardType: widget.keyboardType,
                    maxLength: widget.maxLength,
                    maxLines: widget.multiline ? widget.maxLines : 1,
                    minLines: widget.multiline ? 3 : 1,
                    enabled: widget.enabled,
                    style: const TextStyle(
                      color: MtColors.white,
                      fontSize: 17,
                    ),
                    cursorColor: MtColors.primary,
                    onTap: () => setState(() => _focused = true),
                    onTapOutside: (_) {
                      FocusScope.of(context).unfocus();
                      setState(() => _focused = false);
                    },
                    decoration: InputDecoration(
                      hintText: widget.placeholder,
                      hintStyle: const TextStyle(
                        color: MtColors.textTertiary,
                        fontSize: 17,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      counterText: '',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: MtSpacing.lg,
                        vertical: widget.multiline ? MtSpacing.lg : MtSpacing.md,
                      ),
                    ),
                  ),
                ),
                if (widget.suffix != null)
                  Padding(
                    padding: const EdgeInsets.only(right: MtSpacing.lg),
                    child: widget.suffix,
                  ),
              ],
            ),
          ),
        ),
        if (widget.error != null)
          Padding(
            padding: const EdgeInsets.only(top: MtSpacing.xs, left: MtSpacing.xs),
            child: Text(
              widget.error!,
              style: MtTypography.caption.copyWith(color: MtColors.red),
            ),
          ),
      ],
    );
  }
}
