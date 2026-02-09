import '../enums/enums.dart';

class Order {
  final String id;
  final String shipperId;
  final OrderStatus status;
  final String pickupAddress;
  final double pickupLat;
  final double pickupLng;
  final String dropAddress;
  final double dropLat;
  final double dropLng;
  final GoodsCategory goodsCategory;
  final String goodsDescription;
  final double weight;
  final TruckType truckTypePreferred;
  final DateTime scheduledAt;
  final DateTime biddingEndsAt;
  final int maxBids;
  final String? selectedBidId;
  final double? finalAmount;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.shipperId,
    required this.status,
    required this.pickupAddress,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropAddress,
    required this.dropLat,
    required this.dropLng,
    required this.goodsCategory,
    required this.goodsDescription,
    required this.weight,
    required this.truckTypePreferred,
    required this.scheduledAt,
    required this.biddingEndsAt,
    required this.maxBids,
    this.selectedBidId,
    this.finalAmount,
    required this.createdAt,
  });
}
