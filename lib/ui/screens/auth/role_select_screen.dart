import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../data/enums/user_role.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/routes.dart';
import '../../widgets/widgets.dart';

class RoleSelectScreen extends ConsumerStatefulWidget {
  const RoleSelectScreen({super.key});

  @override
  ConsumerState<RoleSelectScreen> createState() => _RoleSelectScreenState();
}

class _RoleSelectScreenState extends ConsumerState<RoleSelectScreen> {
  UserRole? _selectedRole;

  void _onContinue() {
    if (_selectedRole == null) return;
    ref.read(authProvider.notifier).selectRole(_selectedRole!);
    context.go(Routes.profileSetup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: MtSpacing.xxxxl + MtSpacing.xxxxl),

              // Title
              Text(
                'Choose your role',
                style: MtTypography.h2,
              ),
              const SizedBox(height: MtSpacing.sm),

              // Subtitle
              Text(
                'How will you use My Truck?',
                style: MtTypography.body.copyWith(
                  color: MtColors.textSecondary,
                ),
              ),
              const SizedBox(height: MtSpacing.xxxxl),

              // Role cards
              ...UserRole.values.asMap().entries.map((entry) {
                final index = entry.key;
                final role = entry.value;
                final isSelected = _selectedRole == role;

                return Padding(
                  padding: const EdgeInsets.only(bottom: MtSpacing.md),
                  child: Hero(
                    tag: 'role-${role.name}',
                    child: Material(
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedRole = role),
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
                          child: Row(
                            children: [
                              // Icon
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? MtColors.primary.withValues(alpha: 0.15)
                                      : MtColors.surfaceElevated,
                                  borderRadius: BorderRadius.circular(
                                      MtBorderRadius.md),
                                ),
                                child: Icon(
                                  role.icon,
                                  color: isSelected
                                      ? MtColors.primary
                                      : MtColors.textSecondary,
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: MtSpacing.lg),

                              // Text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      role.label,
                                      style: MtTypography.h4,
                                    ),
                                    const SizedBox(height: MtSpacing.xs),
                                    Text(
                                      role.description,
                                      style:
                                          MtTypography.bodySmall.copyWith(
                                        color: MtColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Check indicator
                              if (isSelected)
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    color: MtColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check_rounded,
                                    color: MtColors.white,
                                    size: 16,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: 100 * index),
                      duration: const Duration(milliseconds: 400),
                    )
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      delay: Duration(milliseconds: 100 * index),
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                    );
              }),

              const Spacer(),

              // Continue button
              MtButton(
                title: 'Continue',
                onPressed: _selectedRole != null ? _onContinue : null,
              ),
              const SizedBox(height: MtSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
