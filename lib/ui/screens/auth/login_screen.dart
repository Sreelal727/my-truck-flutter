import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/routes.dart';
import '../../widgets/widgets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    final phone = _phoneController.text.trim();
    if (phone.length != 10) return;
    await ref.read(authProvider.notifier).sendOtp('+91$phone');
    if (mounted) {
      context.go(Routes.verifyOtp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final phoneText = _phoneController.text.trim();
    final isValid = phoneText.length == 10;

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
                'Welcome back',
                style: MtTypography.h2,
              ),
              const SizedBox(height: MtSpacing.sm),

              // Subtitle
              Text(
                'Enter your phone number to continue',
                style: MtTypography.body.copyWith(
                  color: MtColors.textSecondary,
                ),
              ),
              const SizedBox(height: MtSpacing.xxxxl),

              // Phone input
              MtInput(
                label: 'Phone Number',
                placeholder: '98765 43210',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                onChanged: (_) => setState(() {}),
                prefix: Text(
                  '+91',
                  style: MtTypography.body.copyWith(
                    color: MtColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Spacer(),

              // Continue button
              MtButton(
                title: 'Continue',
                onPressed: isValid && !authState.isLoading ? _sendOtp : null,
                loading: authState.isLoading,
              ),
              const SizedBox(height: MtSpacing.lg),

              // Terms text
              Center(
                child: Text(
                  'By continuing, you agree to our Terms & Privacy Policy',
                  style: MtTypography.caption.copyWith(
                    color: MtColors.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: MtSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
