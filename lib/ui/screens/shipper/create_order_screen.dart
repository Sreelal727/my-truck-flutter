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

class CreateOrderScreen extends ConsumerStatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  ConsumerState<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends ConsumerState<CreateOrderScreen> {
  final _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 5;

  // Step 1: Route
  final _pickupController = TextEditingController();
  final _dropController = TextEditingController();

  // Step 2: Load Details
  GoodsCategory? _selectedCategory;
  final _weightController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Step 3: Truck Type
  TruckType? _selectedTruckType;

  // Step 4: Schedule
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  final List<String> _stepLabels = [
    'Route',
    'Load Details',
    'Truck Type',
    'Schedule',
    'Review',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _pickupController.dispose();
    _dropController.dispose();
    _weightController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Post Load
      context.pushReplacement(Routes.shipperBidding);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MtSpacing.sm, MtSpacing.md, MtSpacing.xl, MtSpacing.md,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _prevStep,
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: MtColors.white,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _stepLabels[_currentStep],
                      style: MtTypography.h4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // Step indicator
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: MtSpacing.xxxl,
                vertical: MtSpacing.md,
              ),
              child: _buildStepIndicator(),
            ),

            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildRouteStep(),
                  _buildLoadDetailsStep(),
                  _buildTruckTypeStep(),
                  _buildScheduleStep(),
                  _buildReviewStep(),
                ],
              ),
            ),

            // Bottom buttons
            Padding(
              padding: const EdgeInsets.all(MtSpacing.xl),
              child: Column(
                children: [
                  MtButton(
                    title: _currentStep == _totalSteps - 1
                        ? 'Post Load'
                        : 'Next',
                    onPressed: _nextStep,
                  ),
                  if (_currentStep > 0) ...[
                    const SizedBox(height: MtSpacing.md),
                    MtButton(
                      title: 'Back',
                      variant: MtButtonVariant.ghost,
                      onPressed: _prevStep,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_totalSteps * 2 - 1, (index) {
        if (index.isOdd) {
          // Line between dots
          final stepBefore = index ~/ 2;
          return Expanded(
            child: Container(
              height: 2,
              color: stepBefore < _currentStep
                  ? MtColors.green
                  : MtColors.surfaceHighlight,
            ),
          );
        }
        // Dot
        final step = index ~/ 2;
        final isCompleted = step < _currentStep;
        final isCurrent = step == _currentStep;

        Color bgColor;
        Color borderColor;
        Widget? child;

        if (isCompleted) {
          bgColor = MtColors.green;
          borderColor = MtColors.green;
          child = const Icon(Icons.check, size: 14, color: MtColors.black);
        } else if (isCurrent) {
          bgColor = MtColors.primary;
          borderColor = MtColors.primary;
          child = Text(
            '${step + 1}',
            style: const TextStyle(
              color: MtColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          );
        } else {
          bgColor = MtColors.surfaceHighlight;
          borderColor = MtColors.surfaceHighlight;
          child = Text(
            '${step + 1}',
            style: const TextStyle(
              color: MtColors.textTertiary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          );
        }

        return Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 2),
          ),
          alignment: Alignment.center,
          child: child,
        );
      }),
    );
  }

  // ─── Step 1: Route ──────────────────────────────────────────────────────────
  Widget _buildRouteStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(MtSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Where is your shipment going?',
            style: MtTypography.h3,
          ).animate().fadeIn(duration: 300.ms),
          const SizedBox(height: MtSpacing.xxl),
          MtInput(
            label: 'Pickup Address',
            placeholder: 'Enter pickup location',
            controller: _pickupController,
            prefix: const Icon(
              Icons.trip_origin_rounded,
              color: MtColors.green,
              size: 20,
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 300.ms).slideX(begin: 0.05, end: 0),
          const SizedBox(height: MtSpacing.xl),
          MtInput(
            label: 'Drop Address',
            placeholder: 'Enter drop location',
            controller: _dropController,
            prefix: const Icon(
              Icons.location_on_rounded,
              color: MtColors.red,
              size: 20,
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 300.ms).slideX(begin: 0.05, end: 0),
        ],
      ),
    );
  }

  // ─── Step 2: Load Details ───────────────────────────────────────────────────
  Widget _buildLoadDetailsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(MtSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What are you shipping?',
            style: MtTypography.h3,
          ).animate().fadeIn(duration: 300.ms),
          const SizedBox(height: MtSpacing.xxl),
          Text(
            'Goods Category',
            style: MtTypography.labelSmall.copyWith(
              color: MtColors.textSecondary,
            ),
          ),
          const SizedBox(height: MtSpacing.md),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: MtSpacing.sm,
              mainAxisSpacing: MtSpacing.sm,
              childAspectRatio: 1.05,
            ),
            itemCount: GoodsCategory.values.length,
            itemBuilder: (context, index) {
              final category = GoodsCategory.values[index];
              final isSelected = _selectedCategory == category;
              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = category),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? MtColors.primary.withValues(alpha: 0.1)
                        : MtColors.surface,
                    borderRadius: BorderRadius.circular(MtBorderRadius.md),
                    border: Border.all(
                      color: isSelected ? MtColors.primary : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  padding: const EdgeInsets.all(MtSpacing.sm),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        category.icon,
                        color: isSelected
                            ? MtColors.primary
                            : MtColors.textSecondary,
                        size: 24,
                      ),
                      const SizedBox(height: MtSpacing.xs),
                      Text(
                        category.label,
                        style: MtTypography.caption.copyWith(
                          color: isSelected
                              ? MtColors.primary
                              : MtColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: MtSpacing.xl),
          MtInput(
            label: 'Weight (kg)',
            placeholder: 'Enter weight in kg',
            controller: _weightController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: MtSpacing.xl),
          MtInput(
            label: 'Description',
            placeholder: 'Describe your goods',
            controller: _descriptionController,
            multiline: true,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  // ─── Step 3: Truck Type ─────────────────────────────────────────────────────
  Widget _buildTruckTypeStep() {
    return ListView(
      padding: const EdgeInsets.all(MtSpacing.xl),
      children: [
        Text(
          'Select truck type',
          style: MtTypography.h3,
        ).animate().fadeIn(duration: 300.ms),
        const SizedBox(height: MtSpacing.xxl),
        ...TruckType.values.map((type) {
          final isSelected = _selectedTruckType == type;
          return Padding(
            padding: const EdgeInsets.only(bottom: MtSpacing.sm),
            child: GestureDetector(
              onTap: () => setState(() => _selectedTruckType = type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: MtSpacing.lg,
                  vertical: MtSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? MtColors.primary : MtColors.surface,
                  borderRadius: BorderRadius.circular(MtBorderRadius.md),
                  border: Border.all(
                    color: isSelected
                        ? MtColors.primary
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        type.label,
                        style: MtTypography.label.copyWith(
                          color: isSelected
                              ? MtColors.white
                              : MtColors.textPrimary,
                        ),
                      ),
                    ),
                    Text(
                      type.capacity,
                      style: MtTypography.bodySmall.copyWith(
                        color: isSelected
                            ? MtColors.white.withValues(alpha: 0.8)
                            : MtColors.textSecondary,
                      ),
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: MtSpacing.sm),
                      const Icon(
                        Icons.check_circle_rounded,
                        color: MtColors.white,
                        size: 20,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // ─── Step 4: Schedule ───────────────────────────────────────────────────────
  Widget _buildScheduleStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(MtSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'When should it be picked up?',
            style: MtTypography.h3,
          ).animate().fadeIn(duration: 300.ms),
          const SizedBox(height: MtSpacing.xxl),
          MtInput(
            label: 'Pickup Date',
            placeholder: 'DD/MM/YYYY',
            controller: _dateController,
            prefix: const Icon(
              Icons.calendar_today_rounded,
              color: MtColors.textSecondary,
              size: 20,
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 300.ms).slideX(begin: 0.05, end: 0),
          const SizedBox(height: MtSpacing.xl),
          MtInput(
            label: 'Pickup Time',
            placeholder: 'HH:MM AM/PM',
            controller: _timeController,
            prefix: const Icon(
              Icons.access_time_rounded,
              color: MtColors.textSecondary,
              size: 20,
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 300.ms).slideX(begin: 0.05, end: 0),
        ],
      ),
    );
  }

  // ─── Step 5: Review ─────────────────────────────────────────────────────────
  Widget _buildReviewStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(MtSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review your order',
            style: MtTypography.h3,
          ).animate().fadeIn(duration: 300.ms),
          const SizedBox(height: MtSpacing.xxl),

          // Route card
          MtCard(
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
                _buildReviewRow(
                  Icons.trip_origin_rounded,
                  MtColors.green,
                  _pickupController.text.isEmpty
                      ? 'Pickup address'
                      : _pickupController.text,
                ),
                const SizedBox(height: MtSpacing.sm),
                _buildReviewRow(
                  Icons.location_on_rounded,
                  MtColors.red,
                  _dropController.text.isEmpty
                      ? 'Drop address'
                      : _dropController.text,
                ),
              ],
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 300.ms).slideY(begin: 0.05, end: 0),

          const SizedBox(height: MtSpacing.md),

          // Load details card
          MtCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Load Details',
                  style: MtTypography.labelSmall.copyWith(
                    color: MtColors.textSecondary,
                  ),
                ),
                const SizedBox(height: MtSpacing.md),
                _buildReviewDetailRow(
                  'Category',
                  _selectedCategory?.label ?? 'Not selected',
                ),
                _buildReviewDetailRow(
                  'Weight',
                  _weightController.text.isEmpty
                      ? 'Not specified'
                      : '${_weightController.text} kg',
                ),
                _buildReviewDetailRow(
                  'Description',
                  _descriptionController.text.isEmpty
                      ? 'No description'
                      : _descriptionController.text,
                ),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 300.ms).slideY(begin: 0.05, end: 0),

          const SizedBox(height: MtSpacing.md),

          // Truck type card
          MtCard(
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
                _buildReviewDetailRow(
                  'Type',
                  _selectedTruckType?.label ?? 'Not selected',
                ),
                _buildReviewDetailRow(
                  'Capacity',
                  _selectedTruckType?.capacity ?? '-',
                ),
              ],
            ),
          ).animate().fadeIn(delay: 300.ms, duration: 300.ms).slideY(begin: 0.05, end: 0),

          const SizedBox(height: MtSpacing.md),

          // Schedule card
          MtCard(
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
                _buildReviewDetailRow(
                  'Date',
                  _dateController.text.isEmpty
                      ? 'Not set'
                      : _dateController.text,
                ),
                _buildReviewDetailRow(
                  'Time',
                  _timeController.text.isEmpty
                      ? 'Not set'
                      : _timeController.text,
                ),
              ],
            ),
          ).animate().fadeIn(delay: 400.ms, duration: 300.ms).slideY(begin: 0.05, end: 0),
        ],
      ),
    );
  }

  Widget _buildReviewRow(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: MtSpacing.md),
        Expanded(
          child: Text(
            text,
            style: MtTypography.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MtSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: MtTypography.bodySmall.copyWith(
                color: MtColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: MtTypography.body,
            ),
          ),
        ],
      ),
    );
  }
}
