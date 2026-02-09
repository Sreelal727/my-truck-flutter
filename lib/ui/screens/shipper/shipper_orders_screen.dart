import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../router/routes.dart';
import '../../widgets/widgets.dart';

class _OrderItem {
  final String id;
  final String pickup;
  final String drop;
  final double amount;
  final String statusLabel;
  final MtBadgeVariant badgeVariant;
  final String info;

  const _OrderItem({
    required this.id,
    required this.pickup,
    required this.drop,
    required this.amount,
    required this.statusLabel,
    required this.badgeVariant,
    required this.info,
  });
}

class ShipperOrdersScreen extends ConsumerStatefulWidget {
  const ShipperOrdersScreen({super.key});

  @override
  ConsumerState<ShipperOrdersScreen> createState() =>
      _ShipperOrdersScreenState();
}

class _ShipperOrdersScreenState extends ConsumerState<ShipperOrdersScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  static const _activeOrders = [
    _OrderItem(
      id: 'ORD-1001',
      pickup: 'Andheri East, Mumbai',
      drop: 'Hinjewadi, Pune',
      amount: 18500,
      statusLabel: 'Bidding',
      badgeVariant: MtBadgeVariant.warning,
      info: '3 bids \u2022 45 min left',
    ),
    _OrderItem(
      id: 'ORD-1002',
      pickup: 'Naraina, New Delhi',
      drop: 'Mansarovar, Jaipur',
      amount: 32000,
      statusLabel: 'In Transit',
      badgeVariant: MtBadgeVariant.info,
      info: 'ETA: 4 hrs',
    ),
    _OrderItem(
      id: 'ORD-1005',
      pickup: 'Sector 62, Noida',
      drop: 'Civil Lines, Lucknow',
      amount: 14000,
      statusLabel: 'Posted',
      badgeVariant: MtBadgeVariant.surface,
      info: 'Awaiting bids',
    ),
  ];

  static const _completedOrders = [
    _OrderItem(
      id: 'ORD-998',
      pickup: 'GIDC, Ahmedabad',
      drop: 'Indore, Madhya Pradesh',
      amount: 35000,
      statusLabel: 'Completed',
      badgeVariant: MtBadgeVariant.success,
      info: 'Delivered on 26 Jan',
    ),
    _OrderItem(
      id: 'ORD-995',
      pickup: 'Whitefield, Bangalore',
      drop: 'Banjara Hills, Hyderabad',
      amount: 45000,
      statusLabel: 'Completed',
      badgeVariant: MtBadgeVariant.success,
      info: 'Delivered on 20 Jan',
    ),
  ];

  static const _cancelledOrders = [
    _OrderItem(
      id: 'ORD-990',
      pickup: 'Koramangala, Bangalore',
      drop: 'MG Road, Kochi',
      amount: 28000,
      statusLabel: 'Cancelled',
      badgeVariant: MtBadgeVariant.error,
      info: 'Cancelled on 07 Feb',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MtSpacing.xl, MtSpacing.xl, MtSpacing.xl, MtSpacing.md,
              ),
              child: Text('My Orders', style: MtTypography.h2),
            ),

            // Tab bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: MtSpacing.xl),
              decoration: BoxDecoration(
                color: MtColors.surface,
                borderRadius: BorderRadius.circular(MtBorderRadius.md),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: MtColors.white,
                  borderRadius: BorderRadius.circular(MtBorderRadius.md),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerHeight: 0,
                labelColor: MtColors.black,
                unselectedLabelColor: MtColors.textSecondary,
                labelStyle: MtTypography.labelSmall,
                unselectedLabelStyle: MtTypography.labelSmall,
                tabs: const [
                  Tab(text: 'Active'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Cancelled'),
                ],
              ),
            ),

            const SizedBox(height: MtSpacing.lg),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOrderList(_activeOrders),
                  _buildOrderList(_completedOrders),
                  _buildOrderList(_cancelledOrders),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(List<_OrderItem> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              color: MtColors.textTertiary,
              size: 64,
            ),
            const SizedBox(height: MtSpacing.lg),
            Text(
              'No orders found',
              style: MtTypography.body.copyWith(
                color: MtColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        MtSpacing.xl, 0, MtSpacing.xl, 120,
      ),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: MtSpacing.md),
          child: MtCard(
            onTap: () {
              if (order.statusLabel == 'Bidding') {
                context.push(Routes.shipperBidding);
              } else if (order.statusLabel == 'In Transit') {
                context.push(Routes.shipperTracking);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.id,
                      style: MtTypography.labelSmall.copyWith(
                        color: MtColors.textSecondary,
                      ),
                    ),
                    MtBadge(
                      label: order.statusLabel,
                      variant: order.badgeVariant,
                    ),
                  ],
                ),
                const SizedBox(height: MtSpacing.md),
                _buildRouteInfo(order.pickup, order.drop),
                const SizedBox(height: MtSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\u20B9${order.amount.toInt().toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                      style: MtTypography.h4.copyWith(
                        color: MtColors.green,
                      ),
                    ),
                    Text(
                      order.info,
                      style: MtTypography.caption.copyWith(
                        color: MtColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ).animate().fadeIn(
              delay: Duration(milliseconds: index * 100),
              duration: 400.ms,
            ).slideY(begin: 0.1, end: 0);
      },
    );
  }

  Widget _buildRouteInfo(String pickup, String drop) {
    return Row(
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
              width: 2,
              height: 24,
              color: MtColors.surfaceHighlight,
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
                pickup,
                style: MtTypography.body,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: MtSpacing.lg),
              Text(
                drop,
                style: MtTypography.body,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
