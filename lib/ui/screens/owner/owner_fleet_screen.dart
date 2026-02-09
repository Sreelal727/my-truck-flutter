import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../data/enums/enums.dart';
import '../../widgets/widgets.dart';

class _MockTruck {
  final String id;
  final TruckType type;
  final String registration;
  final String status;
  final double rating;
  final int totalTrips;

  const _MockTruck({
    required this.id,
    required this.type,
    required this.registration,
    required this.status,
    required this.rating,
    required this.totalTrips,
  });
}

class _MockDriver {
  final String id;
  final String name;
  final String phone;
  final double rating;
  final bool isAvailable;
  final String? assignedTruck;

  const _MockDriver({
    required this.id,
    required this.name,
    required this.phone,
    required this.rating,
    required this.isAvailable,
    this.assignedTruck,
  });
}

const _mockTrucks = [
  _MockTruck(
    id: 'TRK-001',
    type: TruckType.eicher17ft,
    registration: 'MH-12-AB-1234',
    status: 'Available',
    rating: 4.5,
    totalTrips: 87,
  ),
  _MockTruck(
    id: 'TRK-002',
    type: TruckType.tata407,
    registration: 'MH-12-CD-5678',
    status: 'In Transit',
    rating: 4.2,
    totalTrips: 124,
  ),
  _MockTruck(
    id: 'TRK-003',
    type: TruckType.container32ft,
    registration: 'MH-14-EF-9012',
    status: 'Maintenance',
    rating: 4.7,
    totalTrips: 56,
  ),
];

const _mockDrivers = [
  _MockDriver(
    id: 'DRV-001',
    name: 'Ramesh Yadav',
    phone: '+91 98765 11111',
    rating: 4.6,
    isAvailable: true,
    assignedTruck: 'MH-12-AB-1234',
  ),
  _MockDriver(
    id: 'DRV-002',
    name: 'Suresh Kumar',
    phone: '+91 98765 22222',
    rating: 4.3,
    isAvailable: false,
    assignedTruck: 'MH-12-CD-5678',
  ),
  _MockDriver(
    id: 'DRV-003',
    name: 'Vikram Singh',
    phone: '+91 98765 33333',
    rating: 4.8,
    isAvailable: true,
    assignedTruck: null,
  ),
];

class OwnerFleetScreen extends ConsumerStatefulWidget {
  const OwnerFleetScreen({super.key});

  @override
  ConsumerState<OwnerFleetScreen> createState() => _OwnerFleetScreenState();
}

