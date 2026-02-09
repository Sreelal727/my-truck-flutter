import '../enums/enums.dart';

enum TruckStatus { available, onTrip, maintenance }

class Truck {
  final String id;
  final String ownerId;
  final TruckType type;
  final String registrationNumber;
  final String capacity;
  final TruckStatus status;
  final double rating;
  final int totalTrips;
  final List<String> photos;

  const Truck({
    required this.id,
    required this.ownerId,
    required this.type,
    required this.registrationNumber,
    required this.capacity,
    required this.status,
    this.rating = 0.0,
    this.totalTrips = 0,
    this.photos = const [],
  });
}
