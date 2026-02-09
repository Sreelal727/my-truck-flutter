import 'package:flutter/material.dart';

enum UserRole {
  shipper('Shipper', 'Post loads & find trucks', Icons.inventory_2_rounded),
  owner('Truck Owner', 'Manage fleet & bid on loads', Icons.local_shipping_rounded),
  driver('Driver', 'Accept trips & earn', Icons.person_pin_circle_rounded);

  const UserRole(this.label, this.description, this.icon);
  final String label;
  final String description;
  final IconData icon;
}
