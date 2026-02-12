import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../widgets/widgets.dart';

// ─── Mock Trip History Data ─────────────────────────────────────────────────
class _MockHistoryTrip {
  final String tripId;
  final String date;
  final String pickup;
  final String drop;
  final String status; // 'completed' or 'cancelled'
  final int amount;
  final String ownerName;

  const _MockHistoryTrip({
    required this.tripId,
    required this.date,
    required this.pickup,
    required this.drop,
    required this.status,
    required this.amount,
    required this.ownerName,
  });
}

const _mockTrips = [
  _MockHistoryTrip(
    tripId: 'TRP-2024-08135',
    date: '07 Feb 2025',
    pickup: 'JNPT Port, Nhava Sheva, Mumbai',
    drop: 'Bhiwandi Warehouse Hub, Thane',
    status: 'completed',
    amount: 8500,
    ownerName: 'Sharma Transport Co.',
  ),
  _MockHistoryTrip(
    tripId: 'TRP-2024-08128',
    date: '04 Feb 2025',
    pickup: 'Taloja MIDC, Navi Mumbai',
    drop: 'Hadapsar Industrial Estate, Pune',
    status: 'completed',
    amount: 12000,
    ownerName: 'Sharma Transport Co.',
  ),
  _MockHistoryTrip(
    tripId: 'TRP-2024-08119',
    date: '01 Feb 2025',
    pickup: 'Chakan MIDC, Pune',
    drop: 'Nashik Industrial Area, Nashik',
    status: 'cancelled',
    amount: 7500,
    ownerName: 'Patel Logistics',
  ),
  _MockHistoryTrip(
    tripId: 'TRP-2024-08107',
    date: '28 Jan 2025',
    pickup: 'Vashi APM Terminal, Navi Mumbai',
    drop: 'Aurangabad Industrial City, Aurangabad',
    status: 'completed',
    amount: 28000,
    ownerName: 'Sharma Transport Co.',
  ),
  _MockHistoryTrip(
    tripId: 'TRP-2024-08094',
    date: '25 Jan 2025',
    pickup: 'Bhosari MIDC, Pune',
    drop: 'Pirangut Industrial Area, Pune',
    status: 'completed',
    amount: 3500,
    ownerName: 'Gupta Fleet Services',
  ),
  _MockHistoryTrip(
    tripId: 'TRP-2024-08081',
    date: '21 Jan 2025',
    pickup: 'Panvel Goods Terminal, Raigad',
    drop: 'Satara MIDC, Satara',
    status: 'completed',
    amount: 18500,
    ownerName: 'Sharma Transport Co.',
  ),
];

// ─────────────────────────────────────────────────────────────────────────────

class DriverHistoryScreen extends ConsumerWidget {
  const DriverHistoryScreen({super.key});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: MtSpacing.lg,
            right: MtSpacing.lg,
            top: MtSpacing.lg,
            bottom: 120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text('Trip History', style: MtTypography.h2),
              const SizedBox(height: MtSpacing.lg),

              // Earnings Summary Card
              _buildEarningsSummaryCard(),
              const SizedBox(height: MtSpacing.xxl),

              // Trip List
              ...List.generate(_mockTrips.length, (i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: MtSpacing.md),
                  child: _buildTripCard(context, _mockTrips[i]),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Earnings Summary Card ────────────────────────────────────────────
  Widget _buildEarningsSummaryCard() {
    return MtCard(
      variant: MtCardVariant.elevated,
      child: Column(
        children: [
          Row(
            children: [
              // This Month
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This Month',
                      style: MtTypography.caption.copyWith(
                        color: MtColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: MtSpacing.xs),
                    Text(
                      '\u20B942,500',
                      style: MtTypography.h3.copyWith(
                        color: MtColors.green,
                      ),
                    ),
                  ],
                ),
              ),
              // Divider
              Container(
                width: 1,
                height: 48,
                color: MtColors.surfaceHighlight,
              ),
              // Total
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: MtSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: MtTypography.caption.copyWith(
                          color: MtColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: MtSpacing.xs),
                      Text(
                        '\u20B93,48,000',
                        style: MtTypography.h3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: MtSpacing.md),
          Divider(
            color: MtColors.surfaceHighlight,
            height: 1,
          ),
          const SizedBox(height: MtSpacing.md),
          Row(
            children: [
              Icon(
                Icons.route_rounded,
                size: 16,
                color: MtColors.textSecondary,
              ),
              const SizedBox(width: MtSpacing.sm),
              Text(
                '12 trips this month',
                style: MtTypography.bodySmall.copyWith(
                  color: MtColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Single Trip Card ─────────────────────────────────────────────────
  Widget _buildTripCard(BuildContext context, _MockHistoryTrip trip) {
    final isCompleted = trip.status == 'completed';

    return GestureDetector(
      onTap: () {
        _showSnack(context, 'Trip ${trip.tripId} details coming soon');
      },
      child: MtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trip ID, Date, and Amount row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Trip ID + Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.tripId,
                    style: MtTypography.caption.copyWith(
                      color: MtColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    trip.date,
                    style: MtTypography.caption.copyWith(
                      color: MtColors.textTertiary,
                    ),
                  ),
                ],
              ),
              // Right: Amount
              Text(
                '\u20B9${_formatAmount(trip.amount)}',
                style: MtTypography.h4.copyWith(
                  color: isCompleted ? MtColors.green : MtColors.textTertiary,
                  decoration:
                      isCompleted ? TextDecoration.none : TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const SizedBox(height: MtSpacing.md),

          // Route: Pickup
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  color: MtColors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: MtSpacing.sm),
              Expanded(
                child: Text(
                  trip.pickup,
                  style: MtTypography.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          // Connecting line
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Container(
              width: 2,
              height: 12,
              color: MtColors.surfaceHighlight,
            ),
          ),
          // Route: Drop
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  color: MtColors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: MtSpacing.sm),
              Expanded(
                child: Text(
                  trip.drop,
                  style: MtTypography.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: MtSpacing.md),

          // Bottom row: Badge + Owner name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MtBadge(
                label: isCompleted ? 'Completed' : 'Cancelled',
                variant: isCompleted
                    ? MtBadgeVariant.success
                    : MtBadgeVariant.error,
              ),
              Text(
                trip.ownerName,
                style: MtTypography.bodySmall.copyWith(
                  color: MtColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }

  // ─── Helpers ──────────────────────────────────────────────────────────
  String _formatAmount(int amount) {
    final str = amount.toString();
    if (str.length <= 3) return str;

    final lastThree = str.substring(str.length - 3);
    String remaining = str.substring(0, str.length - 3);

    // Indian number system: groups of 2 after the first 3 digits
    final buffer = StringBuffer();
    while (remaining.length > 2) {
      buffer.write(remaining.substring(0, remaining.length - 2));
      buffer.write(',');
      remaining = remaining.substring(remaining.length - 2);
    }
    if (remaining.isNotEmpty) {
      buffer.write(remaining);
    }

    // Rebuild properly
    final parts = <String>[];
    String temp = str.substring(0, str.length - 3);
    while (temp.length > 2) {
      parts.insert(0, temp.substring(temp.length - 2));
      temp = temp.substring(0, temp.length - 2);
    }
    if (temp.isNotEmpty) parts.insert(0, temp);
    parts.add(lastThree);
    return parts.join(',');
  }
}
