import '../enums/user_role.dart';

class User {
  final String id;
  final String phone;
  final String name;
  final String? email;
  final UserRole role;
  final String? profilePhoto;
  final double rating;
  final int totalTrips;
  final String language; // 'en' or 'hi'
  final bool isVerified;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.phone,
    required this.name,
    this.email,
    required this.role,
    this.profilePhoto,
    this.rating = 0.0,
    this.totalTrips = 0,
    this.language = 'en',
    this.isVerified = false,
    required this.createdAt,
  });

  User copyWith({
    String? id,
    String? phone,
    String? name,
    String? email,
    UserRole? role,
    String? profilePhoto,
    double? rating,
    int? totalTrips,
    String? language,
    bool? isVerified,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      rating: rating ?? this.rating,
      totalTrips: totalTrips ?? this.totalTrips,
      language: language ?? this.language,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
