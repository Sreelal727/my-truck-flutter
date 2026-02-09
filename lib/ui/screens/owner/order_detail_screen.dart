import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../data/enums/enums.dart';
import '../../../router/routes.dart';
import '../../widgets/widgets.dart';

class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MtColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Collapsing map header
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                backgroundColor: MtColors.background,
                leading: Padding(
                  padding: const EdgeInsets.all(MtSpacing.sm),
                  child: CircleAvatar(
                    backgroundColor: MtColors.surface,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: MtColors.white,
                        size: 20,
                      ),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      color: MtColors.surfaceElevated,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          MtColors.primary.withValues(alpha: 0.15),
                          MtColors.background,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          Icon(
                            Icons.map_outlined,
                            size: 48,
                            color: MtColors.primary.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: MtSpacing.sm),
                          Text(
                            'Mumbai  -  Pune',
                            style: MtTypography.label.copyWith(
                              color: MtColors.textSecondary,
                            ),
                          ),
                          Text(
                            '~150 km',
                            style: MtTypography.caption.copyWith(
                              color: MtColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Order details
              SliverPadding(
                padding: const EdgeInsets.all(MtSpacing.xl),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Order ID & Status
                    Row(
                      children: [
                        Text(
                          'ORD-1042',
                          style: MtTypography.h3,
                        ),
                        const Spacer(),
                        const MtBadge(
                          label: 'Bidding',
                          variant: MtBadgeVariant.warning,
                          size: MtBadgeSize.md,
                        ),
                      ],
                    ),

                    const SizedBox(height: MtSpacing.xl),

                    // Route Card
                    MtCard(
                      variant: MtCardVariant.elevated,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Route',
                            style: MtTypography.labelSmall.copyWith(
                              color: MtColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: MtSpacing.md),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: const BoxDecoration(
                                      color: MtColors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 1.5,
                                    height: 36,
                                    color: MtColors.textTertiary,
                                  ),
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: const BoxDecoration(
                                      color: MtColors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: MtSpacing.lg),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pickup',
                                      style: MtTypography.caption.copyWith(
                                        color: MtColors.textTertiary,
                                      ),
                                    ),
                                    Text(
                                      'Mumbai, Maharashtra',
                                      style: MtTypography.label,
                                    ),
                                    const SizedBox(height: MtSpacing.xl),
                                    Text(
                                      'Drop',
                                      style: MtTypography.caption.copyWith(
                                        color: MtColors.textTertiary,
                                      ),
                                    ),
                                    Text(
                                      'Pune, Maharashtra',
                                      style: MtTypography.label,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: MtSpacing.md),

                    // Load Info Card
                    MtCard(
                      variant: MtCardVariant.elevated,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Load Information',
                            style: MtTypography.labelSmall.copyWith(
                              color: MtColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: MtSpacing.md),
                          _DetailRow(
                            icon: Icons.category_outlined,
                            label: 'Category',
                            value: GoodsCategory.construction.label,
                          ),
                          const SizedBox(height: MtSpacing.md),
                          _DetailRow(
                            icon: Icons.description_outlined,
                            label: 'Description',
                            value: 'Cement bags and steel rods for construction site',
                          ),
                          const SizedBox(height: MtSpacing.md),
                          _DetailRow(
                            icon: Icons.scale_outlined,
                            label: 'Weight',
                            value: '8,500 kg',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: MtSpacing.md),

                    // Truck Preference Card
                    MtCard(
                      variant: MtCardVariant.elevated,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Truck Preference',
                            style: MtTypography.labelSmall.copyWith(
                              color: MtColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: MtSpacing.md),
                          _DetailRow(
                            icon: Icons.local_shipping_outlined,
                            label: 'Truck Type',
                            value: TruckType.eicher17ft.label,
                          ),
                          const SizedBox(height: MtSpacing.md),
                          _DetailRow(
                            icon: Icons.straighten_outlined,
                            label: 'Capacity',
                            value: TruckType.eicher17ft.capacity,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: MtSpacing.md),

                    // Schedule Card
                    MtCard(
                      variant: MtCardVariant.elevated,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Schedule',
                            style: MtTypography.labelSmall.copyWith(
                              color: MtColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: MtSpacing.md),
                          _DetailRow(
                            icon: Icons.calendar_today_outlined,
                            label: 'Pickup Date',
                            value: '15 Feb 2025',
                          ),
                          const SizedBox(height: MtSpacing.md),
                          _DetailRow(
                            icon: Icons.access_time_outlined,
                            label: 'Pickup Time',
                            value: '9:00 AM - 12:00 PM',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: MtSpacing.md),

                    // Current Bids
                    MtCard(
                      variant: MtCardVariant.elevated,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bidding Status',
                            style: MtTypography.labelSmall.copyWith(
                              color: MtColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: MtSpacing.md),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '7',
                                      style: MtTypography.h3.copyWith(
                                        color: MtColors.orange,
                                      ),
                                    ),
                                    Text(
                                      'Total Bids',
                                      style: MtTypography.caption.copyWith(
                                        color: MtColors.textTertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: MtColors.border,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: MtSpacing.xl,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '18,500',
                                        style: MtTypography.h3.copyWith(
                                          color: MtColors.green,
                                        ),
                                      ),
                                      Text(
                                        'Lowest Bid',
                                        style: MtTypography.caption.copyWith(
                                          color: MtColors.textTertiary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: MtSpacing.md),
                          Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 16,
                                color: MtColors.orange,
                              ),
                              const SizedBox(width: MtSpacing.sm),
                              Text(
                                '42 min remaining',
                                style: MtTypography.bodySmall.copyWith(
                                  color: MtColors.orange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Bottom spacing for sticky button
                    const SizedBox(height: 100),
                  ]),
                ),
              ),
            ],
          ),

          // Sticky bottom button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                MtSpacing.xl,
                MtSpacing.lg,
                MtSpacing.xl,
                MediaQuery.of(context).padding.bottom + MtSpacing.lg,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    MtColors.background.withValues(alpha: 0.0),
                    MtColors.background.withValues(alpha: 0.9),
                    MtColors.background,
                  ],
                ),
              ),
              child: MtButton(
                title: 'Place Bid',
                onPressed: () => context.push(Routes.ownerPlaceBid),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: MtColors.textTertiary),
        const SizedBox(width: MtSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: MtTypography.caption.copyWith(
                  color: MtColors.textTertiary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: MtTypography.body,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
