import '../enums/enums.dart';
import '../models/models.dart';

// ─── Users ──────────────────────────────────────────────────────────────────

final mockShipper1 = User(
  id: 'shipper_001',
  phone: '+919876543210',
  name: 'Rajesh Kumar',
  email: 'rajesh.kumar@gmail.com',
  role: UserRole.shipper,
  rating: 4.5,
  totalTrips: 32,
  language: 'hi',
  isVerified: true,
  createdAt: DateTime(2024, 3, 15),
);

final mockShipper2 = User(
  id: 'shipper_002',
  phone: '+919812345678',
  name: 'Priya Sharma',
  email: 'priya.sharma@gmail.com',
  role: UserRole.shipper,
  rating: 4.8,
  totalTrips: 18,
  language: 'en',
  isVerified: true,
  createdAt: DateTime(2024, 6, 20),
);

final mockOwner1 = User(
  id: 'owner_001',
  phone: '+919988776655',
  name: 'Amit Patel',
  email: 'amit.patel@gmail.com',
  role: UserRole.owner,
  rating: 4.7,
  totalTrips: 156,
  language: 'en',
  isVerified: true,
  createdAt: DateTime(2023, 11, 1),
);

final mockOwner2 = User(
  id: 'owner_002',
  phone: '+919922334455',
  name: 'Suresh Reddy',
  email: 'suresh.reddy@gmail.com',
  role: UserRole.owner,
  rating: 4.3,
  totalTrips: 89,
  language: 'en',
  isVerified: true,
  createdAt: DateTime(2024, 1, 10),
);

final mockOwner3 = User(
  id: 'owner_003',
  phone: '+919845671234',
  name: 'Vikram Singh',
  role: UserRole.owner,
  rating: 4.6,
  totalTrips: 210,
  language: 'hi',
  isVerified: true,
  createdAt: DateTime(2023, 8, 5),
);

final mockDriver1 = User(
  id: 'driver_001',
  phone: '+919765432109',
  name: 'Ramesh Yadav',
  role: UserRole.driver,
  rating: 4.4,
  totalTrips: 120,
  language: 'hi',
  isVerified: true,
  createdAt: DateTime(2024, 2, 14),
);

final mockDriver2 = User(
  id: 'driver_002',
  phone: '+919654321098',
  name: 'Manoj Tiwari',
  role: UserRole.driver,
  rating: 4.6,
  totalTrips: 95,
  language: 'hi',
  isVerified: true,
  createdAt: DateTime(2024, 4, 22),
);

final mockUsers = [
  mockShipper1,
  mockShipper2,
  mockOwner1,
  mockOwner2,
  mockOwner3,
  mockDriver1,
  mockDriver2,
];

// ─── Trucks ─────────────────────────────────────────────────────────────────

final mockTruck1 = Truck(
  id: 'truck_001',
  ownerId: 'owner_001',
  type: TruckType.eicher17ft,
  registrationNumber: 'MH 12 AB 1234',
  capacity: '7 ton',
  status: TruckStatus.available,
  rating: 4.7,
  totalTrips: 98,
  photos: ['truck_001_front.jpg', 'truck_001_side.jpg'],
);

final mockTruck2 = Truck(
  id: 'truck_002',
  ownerId: 'owner_002',
  type: TruckType.container32ft,
  registrationNumber: 'KA 01 CD 5678',
  capacity: '15 ton',
  status: TruckStatus.onTrip,
  rating: 4.5,
  totalTrips: 64,
  photos: ['truck_002_front.jpg'],
);

final mockTruck3 = Truck(
  id: 'truck_003',
  ownerId: 'owner_003',
  type: TruckType.tata407,
  registrationNumber: 'RJ 14 EF 9012',
  capacity: '2.5 ton',
  status: TruckStatus.available,
  rating: 4.8,
  totalTrips: 145,
  photos: ['truck_003_front.jpg', 'truck_003_side.jpg', 'truck_003_rear.jpg'],
);

final mockTrucks = [mockTruck1, mockTruck2, mockTruck3];

// ─── Orders ─────────────────────────────────────────────────────────────────

