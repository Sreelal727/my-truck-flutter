import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/typography.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/routes.dart';
import '../../widgets/widgets.dart';

class VerifyOtpScreen extends ConsumerStatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  ConsumerState<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends ConsumerState<VerifyOtpScreen> {
  final _otpController = TextEditingController();
  String _otp = '';

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    if (_otp.length != 6) return;
    await ref.read(authProvider.notifier).verifyOtp(_otp);
    if (!mounted) return;
    final status = ref.read(authProvider).status;
    if (status == AuthStatus.roleSelect) {
      context.go(Routes.roleSelect);
    }
  }

  Future<void> _resendOtp() async {
    final phone = ref.read(authProvider).phone;
    if (phone != null) {
      await ref.read(authProvider.notifier).sendOtp(phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final phone = authState.phone ?? '';

    return Scaffold(
      backgroundColor: MtColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: MtSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: MtSpacing.lg),

              // Back button
              GestureDetector(
                onTap: () => context.go(Routes.login),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: MtColors.surface,
                    borderRadius: BorderRadius.circular(MtBorderRadius.md),
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: MtColors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: MtSpacing.xxxl),

              // Title
              Text(
                'Verify OTP',
                style: MtTypography.h2,
              ),
              const SizedBox(height: MtSpacing.sm),

              // Subtitle
              Text(
                'Enter the 6-digit code sent to $phone',
                style: MtTypography.body.copyWith(
                  color: MtColors.textSecondary,
                ),
              ),
              const SizedBox(height: MtSpacing.xxxxl),

              // OTP fields
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: _otpController,
                onChanged: (value) {
                  setState(() => _otp = value);
                },
                onCompleted: (_) => _verifyOtp(),
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                animationDuration: const Duration(milliseconds: 200),
                enableActiveFill: true,
                cursorColor: MtColors.primary,
                textStyle: const TextStyle(
                  color: MtColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(MtBorderRadius.md),
                  fieldHeight: 52,
                  fieldWidth: 48,
                  activeColor: MtColors.white,
                  selectedColor: MtColors.primary,
                  inactiveColor: MtColors.surfaceHighlight,
                  activeFillColor: MtColors.surface,
                  selectedFillColor: MtColors.surface,
                  inactiveFillColor: MtColors.surface,
                ),
              ),

              // Error message
              if (authState.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: MtSpacing.sm),
                  child: Text(
                    authState.error!,
                    style: MtTypography.bodySmall.copyWith(
                      color: MtColors.red,
                    ),
                  ),
                ),
              const SizedBox(height: MtSpacing.xxl),

              // Resend OTP
              Center(
                child: GestureDetector(
                  onTap: _resendOtp,
                  child: Text(
                    'Resend OTP',
                    style: MtTypography.label.copyWith(
                      color: MtColors.primary,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Verify button
              MtButton(
                title: 'Verify',
                onPressed:
                    _otp.length == 6 && !authState.isLoading ? _verifyOtp : null,
                loading: authState.isLoading,
              ),
              const SizedBox(height: MtSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
