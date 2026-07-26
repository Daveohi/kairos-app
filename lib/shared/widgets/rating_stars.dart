import 'package:flutter/material.dart';

/// A row of 5 star icons rendering [rating] (0–5), used on the product
/// detail screen.
class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.rating, this.size = 20});

  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final filled = index < rating.round();
        return Icon(
          filled ? Icons.star_rounded : Icons.star_border_rounded,
          size: size,
          color: const Color(0xFFFFB800),
        );
      }),
    );
  }
}