final mockOrder1 = Order(
  id: 'order_001',
  shipperId: 'shipper_001',
  status: OrderStatus.bidding,
  pickupAddress: 'Andheri East, Mumbai, Maharashtra',
  pickupLat: 19.1136,
  pickupLng: 72.8697,
  dropAddress: 'Hinjewadi, Pune, Maharashtra',
  dropLat: 18.5912,
  dropLng: 73.7389,
  goodsCategory: GoodsCategory.electronics,
  goodsDescription: 'Server racks and networking equipment',
  weight: 3500,
  truckTypePreferred: TruckType.eicher17ft,
  scheduledAt: DateTime(2025, 2, 15, 8, 0),
  biddingEndsAt: DateTime(2025, 2, 14, 18, 0),
  maxBids: 10,
  createdAt: DateTime(2025, 2, 13, 10, 30),
);

final mockOrder2 = Order(
  id: 'order_002',
  shipperId: 'shipper_001',
  status: OrderStatus.confirmed,
  pickupAddress: 'Naraina Industrial Area, New Delhi',
  pickupLat: 28.6292,
  pickupLng: 77.1409,
  dropAddress: 'Mansarovar, Jaipur, Rajasthan',
  dropLat: 26.8654,
  dropLng: 75.7602,
  goodsCategory: GoodsCategory.furniture,
  goodsDescription: 'Office furniture - 20 desks, 40 chairs',
  weight: 2000,
  truckTypePreferred: TruckType.container20ft,
  scheduledAt: DateTime(2025, 2, 16, 6, 0),
  biddingEndsAt: DateTime(2025, 2, 15, 12, 0),
  maxBids: 8,
  selectedBidId: 'bid_003',
  finalAmount: 28500,
  createdAt: DateTime(2025, 2, 12, 14, 0),
);

final mockOrder3 = Order(
  id: 'order_003',
  shipperId: 'shipper_002',
  status: OrderStatus.inTransit,
  pickupAddress: 'Whitefield, Bangalore, Karnataka',
  pickupLat: 12.9698,
  pickupLng: 77.7500,
  dropAddress: 'Banjara Hills, Hyderabad, Telangana',
  dropLat: 17.4106,
  dropLng: 78.4408,
  goodsCategory: GoodsCategory.fmcg,
  goodsDescription: 'FMCG products - packaged food and beverages',
  weight: 12000,
  truckTypePreferred: TruckType.container32ft,
  scheduledAt: DateTime(2025, 2, 10, 5, 0),
  biddingEndsAt: DateTime(2025, 2, 9, 17, 0),
  maxBids: 12,
  selectedBidId: 'bid_005',
  finalAmount: 45000,
  createdAt: DateTime(2025, 2, 8, 9, 0),
);

final mockOrder4 = Order(
  id: 'order_004',
  shipperId: 'shipper_002',
  status: OrderStatus.completed,
  pickupAddress: 'GIDC, Ahmedabad, Gujarat',
  pickupLat: 23.0225,
  pickupLng: 72.5714,
  dropAddress: 'Indore, Madhya Pradesh',
  dropLat: 22.7196,
  dropLng: 75.8577,
  goodsCategory: GoodsCategory.chemicals,
  goodsDescription: 'Industrial chemicals in sealed drums',
  weight: 8000,
  truckTypePreferred: TruckType.tanker,
  scheduledAt: DateTime(2025, 1, 25, 7, 0),
  biddingEndsAt: DateTime(2025, 1, 24, 19, 0),
  maxBids: 6,
  selectedBidId: 'bid_007',
  finalAmount: 35000,
  createdAt: DateTime(2025, 1, 23, 11, 0),
);

final mockOrder5 = Order(
  id: 'order_005',
  shipperId: 'shipper_001',
  status: OrderStatus.posted,
  pickupAddress: 'Sector 62, Noida, Uttar Pradesh',
  pickupLat: 28.6270,
  pickupLng: 77.3653,
  dropAddress: 'Civil Lines, Lucknow, Uttar Pradesh',
  dropLat: 26.8605,
  dropLng: 80.9462,
  goodsCategory: GoodsCategory.household,
  goodsDescription: 'Household shifting - packed boxes and appliances',
  weight: 1500,
  truckTypePreferred: TruckType.eicher14ft,
  scheduledAt: DateTime(2025, 2, 20, 9, 0),
  biddingEndsAt: DateTime(2025, 2, 19, 21, 0),
  maxBids: 10,
  createdAt: DateTime(2025, 2, 14, 16, 0),
);

