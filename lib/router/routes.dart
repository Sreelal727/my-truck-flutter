abstract final class Routes {
  // Auth
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const verifyOtp = '/verify-otp';
  static const roleSelect = '/role-select';
  static const profileSetup = '/profile-setup';

  // Shipper
  static const shipperHome = '/shipper';
  static const shipperCreateOrder = '/shipper/create-order';
  static const shipperBidding = '/shipper/bidding';
  static const shipperOrderConfirmed = '/shipper/order-confirmed';
  static const shipperTracking = '/shipper/tracking';
  static const shipperOrders = '/shipper/orders';
  static const shipperNotifications = '/shipper/notifications';
  static const shipperProfile = '/shipper/profile';

  // Owner
  static const ownerHome = '/owner';
  static const ownerOrderDetail = '/owner/order-detail';
  static const ownerPlaceBid = '/owner/place-bid';
  static const ownerBids = '/owner/bids';
  static const ownerFleet = '/owner/fleet';
  static const ownerEarnings = '/owner/earnings';
  static const ownerProfile = '/owner/profile';

  // Driver
  static const driverHome = '/driver';
  static const driverHistory = '/driver/history';
  static const driverProfile = '/driver/profile';
}
