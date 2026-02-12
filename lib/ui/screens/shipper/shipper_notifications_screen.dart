import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';

class _NotificationItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String time;
  final bool isUnread;

  const _NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.time,
    this.isUnread = false,
  });
}

class ShipperNotificationsScreen extends ConsumerWidget {
  const ShipperNotificationsScreen({super.key});

  static const _notifications = [
    _NotificationItem(
      icon: Icons.local_offer_rounded,
      iconColor: MtColors.green,
      title: 'New bid received',
      description: 'Amit Patel placed a bid of \u20B918,500 on ORD-1001',
      time: '5 min ago',
      isUnread: true,
    ),
    _NotificationItem(
      icon: Icons.local_offer_rounded,
      iconColor: MtColors.green,
      title: 'New bid received',
      description: 'Vikram Singh placed a bid of \u20B916,000 on ORD-1001',
      time: '15 min ago',
      isUnread: true,
    ),
    _NotificationItem(
      icon: Icons.check_circle_rounded,
      iconColor: MtColors.primary,
      title: 'Order confirmed',
      description: 'ORD-1002 has been confirmed. Truck owner notified.',
      time: '2 hours ago',
      isUnread: true,
    ),
    _NotificationItem(
      icon: Icons.local_shipping_rounded,
      iconColor: MtColors.primary,
      title: 'Driver on the way',
      description: 'Ramesh Yadav is heading to pickup point for ORD-1002',
      time: '5 hours ago',
    ),
    _NotificationItem(
      icon: Icons.timer_outlined,
      iconColor: MtColors.orange,
      title: 'Bidding ending soon',
      description: 'Bidding for ORD-1001 ends in 1 hour. 3 bids received.',
      time: 'Yesterday',
    ),
    _NotificationItem(
      icon: Icons.payment_rounded,
      iconColor: MtColors.green,
      title: 'Payment processed',
      description: 'Payment of \u20B925,000 for ORD-998 has been processed.',
      time: 'Yesterday',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MtSpacing.xl, MtSpacing.xl, MtSpacing.xl, MtSpacing.lg,
              ),
              child: Text('Notifications', style: MtTypography.h2),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 120),
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notif = _notifications[index];
                  return GestureDetector(
                    onTap: () => _showSnack(context, notif.title),
                    child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: MtSpacing.xl,
                      vertical: MtSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: MtColors.surface,
                      borderRadius: BorderRadius.circular(MtBorderRadius.lg),
                      border: notif.isUnread
                          ? const Border(
                              left: BorderSide(
                                color: MtColors.primary,
                                width: 3,
                              ),
                            )
                          : null,
                    ),
                    padding: const EdgeInsets.all(MtSpacing.lg),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: notif.iconColor.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            notif.icon,
                            color: notif.iconColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: MtSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notif.title,
                                style: MtTypography.label,
                              ),
                              const SizedBox(height: MtSpacing.xs),
                              Text(
                                notif.description,
                                style: MtTypography.bodySmall.copyWith(
                                  color: MtColors.textSecondary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: MtSpacing.xs),
                              Text(
                                notif.time,
                                style: MtTypography.caption.copyWith(
                                  color: MtColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ).animate().fadeIn(
                        delay: Duration(milliseconds: index * 80),
                        duration: 400.ms,
                      ).slideX(begin: 0.05, end: 0);
                },
              ),
            ),
          ],
        ),
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