final mockOrder6 = Order(
  id: 'order_006',
  shipperId: 'shipper_002',
  status: OrderStatus.cancelled,
  pickupAddress: 'Koramangala, Bangalore, Karnataka',
  pickupLat: 12.9352,
  pickupLng: 77.6245,
  dropAddress: 'MG Road, Kochi, Kerala',
  dropLat: 9.9816,
  dropLng: 76.2999,
  goodsCategory: GoodsCategory.textiles,
  goodsDescription: 'Textile bales - cotton and silk fabrics',
  weight: 5000,
  truckTypePreferred: TruckType.closedBody,
  scheduledAt: DateTime(2025, 2, 8, 6, 0),
  biddingEndsAt: DateTime(2025, 2, 7, 18, 0),
  maxBids: 8,
  createdAt: DateTime(2025, 2, 5, 12, 0),
);

final mockOrder7 = Order(
  id: 'order_007',
  shipperId: 'shipper_001',
  status: OrderStatus.paymentPending,
  pickupAddress: 'Pimpri-Chinchwad, Pune, Maharashtra',
  pickupLat: 18.6279,
  pickupLng: 73.8009,
  dropAddress: 'Nashik, Maharashtra',
  dropLat: 19.9975,
  dropLng: 73.7898,
  goodsCategory: GoodsCategory.automobile,
  goodsDescription: 'Auto spare parts - engine components and body panels',
  weight: 2200,
  truckTypePreferred: TruckType.tata407,
  scheduledAt: DateTime(2025, 2, 17, 10, 0),
  biddingEndsAt: DateTime(2025, 2, 16, 22, 0),
  maxBids: 8,
  selectedBidId: 'bid_008',
  finalAmount: 12500,
  createdAt: DateTime(2025, 2, 14, 8, 0),
);

final mockOrders = [
  mockOrder1,
  mockOrder2,
  mockOrder3,
  mockOrder4,
  mockOrder5,
  mockOrder6,
  mockOrder7,
];

// ─── Bids ───────────────────────────────────────────────────────────────────

final mockBid1 = Bid(
  id: 'bid_001',
  orderId: 'order_001',
  truckOwnerId: 'owner_001',
  truckOwnerName: 'Amit Patel',
  truckOwnerRating: 4.7,
  truckId: 'truck_001',
  truckType: TruckType.eicher17ft,
  truckRegistration: 'MH 12 AB 1234',
  amount: 18500,
  estimatedHours: 5,
  note: 'Can pick up by 7 AM. Experienced with electronics cargo.',
  status: BidStatus.pending,
  createdAt: DateTime(2025, 2, 13, 11, 15),
);

final mockBid2 = Bid(
  id: 'bid_002',
  orderId: 'order_001',
  truckOwnerId: 'owner_003',
  truckOwnerName: 'Vikram Singh',
  truckOwnerRating: 4.6,
  truckId: 'truck_003',
  truckType: TruckType.tata407,
  truckRegistration: 'RJ 14 EF 9012',
  amount: 16000,
  estimatedHours: 6,
  note: 'Competitive rate. Truck in excellent condition.',
  status: BidStatus.pending,
  createdAt: DateTime(2025, 2, 13, 12, 30),
);

final mockBid3 = Bid(
  id: 'bid_003',
  orderId: 'order_002',
  truckOwnerId: 'owner_001',
  truckOwnerName: 'Amit Patel',
  truckOwnerRating: 4.7,
  truckId: 'truck_001',
  truckType: TruckType.eicher17ft,
  truckRegistration: 'MH 12 AB 1234',
  amount: 28500,
  estimatedHours: 8,
  note: 'Regular Delhi-Jaipur route. Will handle with care.',
  status: BidStatus.won,
  createdAt: DateTime(2025, 2, 12, 15, 0),
);

final mockBid4 = Bid(
  id: 'bid_004',
  orderId: 'order_002',
  truckOwnerId: 'owner_002',
  truckOwnerName: 'Suresh Reddy',
  truckOwnerRating: 4.3,
  truckId: 'truck_002',
  truckType: TruckType.container32ft,
  truckRegistration: 'KA 01 CD 5678',
  amount: 32000,
  estimatedHours: 7,
  status: BidStatus.lost,
  createdAt: DateTime(2025, 2, 12, 16, 45),
);

