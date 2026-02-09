import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../core/constants/typography.dart';

class TimelineStep {
  final String label;
  final String? time;
  final bool completed;
  final bool active;

  const TimelineStep({
    required this.label,
    this.time,
    this.completed = false,
    this.active = false,
  });
}

class MtStatusTimeline extends StatelessWidget {
  final List<TimelineStep> steps;

  const MtStatusTimeline({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: MtSpacing.sm),
      child: Column(
        children: List.generate(steps.length, (i) {
          final step = steps[i];
          final isLast = i == steps.length - 1;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dot column
              SizedBox(
                width: 24,
                child: Column(
                  children: [
                    _buildDot(step),
                    if (!isLast) _buildLine(step.completed),
                  ],
                ),
              ),
              const SizedBox(width: MtSpacing.md),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: MtSpacing.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.label,
                        style: MtTypography.body.copyWith(
                          color: step.active
                              ? MtColors.white
                              : step.completed
                                  ? MtColors.textSecondary
                                  : MtColors.textTertiary,
                          fontWeight:
                              step.active ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                      if (step.time != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            step.time!,
                            style: MtTypography.caption.copyWith(
                              color: MtColors.textTertiary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildDot(TimelineStep step) {
    if (step.completed) {
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: MtColors.green,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, size: 12, color: MtColors.black),
      );
    }
    if (step.active) {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: MtColors.primary,
          shape: BoxShape.circle,
          border: Border.all(color: MtColors.primaryLight, width: 3),
        ),
      );
    }
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        color: MtColors.surfaceHighlight,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildLine(bool completed) {
    return Container(
      width: 2,
      height: 32,
      color: completed ? MtColors.green : MtColors.surfaceHighlight,
    );
  }
}
