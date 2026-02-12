import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../data/enums/enums.dart';
import '../../widgets/widgets.dart';

class DriverHomeScreen extends ConsumerStatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  ConsumerState<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends ConsumerState<DriverHomeScreen> {
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

  // Mock: whether there is an active trip
  final bool _hasActiveTrip = true;

  // Mock trip data
  final String _tripId = 'TRP-2024-08142';
  final TripStatus _currentStatus = TripStatus.inTransit;
  final String _pickupAddress = 'Warehouse 5, MIDC Andheri, Mumbai';
  final String _dropAddress = 'Rajiv Gandhi IT Park, Hinjewadi, Pune';
  final String _truckNumber = 'MH-04-AB-1234';
  final String _truckType = 'Tata 407';
  final String _ownerName = 'Amit Patel';
  final String _ownerPhone = '+91 98765 12345';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MtColors.background,
      body: _hasActiveTrip ? _buildActiveTrip(context) : _buildEmptyState(context),
    );
  }

  // ─── Empty State ──────────────────────────────────────────────────────
  Widget _buildEmptyState(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xxxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: MtColors.surface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_shipping_outlined,
                  size: 48,
                  color: MtColors.textTertiary,
                ),
              ),
              const SizedBox(height: MtSpacing.xxl),
              Text(
                'No Active Trip',
                style: MtTypography.h3,
              ),
              const SizedBox(height: MtSpacing.sm),
              Text(
                'Wait for your truck owner to assign a trip',
                style: MtTypography.body.copyWith(
                  color: MtColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Active Trip ──────────────────────────────────────────────────────
  Widget _buildActiveTrip(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
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
                // Header: Trip ID + Status Badge
                _buildTripHeader(),
                const SizedBox(height: MtSpacing.lg),

                // Route Card
                _buildRouteCard(),
                const SizedBox(height: MtSpacing.lg),

                // Truck Info Card
                _buildTruckInfoCard(),
                const SizedBox(height: MtSpacing.lg),

                // Status Timeline
                _buildTimelineCard(),
                const SizedBox(height: MtSpacing.lg),

                // Action Buttons
                _buildActionButtons(),
                const SizedBox(height: MtSpacing.lg),

                // Contact Info Card
                _buildContactCard(),
                const SizedBox(height: MtSpacing.xxxl),
              ],
            ),
          ),
        ),

        // SOS Button
        Positioned(
          bottom: 100 + MediaQuery.of(context).padding.bottom,
          right: MtSpacing.lg,
          child: _buildSosButton(),
        ),
      ],
    );
  }

  // ─── Trip Header ──────────────────────────────────────────────────────
  Widget _buildTripHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Trip',
              style: MtTypography.h2,
            ),
            const SizedBox(height: MtSpacing.xs),
            Text(
              _tripId,
              style: MtTypography.bodySmall.copyWith(
                color: MtColors.textSecondary,
              ),
            ),
          ],
        ),
        MtBadge(
          label: _currentStatus.label,
          variant: _badgeVariantForStatus(_currentStatus),
          size: MtBadgeSize.md,
        ),
      ],
    );
  }

  // ─── Route Card ───────────────────────────────────────────────────────
  Widget _buildRouteCard() {
    return MtCard(
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
          // Pickup
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    width: 2,
                    height: 32,
                    color: MtColors.surfaceHighlight,
                  ),
                ],
              ),
              const SizedBox(width: MtSpacing.md),
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
                    const SizedBox(height: 2),
                    Text(
                      _pickupAddress,
                      style: MtTypography.body,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Drop
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: MtColors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: MtSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Drop',
                      style: MtTypography.caption.copyWith(
                        color: MtColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _dropAddress,
                      style: MtTypography.body,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Truck Info Card ──────────────────────────────────────────────────
  Widget _buildTruckInfoCard() {
    return MtCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: MtColors.surfaceElevated,
              borderRadius: BorderRadius.circular(MtBorderRadius.md),
            ),
            child: const Icon(
              Icons.local_shipping_outlined,
              color: MtColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: MtSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _truckNumber,
                  style: MtTypography.label,
                ),
                const SizedBox(height: 2),
                Text(
                  _truckType,
                  style: MtTypography.bodySmall.copyWith(
                    color: MtColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Timeline Card ────────────────────────────────────────────────────
  Widget _buildTimelineCard() {
    return MtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trip Progress',
            style: MtTypography.labelSmall.copyWith(
              color: MtColors.textSecondary,
            ),
          ),
          const SizedBox(height: MtSpacing.lg),
          MtStatusTimeline(
            steps: const [
              TimelineStep(
                label: 'Assigned',
                time: '10:00 AM',
                completed: true,
              ),
              TimelineStep(
                label: 'Pickup Reached',
                time: '11:30 AM',
                completed: true,
              ),
              TimelineStep(
                label: 'Loading',
                time: '11:45 AM',
                completed: true,
              ),
              TimelineStep(
                label: 'In Transit',
                active: true,
              ),
              TimelineStep(
                label: 'Destination Reached',
              ),
              TimelineStep(
                label: 'Unloading',
              ),
              TimelineStep(
                label: 'Delivered',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Action Buttons ───────────────────────────────────────────────────
  Widget _buildActionButtons() {
    return Column(
      children: [
        MtButton(
          title: 'Update Status: Destination Reached',
          onPressed: () {
            _showSnack(context, 'Status updated to: Destination Reached');
          },
          icon: const Icon(
            Icons.check_circle_outline,
            size: 20,
            color: MtColors.black,
          ),
        ),
        const SizedBox(height: MtSpacing.md),
        MtButton(
          title: 'Upload POD',
          variant: MtButtonVariant.outline,
          onPressed: () {
            _showSnack(context, 'Camera for POD coming soon');
          },
          icon: const Icon(
            Icons.upload_file_outlined,
            size: 20,
            color: MtColors.white,
          ),
        ),
      ],
    );
  }

  // ─── Contact Card ─────────────────────────────────────────────────────
  Widget _buildContactCard() {
    return MtCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Truck Owner',
            style: MtTypography.labelSmall.copyWith(
              color: MtColors.textSecondary,
            ),
          ),
          const SizedBox(height: MtSpacing.md),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: MtColors.surfaceElevated,
                child: const Icon(
                  Icons.person_outline_rounded,
                  size: 20,
                  color: MtColors.textSecondary,
                ),
              ),
              const SizedBox(width: MtSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _ownerName,
                      style: MtTypography.label,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _ownerPhone,
                      style: MtTypography.bodySmall.copyWith(
                        color: MtColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Call button
              GestureDetector(
                onTap: () {
                  _showSnack(context, 'Calling Amit Patel...');
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: MtColors.green.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.phone_outlined,
                    size: 20,
                    color: MtColors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── SOS Button ───────────────────────────────────────────────────────
  Widget _buildSosButton() {
    return GestureDetector(
      onTap: () {
        // TODO: Implement SOS emergency action
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: MtColors.surface,
            title: Text(
              'Emergency SOS',
              style: MtTypography.h4.copyWith(color: MtColors.red),
            ),
            content: Text(
              'This will alert the truck owner and emergency services. Do you want to proceed?',
              style: MtTypography.body.copyWith(
                color: MtColors.textSecondary,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(
                  'Cancel',
                  style: MtTypography.label.copyWith(
                    color: MtColors.textSecondary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  // TODO: Trigger SOS
                },
                child: Text(
                  'Send SOS',
                  style: MtTypography.label.copyWith(color: MtColors.red),
                ),
              ),
            ],
          ),
        );
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: MtColors.red,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: MtColors.red.withValues(alpha: 0.4),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'SOS',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: MtColors.white,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  // ─── Helpers ──────────────────────────────────────────────────────────
  MtBadgeVariant _badgeVariantForStatus(TripStatus status) {
    return switch (status) {
      TripStatus.assigned => MtBadgeVariant.info,
      TripStatus.pickupReached => MtBadgeVariant.info,
      TripStatus.loading => MtBadgeVariant.warning,
      TripStatus.inTransit => MtBadgeVariant.info,
      TripStatus.destinationReached => MtBadgeVariant.warning,
      TripStatus.unloading => MtBadgeVariant.warning,
      TripStatus.delivered => MtBadgeVariant.success,
      TripStatus.completed => MtBadgeVariant.success,
    };
  }
}
