import 'package:flutter/material.dart';

enum GoodsCategory {
  household('Household Goods', Icons.home_outlined),
  construction('Construction Material', Icons.construction_outlined),
  agricultural('Agricultural Produce', Icons.eco_outlined),
  industrial('Industrial Machinery', Icons.settings_outlined),
  fmcg('FMCG / Consumer', Icons.shopping_cart_outlined),
  furniture('Furniture & Appliances', Icons.weekend_outlined),
  automobile('Automobile Parts', Icons.directions_car_outlined),
  textiles('Textiles & Garments', Icons.checkroom_outlined),
  electronics('Electronics', Icons.memory_outlined),
  chemicals('Chemicals & Liquids', Icons.science_outlined),
  perishable('Perishable / Cold', Icons.ac_unit_outlined),
  rawMaterials('Raw Materials', Icons.inventory_2_outlined),
  ecommerce('E-commerce Parcels', Icons.local_shipping_outlined),
  other('Other', Icons.more_horiz_outlined);

  const GoodsCategory(this.label, this.icon);
  final String label;
  final IconData icon;
}
