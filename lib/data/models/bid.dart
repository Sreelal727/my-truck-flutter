import '../enums/enums.dart';

enum BidStatus { pending, won, lost, expired }

class Bid {
  final String id;
  final String orderId;
  final String truckOwnerId;
  final String truckOwnerName;
  final double truckOwnerRating;
  final String truckId;
  final TruckType truckType;
  final String truckRegistration;
  final double amount;
  final double estimatedHours;
  final String? note;
  final BidStatus status;
  final DateTime createdAt;

  const Bid({
    required this.id,
    required this.orderId,
    required this.truckOwnerId,
    required this.truckOwnerName,
    required this.truckOwnerRating,
    required this.truckId,
    required this.truckType,
    required this.truckRegistration,
    required this.amount,
    required this.estimatedHours,
    this.note,
    required this.status,
    required this.createdAt,
  });
}
