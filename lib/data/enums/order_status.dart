enum OrderStatus {
  posted('Posted'),
  bidding('Bidding'),
  confirmed('Confirmed'),
  paymentPending('Payment Pending'),
  paid('Paid'),
  driverAssigned('Driver Assigned'),
  inTransit('In Transit'),
  delivered('Delivered'),
  completed('Completed'),
  cancelled('Cancelled');

  const OrderStatus(this.label);
  final String label;
}

enum TripStatus {
  assigned('Assigned'),
  pickupReached('Pickup Reached'),
  loading('Loading'),
  inTransit('In Transit'),
  destinationReached('Destination Reached'),
  unloading('Unloading'),
  delivered('Delivered'),
  completed('Completed');

  const TripStatus(this.label);
  final String label;
}
