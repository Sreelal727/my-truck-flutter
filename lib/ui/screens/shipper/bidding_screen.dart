import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../router/routes.dart';
import '../../widgets/widgets.dart';

class _MockBid {
  final String ownerName;
  final double rating;
  final String truckType;
  final String registration;
  final double amount;
  final int estimatedHours;

  const _MockBid({
    required this.ownerName,
    required this.rating,
    required this.truckType,
    required this.registration,
    required this.amount,
    required this.estimatedHours,
  });
}

class BiddingScreen extends ConsumerStatefulWidget {
  const BiddingScreen({super.key});

  @override
  ConsumerState<BiddingScreen> createState() => _BiddingScreenState();
}

class _BiddingScreenState extends ConsumerState<BiddingScreen> {
  int _selectedSort = 0;
  late Timer _timer;
  int _remainingSeconds = 45 * 60 + 23; // 45:23

  final _sortOptions = ['Lowest Price', 'Highest Rated', 'Fastest'];

  final _mockBids = const [
    _MockBid(
      ownerName: 'Amit Patel',
      rating: 4.7,
      truckType: 'Eicher 17ft',
      registration: 'MH 12 AB 1234',
      amount: 18500,
      estimatedHours: 5,
    ),
    _MockBid(
      ownerName: 'Vikram Singh',
      rating: 4.6,
      truckType: 'Tata 407',
      registration: 'RJ 14 EF 9012',
      amount: 16000,
      estimatedHours: 6,
    ),
    _MockBid(
      ownerName: 'Suresh Reddy',
      rating: 4.3,
      truckType: 'Container 32ft',
      registration: 'KA 01 CD 5678',
      amount: 20000,
      estimatedHours: 5,
    ),
    _MockBid(
      ownerName: 'Manoj Tiwari',
      rating: 4.5,
      truckType: 'Eicher 14ft',
      registration: 'UP 32 GH 3456',
      amount: 15000,
      estimatedHours: 7,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MtColors.background,
      appBar: AppBar(
        backgroundColor: MtColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_rounded, color: MtColors.white),
        ),
        title: Text('Bids', style: MtTypography.h4),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Order summary card
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MtSpacing.xl,
              vertical: MtSpacing.sm,
            ),
            child: MtCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      Text(
                        'Andheri East, Mumbai',
                        style: MtTypography.bodySmall,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Container(
                      width: 2,
                      height: 12,
                      color: MtColors.surfaceHighlight,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: MtColors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: MtSpacing.sm),
                      Text(
                        'Hinjewadi, Pune',
                        style: MtTypography.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: MtSpacing.md),
                  Row(
                    children: [
                      const MtBadge(
                        label: 'Electronics',
                        variant: MtBadgeVariant.surface,
                      ),
                      const SizedBox(width: MtSpacing.sm),
                      const MtBadge(
                        label: 'Eicher 17ft',
                        variant: MtBadgeVariant.surface,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 300.ms),

          // Countdown timer
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MtSpacing.xl,
              vertical: MtSpacing.md,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: MtSpacing.lg,
                vertical: MtSpacing.md,
              ),
              decoration: BoxDecoration(
                color: MtColors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(MtBorderRadius.md),
                border: Border.all(
                  color: MtColors.orange.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    color: MtColors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: MtSpacing.sm),
                  Text(
                    'Bidding ends in ',
                    style: MtTypography.label.copyWith(
                      color: MtColors.orange,
                    ),
                  ),
                  Text(
                    _formattedTime,
                    style: MtTypography.h4.copyWith(
                      color: MtColors.orange,
                    ),
                  )
                      .animate(
                        onPlay: (c) => c.repeat(reverse: true),
                      )
                      .scaleXY(
                        begin: 1.0,
                        end: 1.05,
                        duration: 800.ms,
                      ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 300.ms),

          // Sort pills
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MtSpacing.xl,
              vertical: MtSpacing.sm,
            ),
            child: Row(
              children: List.generate(_sortOptions.length, (index) {
                final isSelected = _selectedSort == index;
                return Padding(
                  padding: const EdgeInsets.only(right: MtSpacing.sm),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedSort = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: MtSpacing.md,
                        vertical: MtSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? MtColors.white
                            : MtColors.surface,
                        borderRadius: BorderRadius.circular(MtBorderRadius.full),
                      ),
                      child: Text(
                        _sortOptions[index],
                        style: MtTypography.labelSmall.copyWith(
                          color: isSelected
                              ? MtColors.black
                              : MtColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 300.ms),

          const SizedBox(height: MtSpacing.sm),

          // Bid list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xl),
              itemCount: _mockBids.length,
              itemBuilder: (context, index) {
                final bid = _mockBids[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: MtSpacing.md),
                  child: MtCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Avatar placeholder
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: MtColors.surfaceElevated,
                                borderRadius: BorderRadius.circular(
                                  MtBorderRadius.full,
                                ),
                              ),
                              child: const Icon(
                                Icons.person_rounded,
                                color: MtColors.textSecondary,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: MtSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bid.ownerName,
                                    style: MtTypography.label,
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      MtStarRating(
                                        rating: bid.rating,
                                        size: 14,
                                      ),
                                      const SizedBox(width: MtSpacing.xs),
                                      Text(
                                        bid.rating.toString(),
                                        style: MtTypography.caption.copyWith(
                                          color: MtColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\u20B9${bid.amount.toInt().toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                                  style: MtTypography.h3.copyWith(
                                    color: MtColors.green,
                                  ),
                                ),
                                Text(
                                  '~${bid.estimatedHours} hrs',
                                  style: MtTypography.caption.copyWith(
                                    color: MtColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: MtSpacing.md),
                        Row(
                          children: [
                            Icon(
                              Icons.local_shipping_outlined,
                              color: MtColors.textSecondary,
                              size: 16,
                            ),
                            const SizedBox(width: MtSpacing.xs),
                            Text(
                              '${bid.truckType} \u2022 ${bid.registration}',
                              style: MtTypography.bodySmall.copyWith(
                                color: MtColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: MtSpacing.md),
                        Align(
                          alignment: Alignment.centerRight,
                          child: MtButton(
                            title: 'Accept Bid',
                            size: MtButtonSize.sm,
                            fullWidth: false,
                            onPressed: () {
                              context.pushReplacement(
                                Routes.shipperOrderConfirmed,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(
                      delay: Duration(milliseconds: 300 + index * 100),
                      duration: 400.ms,
                    ).slideY(begin: 0.1, end: 0);
              },
            ),
          ),
        ],
      ),
    );
  }
}
