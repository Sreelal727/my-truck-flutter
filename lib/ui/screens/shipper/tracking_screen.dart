import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../widgets/widgets.dart';

class TrackingScreen extends ConsumerWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MtColors.background,
      body: Stack(
        children: [
          // Map placeholder
          Container(
            height: 250,
            width: double.infinity,
            color: MtColors.surfaceElevated,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map_rounded,
                  color: MtColors.textTertiary,
                  size: 48,
                ),
                const SizedBox(height: MtSpacing.md),
                Text(
                  'Map View',
                  style: MtTypography.body.copyWith(
                    color: MtColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),

          // Back button on map
          Positioned(
            top: MediaQuery.of(context).padding.top + MtSpacing.sm,
            left: MtSpacing.lg,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: MtColors.surface,
                  borderRadius: BorderRadius.circular(MtBorderRadius.md),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: MtColors.white,
                  size: 20,
                ),
              ),
            ),
          ),

          // DraggableScrollableSheet
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.4,
            maxChildSize: 0.92,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: MtColors.background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(MtBorderRadius.xl),
                  ),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: [
                    // Drag handle
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: MtSpacing.md),
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                          color: MtColors.surfaceHighlight,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // Order info
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        MtSpacing.xl, MtSpacing.xl, MtSpacing.xl, MtSpacing.md,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('ORD-1002', style: MtTypography.h4),
                              const MtBadge(
                                label: 'In Transit',
                                variant: MtBadgeVariant.info,
                              ),
                            ],
                          ),
                          const SizedBox(height: MtSpacing.sm),
                          Text(
                            'Naraina, New Delhi \u2192 Mansarovar, Jaipur',
                            style: MtTypography.bodySmall.copyWith(
                              color: MtColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 300.ms),

                    const Divider(color: MtColors.surface, height: 1),

                    // Driver info card
                    Padding(
                      padding: const EdgeInsets.all(MtSpacing.xl),
                      child: MtCard(
                        variant: MtCardVariant.elevated,
                        child: Row(
                          children: [
                            // Driver avatar
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: MtColors.surfaceHighlight,
                                borderRadius: BorderRadius.circular(
                                  MtBorderRadius.full,
                                ),
                              ),
                              child: const Icon(
                                Icons.person_rounded,
                                color: MtColors.textSecondary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: MtSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ramesh Yadav',
                                    style: MtTypography.label,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '+91 97654 32109',
                                    style: MtTypography.bodySmall.copyWith(
                                      color: MtColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Eicher 17ft \u2022 MH 12 AB 1234',
                                    style: MtTypography.caption.copyWith(
                                      color: MtColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: MtColors.green.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(
                                  MtBorderRadius.full,
                                ),
                              ),
                              child: const Icon(
                                Icons.phone_rounded,
                                color: MtColors.green,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 100.ms, duration: 300.ms),

                    // Status Timeline
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: MtSpacing.xl,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Trip Status', style: MtTypography.h4),
                          const SizedBox(height: MtSpacing.lg),
                          MtStatusTimeline(
                            steps: [
                              const TimelineStep(
                                label: 'Assigned',
                                time: '09 Feb, 6:00 AM',
                                completed: true,
                              ),
                              const TimelineStep(
                                label: 'Pickup Reached',
                                time: '09 Feb, 8:30 AM',
                                completed: true,
                              ),
                              const TimelineStep(
                                label: 'Loading',
                                time: '09 Feb, 9:15 AM',
                                completed: true,
                              ),
                              const TimelineStep(
                                label: 'In Transit',
                                time: 'Started 09 Feb, 10:00 AM',
                                active: true,
                              ),
                              const TimelineStep(
                                label: 'Destination Reached',
                              ),
                              const TimelineStep(
                                label: 'Unloading',
                              ),
                              const TimelineStep(
                                label: 'Delivered',
                              ),
                              const TimelineStep(
                                label: 'Completed',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 300.ms),

                    const SizedBox(height: MtSpacing.xxl),

                    // Contact buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: MtSpacing.xl,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: MtButton(
                              title: 'Contact Driver',
                              variant: MtButtonVariant.secondary,
                              size: MtButtonSize.md,
                              icon: const Icon(
                                Icons.phone_outlined,
                                color: MtColors.white,
                                size: 18,
                              ),
                              onPressed: () => _showSnack(context, 'Calling driver Ramesh Yadav...'),
                            ),
                          ),
                          const SizedBox(width: MtSpacing.md),
                          Expanded(
                            child: MtButton(
                              title: 'Contact Owner',
                              variant: MtButtonVariant.outline,
                              size: MtButtonSize.md,
                              icon: const Icon(
                                Icons.phone_outlined,
                                color: MtColors.white,
                                size: 18,
                              ),
                              onPressed: () => _showSnack(context, 'Calling truck owner Amit Patel...'),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 300.ms, duration: 300.ms),

                    const SizedBox(height: MtSpacing.xxxxl),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

void _showSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Color(0xFFFFFFFF)),
      ),
      backgroundColor: const Color(0xFF2C2C2E),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: const Duration(seconds: 2),
    ),
  );
}
