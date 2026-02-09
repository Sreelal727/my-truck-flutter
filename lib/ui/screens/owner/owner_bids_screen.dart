import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../data/enums/enums.dart';
import '../../../router/routes.dart';
import '../../widgets/widgets.dart';

enum _BidStatus { active, won, lost }

class _MockBid {
  final String orderId;
  final String pickup;
  final String drop;
  final GoodsCategory category;
  final int bidAmount;
  final _BidStatus status;
  final String truckInfo;
  final String time;

  const _MockBid({
    required this.orderId,
    required this.pickup,
    required this.drop,
    required this.category,
    required this.bidAmount,
    required this.status,
    required this.truckInfo,
    required this.time,
  });
}

const _mockBids = [
  // Active bids
  _MockBid(
    orderId: 'ORD-1042',
    pickup: 'Mumbai',
    drop: 'Pune',
    category: GoodsCategory.construction,
    bidAmount: 22000,
    status: _BidStatus.active,
    truckInfo: 'Eicher 17ft - MH-12-AB-1234',
    time: '25 min left',
  ),
  _MockBid(
    orderId: 'ORD-1039',
    pickup: 'Nashik',
    drop: 'Delhi',
    category: GoodsCategory.agricultural,
    bidAmount: 45000,
    status: _BidStatus.active,
    truckInfo: 'Container 32ft - MH-14-EF-9012',
    time: '48 min left',
  ),
  _MockBid(
    orderId: 'ORD-1035',
    pickup: 'Chennai',
    drop: 'Bangalore',
    category: GoodsCategory.electronics,
    bidAmount: 15000,
    status: _BidStatus.active,
    truckInfo: 'Tata 407 - MH-12-CD-5678',
    time: '12 min left',
  ),
  // Won bids
  _MockBid(
    orderId: 'ORD-1020',
    pickup: 'Ahmedabad',
    drop: 'Jaipur',
    category: GoodsCategory.fmcg,
    bidAmount: 28000,
    status: _BidStatus.won,
    truckInfo: 'Eicher 17ft - MH-12-AB-1234',
    time: 'Won 2 hrs ago',
  ),
  _MockBid(
    orderId: 'ORD-1015',
    pickup: 'Hyderabad',
    drop: 'Vizag',
    category: GoodsCategory.furniture,
    bidAmount: 18500,
    status: _BidStatus.won,
    truckInfo: 'Tata 407 - MH-12-CD-5678',
    time: 'Won yesterday',
  ),
  // Lost bids
  _MockBid(
    orderId: 'ORD-1010',
    pickup: 'Kolkata',
    drop: 'Patna',
    category: GoodsCategory.textiles,
    bidAmount: 32000,
    status: _BidStatus.lost,
    truckInfo: 'Container 32ft - MH-14-EF-9012',
    time: 'Lost 3 hrs ago',
  ),
  _MockBid(
    orderId: 'ORD-1005',
    pickup: 'Lucknow',
    drop: 'Kanpur',
    category: GoodsCategory.chemicals,
    bidAmount: 12000,
    status: _BidStatus.lost,
    truckInfo: 'Tata 407 - MH-12-CD-5678',
    time: 'Lost yesterday',
  ),
];

class OwnerBidsScreen extends ConsumerStatefulWidget {
  const OwnerBidsScreen({super.key});

  @override
  ConsumerState<OwnerBidsScreen> createState() => _OwnerBidsScreenState();
}

