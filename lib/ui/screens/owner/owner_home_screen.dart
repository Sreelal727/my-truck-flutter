import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../data/enums/enums.dart';
import '../../../router/routes.dart';
import '../../widgets/widgets.dart';

class _MockOrder {
  final String id;
  final GoodsCategory category;
  final String pickup;
  final String drop;
  final String weight;
  final TruckType truckType;
  final String postedAgo;

  const _MockOrder({
    required this.id,
    required this.category,
    required this.pickup,
    required this.drop,
    required this.weight,
    required this.truckType,
    required this.postedAgo,
  });
}

final _mockOrders = [
  const _MockOrder(
    id: 'ORD-1042',
    category: GoodsCategory.construction,
    pickup: 'Mumbai, Maharashtra',
    drop: 'Pune, Maharashtra',
    weight: '8,500 kg',
    truckType: TruckType.eicher17ft,
    postedAgo: '5 min ago',
  ),
  const _MockOrder(
    id: 'ORD-1039',
    category: GoodsCategory.agricultural,
    pickup: 'Nashik, Maharashtra',
    drop: 'Delhi, NCR',
    weight: '14,000 kg',
    truckType: TruckType.container32ft,
    postedAgo: '15 min ago',
  ),
  const _MockOrder(
    id: 'ORD-1035',
    category: GoodsCategory.electronics,
    pickup: 'Chennai, Tamil Nadu',
    drop: 'Bangalore, Karnataka',
    weight: '2,200 kg',
    truckType: TruckType.tata407,
    postedAgo: '28 min ago',
  ),
  const _MockOrder(
    id: 'ORD-1031',
    category: GoodsCategory.fmcg,
    pickup: 'Ahmedabad, Gujarat',
    drop: 'Jaipur, Rajasthan',
    weight: '6,000 kg',
    truckType: TruckType.eicher14ft,
    postedAgo: '45 min ago',
  ),
  const _MockOrder(
    id: 'ORD-1028',
    category: GoodsCategory.furniture,
    pickup: 'Hyderabad, Telangana',
    drop: 'Vizag, Andhra Pradesh',
    weight: '3,800 kg',
    truckType: TruckType.closedBody,
    postedAgo: '1 hr ago',
  ),
];

class OwnerHomeScreen extends ConsumerStatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  ConsumerState<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends ConsumerState<OwnerHomeScreen> {
  String _selectedCategory = 'All';

  List<_MockOrder> get _filteredOrders {
    if (_selectedCategory == 'All') return _mockOrders;
    return _mockOrders
        .where((o) => o.category.label == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['All', ...GoodsCategory.values.map((c) => c.label)];
    final filtered = _filteredOrders;

    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MtSpacing.xl,
                MtSpacing.lg,
                MtSpacing.xl,
                MtSpacing.md,
              ),
              child: Text('Available Loads', style: MtTypography.h2),
            ),

            // Filter chips
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xl),
                itemCount: categories.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: MtSpacing.sm),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = cat == _selectedCategory;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: MtSpacing.lg,
                        vertical: MtSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? MtColors.primary
                            : MtColors.surface,
                        borderRadius:
                            BorderRadius.circular(MtBorderRadius.full),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cat,
                        style: MtTypography.labelSmall.copyWith(
                          color: isSelected
                              ? MtColors.white
                              : MtColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: MtSpacing.md),

            // Orders list
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        'No loads in this category',
                        style: MtTypography.body.copyWith(
                          color: MtColors.textSecondary,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.fromLTRB(
                        MtSpacing.xl,
                        MtSpacing.sm,
                        MtSpacing.xl,
                        MediaQuery.of(context).padding.bottom + 100,
                      ),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: MtSpacing.md),
                      itemBuilder: (context, index) {
                        final order = filtered[index];
                        return _OrderCard(order: order)
                            .animate()
                            .fadeIn(
                              delay: Duration(milliseconds: 60 * index),
                              duration: const Duration(milliseconds: 400),
                            )
                            .slideY(
                              begin: 0.1,
                              end: 0,
                              delay: Duration(milliseconds: 60 * index),
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOutCubic,
                            );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final _MockOrder order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return MtCard(
      variant: MtCardVariant.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category badge + posted time
          Row(
            children: [
              Icon(
                order.category.icon,
                size: 16,
                color: MtColors.primary,
              ),
              const SizedBox(width: MtSpacing.sm),
              MtBadge(
                label: order.category.label,
                variant: MtBadgeVariant.info,
                size: MtBadgeSize.sm,
              ),
              const Spacer(),
              Text(
                'Posted ${order.postedAgo}',
                style: MtTypography.caption.copyWith(
                  color: MtColors.textTertiary,
                ),
              ),
            ],
          ),

          const SizedBox(height: MtSpacing.md),

          // Route
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: MtColors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 1.5,
                    height: 24,
                    color: MtColors.textTertiary,
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: MtColors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: MtSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.pickup,
                      style: MtTypography.label,
                    ),
                    const SizedBox(height: MtSpacing.lg),
                    Text(
                      order.drop,
                      style: MtTypography.label,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: MtSpacing.md),

          // Weight & Truck type
          Container(
            padding: const EdgeInsets.all(MtSpacing.md),
            decoration: BoxDecoration(
              color: MtColors.surfaceElevated,
              borderRadius: BorderRadius.circular(MtBorderRadius.sm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.scale_outlined,
                  size: 16,
                  color: MtColors.textSecondary,
                ),
                const SizedBox(width: MtSpacing.sm),
                Text(
                  order.weight,
                  style: MtTypography.bodySmall.copyWith(
                    color: MtColors.textSecondary,
                  ),
                ),
                const SizedBox(width: MtSpacing.xl),
                Icon(
                  Icons.local_shipping_outlined,
                  size: 16,
                  color: MtColors.textSecondary,
                ),
                const SizedBox(width: MtSpacing.sm),
                Expanded(
                  child: Text(
                    order.truckType.label,
                    style: MtTypography.bodySmall.copyWith(
                      color: MtColors.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: MtSpacing.md),

          // View & Bid button
          Align(
            alignment: Alignment.centerRight,
            child: MtButton(
              title: 'View & Bid',
              size: MtButtonSize.sm,
              fullWidth: false,
              onPressed: () => context.push(Routes.ownerOrderDetail),
            ),
          ),
        ],
      ),
    );
  }
}