final mockBid5 = Bid(
  id: 'bid_005',
  orderId: 'order_003',
  truckOwnerId: 'owner_002',
  truckOwnerName: 'Suresh Reddy',
  truckOwnerRating: 4.3,
  truckId: 'truck_002',
  truckType: TruckType.container32ft,
  truckRegistration: 'KA 01 CD 5678',
  amount: 45000,
  estimatedHours: 10,
  note: 'Have done this route 15+ times. Reliable delivery.',
  status: BidStatus.won,
  createdAt: DateTime(2025, 2, 8, 10, 30),
);

final mockBid6 = Bid(
  id: 'bid_006',
  orderId: 'order_003',
  truckOwnerId: 'owner_003',
  truckOwnerName: 'Vikram Singh',
  truckOwnerRating: 4.6,
  truckId: 'truck_003',
  truckType: TruckType.tata407,
  truckRegistration: 'RJ 14 EF 9012',
  amount: 48000,
  estimatedHours: 11,
  status: BidStatus.lost,
  createdAt: DateTime(2025, 2, 8, 12, 0),
);

final mockBid7 = Bid(
  id: 'bid_007',
  orderId: 'order_004',
  truckOwnerId: 'owner_003',
  truckOwnerName: 'Vikram Singh',
  truckOwnerRating: 4.6,
  truckId: 'truck_003',
  truckType: TruckType.tata407,
  truckRegistration: 'RJ 14 EF 9012',
  amount: 35000,
  estimatedHours: 9,
  note: 'Have tanker experience. All safety certifications in place.',
  status: BidStatus.won,
  createdAt: DateTime(2025, 1, 23, 13, 0),
);

final mockBid8 = Bid(
  id: 'bid_008',
  orderId: 'order_007',
  truckOwnerId: 'owner_001',
  truckOwnerName: 'Amit Patel',
  truckOwnerRating: 4.7,
  truckId: 'truck_001',
  truckType: TruckType.eicher17ft,
  truckRegistration: 'MH 12 AB 1234',
  amount: 12500,
  estimatedHours: 4,
  note: 'Pune to Nashik is my regular route.',
  status: BidStatus.won,
  createdAt: DateTime(2025, 2, 14, 9, 30),
);

final mockBid9 = Bid(
  id: 'bid_009',
  orderId: 'order_001',
  truckOwnerId: 'owner_002',
  truckOwnerName: 'Suresh Reddy',
  truckOwnerRating: 4.3,
  truckId: 'truck_002',
  truckType: TruckType.container32ft,
  truckRegistration: 'KA 01 CD 5678',
  amount: 20000,
  estimatedHours: 5,
  status: BidStatus.pending,
  createdAt: DateTime(2025, 2, 13, 14, 0),
);

final mockBids = [
  mockBid1,
  mockBid2,
  mockBid3,
  mockBid4,
  mockBid5,
  mockBid6,
  mockBid7,
  mockBid8,
  mockBid9,
];

// ─── Trips ──────────────────────────────────────────────────────────────────

final mockTrip1 = Trip(
  id: 'trip_001',
  orderId: 'order_003',
  bidId: 'bid_005',
  truckId: 'truck_002',
  driverId: 'driver_001',
  status: TripStatus.inTransit,
  advanceAmount: 27000, // 60% of 45000
  remainingAmount: 18000, // 40% of 45000
  commissionAmount: 4500, // 10% commission
  pickupPhotos: ['trip_001_pickup_1.jpg', 'trip_001_pickup_2.jpg'],
  deliveryPhotos: [],
  startedAt: DateTime(2025, 2, 10, 5, 30),
  completedAt: null,
);

final mockTrip2 = Trip(
  id: 'trip_002',
  orderId: 'order_004',
  bidId: 'bid_007',
  truckId: 'truck_003',
  driverId: 'driver_002',
  status: TripStatus.completed,
  advanceAmount: 21000, // 60% of 35000
  remainingAmount: 14000, // 40% of 35000
  commissionAmount: 3500, // 10% commission
  pickupPhotos: ['trip_002_pickup_1.jpg'],
  deliveryPhotos: ['trip_002_delivery_1.jpg', 'trip_002_delivery_2.jpg'],
  startedAt: DateTime(2025, 1, 25, 7, 15),
  completedAt: DateTime(2025, 1, 26, 2, 45),
);

final mockTrips = [mockTrip1, mockTrip2];
