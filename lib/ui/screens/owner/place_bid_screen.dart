import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../data/enums/enums.dart';
import '../../widgets/widgets.dart';

class _OwnerTruck {
  final String id;
  final TruckType type;
  final String registration;
  final String capacity;
  final String status;

  const _OwnerTruck({
    required this.id,
    required this.type,
    required this.registration,
    required this.capacity,
    required this.status,
  });
}

const _ownerTrucks = [
  _OwnerTruck(
    id: 'TRK-001',
    type: TruckType.eicher17ft,
    registration: 'MH-12-AB-1234',
    capacity: '7 ton',
    status: 'Available',
  ),
  _OwnerTruck(
    id: 'TRK-002',
    type: TruckType.tata407,
    registration: 'MH-12-CD-5678',
    capacity: '2.5 ton',
    status: 'Available',
  ),
  _OwnerTruck(
    id: 'TRK-003',
    type: TruckType.container32ft,
    registration: 'MH-14-EF-9012',
    capacity: '15 ton',
    status: 'In Transit',
  ),
];

class PlaceBidScreen extends ConsumerStatefulWidget {
  const PlaceBidScreen({super.key});

  @override
  ConsumerState<PlaceBidScreen> createState() => _PlaceBidScreenState();
}

class _PlaceBidScreenState extends ConsumerState<PlaceBidScreen> {
  final _bidController = TextEditingController();
  final _hoursController = TextEditingController();
  final _noteController = TextEditingController();
  String? _selectedTruckId = 'TRK-001';
  bool _driveMyself = false;

  @override
  void dispose() {
    _bidController.dispose();
    _hoursController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submitBid() {
    if (_bidController.text.isEmpty) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter a bid amount',
            style: TextStyle(color: Color(0xFFFFFFFF)),
          ),
          backgroundColor: MtColors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }
    if (_selectedTruckId == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please select a truck',
            style: TextStyle(color: Color(0xFFFFFFFF)),
          ),
          backgroundColor: MtColors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Bid submitted!',
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        backgroundColor: MtColors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 100, left: 20, right: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MtColors.background,
      appBar: AppBar(
        backgroundColor: MtColors.background,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MtColors.white),
          onPressed: () => context.pop(),
        ),
        title: Text('Place Your Bid', style: MtTypography.h4),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(MtSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order summary
                  MtCard(
                    variant: MtCardVariant.elevated,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Summary',
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
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: MtColors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  width: 1.5,
                                  height: 20,
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
                                    'Mumbai, Maharashtra',
                                    style: MtTypography.bodySmall,
                                  ),
                                  const SizedBox(height: MtSpacing.md),
                                  Text(
                                    'Pune, Maharashtra',
                                    style: MtTypography.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: MtSpacing.md),
                        Row(
                          children: [
                            const MtBadge(
                              label: 'Construction Material',
                              variant: MtBadgeVariant.info,
                              size: MtBadgeSize.sm,
                            ),
                            const SizedBox(width: MtSpacing.sm),
                            Text(
                              '8,500 kg',
                              style: MtTypography.bodySmall.copyWith(
                                color: MtColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: MtSpacing.xxl),

                  // Bid Amount
                  Text(
                    'Your Bid Amount',
                    style: MtTypography.label,
                  ),
                  const SizedBox(height: MtSpacing.sm),
                  MtInput(
                    placeholder: 'Enter amount',
                    controller: _bidController,
                    keyboardType: TextInputType.number,
                    prefix: Text(
                      '\u20B9',
                      style: MtTypography.h4.copyWith(
                        color: MtColors.textSecondary,
                      ),
                    ),
                  ),

                  const SizedBox(height: MtSpacing.xxl),

                  // Select Truck
                  Text(
                    'Select Truck',
                    style: MtTypography.label,
                  ),
                  const SizedBox(height: MtSpacing.md),
                  ...List.generate(_ownerTrucks.length, (index) {
                    final truck = _ownerTrucks[index];
                    final isSelected = _selectedTruckId == truck.id;
                    final isAvailable = truck.status == 'Available';
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index < _ownerTrucks.length - 1
                            ? MtSpacing.md
                            : 0,
                      ),
                      child: GestureDetector(
                        onTap: isAvailable
                            ? () =>
                                setState(() => _selectedTruckId = truck.id)
                            : null,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(MtSpacing.lg),
                          decoration: BoxDecoration(
                            color: MtColors.surface,
                            borderRadius:
                                BorderRadius.circular(MtBorderRadius.lg),
                            border: Border.all(
                              color: isSelected
                                  ? MtColors.primary
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Opacity(
                            opacity: isAvailable ? 1.0 : 0.5,
                            child: Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: MtColors.surfaceElevated,
                                    borderRadius: BorderRadius.circular(
                                      MtBorderRadius.md,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.local_shipping_rounded,
                                    color: MtColors.primary,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: MtSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        truck.type.label,
                                        style: MtTypography.label,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${truck.registration}  |  ${truck.capacity}',
                                        style: MtTypography.caption.copyWith(
                                          color: MtColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                MtBadge(
                                  label: truck.status,
                                  variant: isAvailable
                                      ? MtBadgeVariant.success
                                      : MtBadgeVariant.warning,
                                  size: MtBadgeSize.sm,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: MtSpacing.xxl),

                  // Estimated delivery hours
                  Text(
                    'Estimated Delivery Hours',
                    style: MtTypography.label,
                  ),
                  const SizedBox(height: MtSpacing.sm),
                  MtInput(
                    placeholder: 'e.g. 6',
                    controller: _hoursController,
                    keyboardType: TextInputType.number,
                    suffix: Text(
                      'hrs',
                      style: MtTypography.bodySmall.copyWith(
                        color: MtColors.textTertiary,
                      ),
                    ),
                  ),

                  const SizedBox(height: MtSpacing.xxl),

                  // Drive myself toggle
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: MtSpacing.lg,
                      vertical: MtSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: MtColors.surface,
                      borderRadius:
                          BorderRadius.circular(MtBorderRadius.lg),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "I'll drive myself",
                                style: MtTypography.label,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Skip driver selection',
                                style: MtTypography.caption.copyWith(
                                  color: MtColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _driveMyself,
                          onChanged: (val) =>
                              setState(() => _driveMyself = val),
                          activeThumbColor: MtColors.primary,
                          activeTrackColor:
                              MtColors.primary.withValues(alpha: 0.3),
                          inactiveThumbColor: MtColors.textTertiary,
                          inactiveTrackColor: MtColors.surfaceElevated,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: MtSpacing.xxl),

                  // Add Note
                  Text(
                    'Add Note (Optional)',
                    style: MtTypography.label,
                  ),
                  const SizedBox(height: MtSpacing.sm),
                  MtInput(
                    placeholder: 'Any additional notes for the shipper...',
                    controller: _noteController,
                    multiline: true,
                    maxLines: 4,
                  ),

                  const SizedBox(height: MtSpacing.xxxl),
                ],
              ),
            ),
          ),

          // Submit button
          Container(
            padding: EdgeInsets.fromLTRB(
              MtSpacing.xl,
              MtSpacing.lg,
              MtSpacing.xl,
              MediaQuery.of(context).padding.bottom + MtSpacing.lg,
            ),
            decoration: const BoxDecoration(
              color: MtColors.background,
              border: Border(
                top: BorderSide(
                  color: MtColors.border,
                  width: 0.5,
                ),
              ),
            ),
            child: MtButton(
              title: 'Submit Bid',
              onPressed: _submitBid,
            ),
          ),
        ],
      ),
    );
  }
}