class _OwnerBidsScreenState extends ConsumerState<OwnerBidsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

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

  List<_MockBid> _bidsForStatus(_BidStatus status) =>
      _mockBids.where((b) => b.status == status).toList();

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
                MtSpacing.xl,
                MtSpacing.lg,
                MtSpacing.xl,
                MtSpacing.md,
              ),
              child: Text('My Bids', style: MtTypography.h2),
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
                  borderRadius: BorderRadius.circular(MtBorderRadius.sm),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: const EdgeInsets.all(3),
                labelColor: MtColors.black,
                unselectedLabelColor: MtColors.textSecondary,
                labelStyle: MtTypography.labelSmall,
                unselectedLabelStyle: MtTypography.labelSmall,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(
                    child: Text(
                      'Active (${_bidsForStatus(_BidStatus.active).length})',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Won (${_bidsForStatus(_BidStatus.won).length})',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Lost (${_bidsForStatus(_BidStatus.lost).length})',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: MtSpacing.md),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _BidList(bids: _bidsForStatus(_BidStatus.active)),
                  _BidList(bids: _bidsForStatus(_BidStatus.won)),
                  _BidList(bids: _bidsForStatus(_BidStatus.lost)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BidList extends StatelessWidget {
  final List<_MockBid> bids;
  const _BidList({required this.bids});

  @override
  Widget build(BuildContext context) {
    if (bids.isEmpty) {
      return Center(
        child: Text(
          'No bids',
          style: MtTypography.body.copyWith(color: MtColors.textSecondary),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        MtSpacing.xl,
        MtSpacing.sm,
        MtSpacing.xl,
        MediaQuery.of(context).padding.bottom + 100,
      ),
      itemCount: bids.length,
      separatorBuilder: (_, __) => const SizedBox(height: MtSpacing.md),
      itemBuilder: (_, index) => _BidCard(bid: bids[index]),
    );
  }
}

class _BidCard extends StatelessWidget {
  final _MockBid bid;
  const _BidCard({required this.bid});

  @override
  Widget build(BuildContext context) {
    final (amountColor, badgeVariant, badgeLabel) = switch (bid.status) {
      _BidStatus.active => (MtColors.orange, MtBadgeVariant.warning, 'Active'),
      _BidStatus.won => (MtColors.green, MtBadgeVariant.success, 'Won'),
      _BidStatus.lost =>
        (MtColors.textTertiary, MtBadgeVariant.error, 'Lost'),
    };

    return MtCard(
      variant: MtCardVariant.surface,
      onTap: bid.status == _BidStatus.active
          ? () => context.push(Routes.ownerOrderDetail)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Order ID + Badge
          Row(
            children: [
              Text(
                bid.orderId,
                style: MtTypography.labelSmall.copyWith(
                  color: MtColors.textSecondary,
                ),
              ),
              const SizedBox(width: MtSpacing.sm),
              MtBadge(
                label: bid.category.label,
                variant: MtBadgeVariant.info,
                size: MtBadgeSize.sm,
              ),
              const Spacer(),
              MtBadge(
                label: badgeLabel,
                variant: badgeVariant,
                size: MtBadgeSize.md,
              ),
            ],
          ),

          const SizedBox(height: MtSpacing.md),

          // Route
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: MtColors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: MtSpacing.sm),
              Text(bid.pickup, style: MtTypography.body),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MtSpacing.sm),
                child: Icon(
                  Icons.arrow_forward,
                  size: 14,
                  color: MtColors.textTertiary,
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: MtColors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: MtSpacing.sm),
              Text(bid.drop, style: MtTypography.body),
            ],
          ),

          const SizedBox(height: MtSpacing.md),

          // Bid amount + truck info
          Row(
            children: [
              Text(
                '\u20B9${_formatAmount(bid.bidAmount)}',
                style: MtTypography.h4.copyWith(color: amountColor),
              ),
              const Spacer(),
              Text(
                bid.time,
                style: MtTypography.caption.copyWith(
                  color: MtColors.textTertiary,
                ),
              ),
            ],
          ),

          const SizedBox(height: MtSpacing.sm),

          // Truck info
          Row(
            children: [
              Icon(
                Icons.local_shipping_outlined,
                size: 14,
                color: MtColors.textTertiary,
              ),
              const SizedBox(width: MtSpacing.xs),
              Expanded(
                child: Text(
                  bid.truckInfo,
                  style: MtTypography.caption.copyWith(
                    color: MtColors.textTertiary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String _formatAmount(int amount) {
  final str = amount.toString();
  if (str.length <= 3) return str;
  final lastThree = str.substring(str.length - 3);
  final remaining = str.substring(0, str.length - 3);
  final formatted = remaining.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{2})+$)'),
    (m) => '${m[1]},',
  );
  return '$formatted,$lastThree';
}
