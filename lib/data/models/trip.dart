import '../enums/enums.dart';

class Trip {
  final String id;
  final String orderId;
  final String bidId;
  final String truckId;
  final String driverId;
  final TripStatus status;
  final double advanceAmount;
  final double remainingAmount;
  final double commissionAmount;
  final List<String> pickupPhotos;
  final List<String> deliveryPhotos;
  final DateTime? startedAt;
  final DateTime? completedAt;

  const Trip({
    required this.id,
    required this.orderId,
    required this.bidId,
    required this.truckId,
    required this.driverId,
    required this.status,
    required this.advanceAmount,
    required this.remainingAmount,
    required this.commissionAmount,
    this.pickupPhotos = const [],
    this.deliveryPhotos = const [],
    this.startedAt,
    this.completedAt,
  });
}