class _OwnerFleetScreenState extends ConsumerState<OwnerFleetScreen> {
  int _selectedTab = 0; // 0 = Trucks, 1 = Drivers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MtColors.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MtColors.primary,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                _selectedTab == 0 ? 'Add truck coming soon' : 'Add driver coming soon',
              ),
              backgroundColor: MtColors.surfaceElevated,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MtBorderRadius.sm),
              ),
            ),
          );
        },
        child: Icon(
          _selectedTab == 0 ? Icons.local_shipping_rounded : Icons.person_add_rounded,
          color: MtColors.white,
        ),
      ),
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
              child: Text('My Fleet', style: MtTypography.h2),
            ),

            // Segmented control
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xl),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: MtColors.surface,
                  borderRadius: BorderRadius.circular(MtBorderRadius.md),
                ),
                child: Row(
                  children: [
                    _SegmentButton(
                      label: 'Trucks (${_mockTrucks.length})',
                      isSelected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                    ),
                    _SegmentButton(
                      label: 'Drivers (${_mockDrivers.length})',
                      isSelected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: MtSpacing.md),

            // Content
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _selectedTab == 0
                    ? _TrucksList(key: const ValueKey('trucks'))
                    : _DriversList(key: const ValueKey('drivers')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SegmentButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: isSelected ? MtColors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(MtBorderRadius.sm),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: MtTypography.labelSmall.copyWith(
              color: isSelected ? MtColors.black : MtColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _TrucksList extends StatelessWidget {
  const _TrucksList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        MtSpacing.xl,
        MtSpacing.sm,
        MtSpacing.xl,
        MediaQuery.of(context).padding.bottom + 100,
      ),
      itemCount: _mockTrucks.length,
      separatorBuilder: (_, __) => const SizedBox(height: MtSpacing.md),
      itemBuilder: (_, index) {
        final truck = _mockTrucks[index];
        return _TruckCard(truck: truck)
            .animate()
            .fadeIn(
              delay: Duration(milliseconds: 80 * index),
              duration: const Duration(milliseconds: 400),
            )
            .slideX(
              begin: 0.05,
              end: 0,
              delay: Duration(milliseconds: 80 * index),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
            );
      },
    );
  }
}

class _TruckCard extends StatelessWidget {
  final _MockTruck truck;
  const _TruckCard({required this.truck});

  @override
  Widget build(BuildContext context) {
    final (statusColor, badgeVariant) = switch (truck.status) {
      'Available' => (MtColors.green, MtBadgeVariant.success),
      'In Transit' => (MtColors.orange, MtBadgeVariant.warning),
      'Maintenance' => (MtColors.red, MtBadgeVariant.error),
      _ => (MtColors.textTertiary, MtBadgeVariant.surface),
    };

    final IconData typeIcon = switch (truck.type) {
      TruckType.tata407 => Icons.local_shipping_outlined,
      TruckType.eicher17ft => Icons.local_shipping_rounded,
      TruckType.container32ft => Icons.rv_hookup_rounded,
      _ => Icons.local_shipping_outlined,
    };

    return MtCard(
      variant: MtCardVariant.surface,
      child: Row(
        children: [
          // Truck icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: MtColors.surfaceElevated,
              borderRadius: BorderRadius.circular(MtBorderRadius.md),
            ),
            child: Icon(
              typeIcon,
              color: MtColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: MtSpacing.lg),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        truck.type.label,
                        style: MtTypography.label,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    MtBadge(
                      label: truck.status,
                      variant: badgeVariant,
                      size: MtBadgeSize.sm,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  truck.registration,
                  style: MtTypography.body.copyWith(
                    color: MtColors.textSecondary,
                  ),
                ),
                const SizedBox(height: MtSpacing.sm),
                Row(
                  children: [
                    Icon(
                      Icons.straighten_outlined,
                      size: 14,
                      color: MtColors.textTertiary,
                    ),
                    const SizedBox(width: MtSpacing.xs),
                    Text(
                      truck.type.capacity,
                      style: MtTypography.caption.copyWith(
                        color: MtColors.textTertiary,
                      ),
                    ),
                    const SizedBox(width: MtSpacing.lg),
                    const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: MtColors.yellow,
                    ),
                    const SizedBox(width: MtSpacing.xs),
                    Text(
                      truck.rating.toStringAsFixed(1),
                      style: MtTypography.caption.copyWith(
                        color: MtColors.textTertiary,
                      ),
                    ),
                    const SizedBox(width: MtSpacing.lg),
                    Icon(
                      Icons.route_outlined,
                      size: 14,
                      color: MtColors.textTertiary,
                    ),
                    const SizedBox(width: MtSpacing.xs),
                    Text(
                      '${truck.totalTrips} trips',
                      style: MtTypography.caption.copyWith(
                        color: MtColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DriversList extends StatelessWidget {
  const _DriversList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(
        MtSpacing.xl,
        MtSpacing.sm,
        MtSpacing.xl,
        MediaQuery.of(context).padding.bottom + 100,
      ),
      itemCount: _mockDrivers.length,
      separatorBuilder: (_, __) => const SizedBox(height: MtSpacing.md),
      itemBuilder: (_, index) {
        final driver = _mockDrivers[index];
        return _DriverCard(driver: driver)
            .animate()
            .fadeIn(
              delay: Duration(milliseconds: 80 * index),
              duration: const Duration(milliseconds: 400),
            )
            .slideX(
              begin: 0.05,
              end: 0,
              delay: Duration(milliseconds: 80 * index),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
            );
      },
    );
  }
}

class _DriverCard extends StatelessWidget {
  final _MockDriver driver;
  const _DriverCard({required this.driver});

  @override
  Widget build(BuildContext context) {
    return MtCard(
      variant: MtCardVariant.surface,
      child: Row(
        children: [
          // Avatar placeholder
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: MtColors.surfaceElevated,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                driver.name.split(' ').map((n) => n[0]).take(2).join(),
                style: MtTypography.label.copyWith(
                  color: MtColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: MtSpacing.lg),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            driver.name,
                            style: MtTypography.label,
                          ),
                          const SizedBox(width: MtSpacing.sm),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: driver.isAvailable
                                  ? MtColors.green
                                  : MtColors.textTertiary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  driver.phone,
                  style: MtTypography.bodySmall.copyWith(
                    color: MtColors.textSecondary,
                  ),
                ),
                const SizedBox(height: MtSpacing.sm),
                Row(
                  children: [
                    MtStarRating(rating: driver.rating, size: 14),
                    const SizedBox(width: MtSpacing.sm),
                    Text(
                      driver.rating.toStringAsFixed(1),
                      style: MtTypography.caption.copyWith(
                        color: MtColors.textTertiary,
                      ),
                    ),
                    if (driver.assignedTruck != null) ...[
                      const SizedBox(width: MtSpacing.lg),
                      Icon(
                        Icons.local_shipping_outlined,
                        size: 14,
                        color: MtColors.textTertiary,
                      ),
                      const SizedBox(width: MtSpacing.xs),
                      Text(
                        driver.assignedTruck!,
                        style: MtTypography.caption.copyWith(
                          color: MtColors.textTertiary,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
