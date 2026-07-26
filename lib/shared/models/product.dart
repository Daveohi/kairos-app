import 'package:flutter/material.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.unit,
    required this.color,
    required this.imagePath,
    this.rating = 4.5,
    this.originalPrice,
    this.description = '',
  });

  final String id;
  final String name;
  final String category;
  final double price;
  final String unit;
  final Color color;
  final double rating;

  /// Asset path of the product photo, e.g. `assets/images/products/foo.jpg`.
  final String imagePath;

  /// Pre-discount price. Null means no discount badge is shown.
  final double? originalPrice;

  /// Short "About" blurb shown on the product detail screen.
  final String description;
}
