import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../router/routes.dart';
import '../../widgets/widgets.dart';

class OrderConfirmedScreen extends ConsumerWidget {
  const OrderConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(MtSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Green checkmark circle
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: MtColors.green.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: MtColors.green,
                  size: 64,
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.0, 0.0),
                    end: const Offset(1.0, 1.0),
                    duration: 500.ms,
                    curve: Curves.elasticOut,
                  )
                  .fadeIn(duration: 300.ms),

              const SizedBox(height: MtSpacing.xxl),

              // Title
              Text(
                'Order Confirmed!',
                style: MtTypography.h2,
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms).slideY(begin: 0.2, end: 0),

              const SizedBox(height: MtSpacing.md),

              // Subtitle
              Text(
                'Your order has been confirmed and the truck owner has been notified.',
                style: MtTypography.body.copyWith(
                  color: MtColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 400.ms, duration: 400.ms).slideY(begin: 0.2, end: 0),

              const SizedBox(height: MtSpacing.xxxl),

              // Order summary card
              MtCard(
                child: Column(
                  children: [
                    _buildSummaryRow('Order ID', 'ORD-1001'),
                    const SizedBox(height: MtSpacing.md),
                    _buildSummaryRow('Route', 'Mumbai \u2192 Pune'),
                    const SizedBox(height: MtSpacing.md),
                    _buildSummaryRow('Amount', '\u20B918,500'),
                    const SizedBox(height: MtSpacing.md),
                    _buildSummaryRow('Truck', 'Eicher 17ft \u2022 MH 12 AB 1234'),
                    const SizedBox(height: MtSpacing.md),
                    _buildSummaryRow('Owner', 'Amit Patel'),
                  ],
                ),
              ).animate().fadeIn(delay: 500.ms, duration: 400.ms).slideY(begin: 0.15, end: 0),

              const Spacer(),

              // Buttons
              MtButton(
                title: 'Track Order',
                onPressed: () => context.pushReplacement(Routes.shipperTracking),
              ).animate().fadeIn(delay: 600.ms, duration: 400.ms),

              const SizedBox(height: MtSpacing.md),

              MtButton(
                title: 'Back to Home',
                variant: MtButtonVariant.ghost,
                onPressed: () => context.go(Routes.shipperHome),
              ).animate().fadeIn(delay: 700.ms, duration: 400.ms),

              const SizedBox(height: MtSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: MtTypography.bodySmall.copyWith(
            color: MtColors.textSecondary,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: MtTypography.label,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
