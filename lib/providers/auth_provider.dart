import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/enums/user_role.dart';
import '../data/models/user.dart';

enum AuthStatus { initial, onboarding, login, otpSent, roleSelect, profileSetup, authenticated }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? phone;
  final String? verificationId;
  final UserRole? selectedRole;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.phone,
    this.verificationId,
    this.selectedRole,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? phone,
    String? verificationId,
    UserRole? selectedRole,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      phone: phone ?? this.phone,
      verificationId: verificationId ?? this.verificationId,
      selectedRole: selectedRole ?? this.selectedRole,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  void checkAuthStatus() {
    // For now, always start with onboarding
    state = state.copyWith(status: AuthStatus.onboarding);
  }

  void skipOnboarding() {
    state = state.copyWith(status: AuthStatus.login);
  }

  Future<void> sendOtp(String phone) async {
    state = state.copyWith(isLoading: true, error: null, phone: phone);
    // Simulate OTP send
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(
      status: AuthStatus.otpSent,
      isLoading: false,
      verificationId: 'mock-verification-id',
    );
  }

  Future<void> verifyOtp(String otp) async {
    state = state.copyWith(isLoading: true, error: null);
    await Future.delayed(const Duration(seconds: 1));
    if (otp == '123456') {
      state = state.copyWith(
        status: AuthStatus.roleSelect,
        isLoading: false,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: 'Invalid OTP. Try 123456',
      );
    }
  }

  void selectRole(UserRole role) {
    state = state.copyWith(
      selectedRole: role,
      status: AuthStatus.profileSetup,
    );
  }

  Future<void> completeProfile(String name) async {
    state = state.copyWith(isLoading: true, error: null);
    await Future.delayed(const Duration(milliseconds: 500));
    final user = User(
      id: 'user-001',
      phone: state.phone ?? '+91 98765 43210',
      name: name,
      role: state.selectedRole ?? UserRole.shipper,
      isVerified: true,
      createdAt: DateTime.now(),
    );
    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: user,
      isLoading: false,
    );
  }

  // Quick login for demo - skip auth flow
  void loginAs(UserRole role) {
    final user = User(
      id: 'user-001',
      phone: '+91 98765 43210',
      name: switch (role) {
        UserRole.shipper => 'Rajesh Kumar',
        UserRole.owner => 'Amit Patel',
        UserRole.driver => 'Ramesh Yadav',
      },
      role: role,
      rating: 4.6,
      totalTrips: 142,
      isVerified: true,
      createdAt: DateTime(2024, 8, 1),
    );
    state = state.copyWith(
      status: AuthStatus.authenticated,
      user: user,
      selectedRole: role,
    );
  }

  void logout() {
    state = const AuthState(status: AuthStatus.login);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
