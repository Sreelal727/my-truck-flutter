import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class MtStarRating extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double size;
  final bool interactive;
  final ValueChanged<int>? onRate;

  const MtStarRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 16,
    this.interactive = false,
    this.onRate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (i) {
        final starValue = i + 1;
        final isFilled = starValue <= rating.floor();
        final isHalf = !isFilled && starValue - 0.5 <= rating;

        final icon = isFilled
            ? Icons.star_rounded
            : isHalf
                ? Icons.star_half_rounded
                : Icons.star_outline_rounded;
        final color =
            (isFilled || isHalf) ? MtColors.yellow : MtColors.textTertiary;

        final star = Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Icon(icon, size: size, color: color),
        );

        if (interactive) {
          return GestureDetector(
            onTap: () => onRate?.call(starValue),
            child: star,
          );
        }
        return star;
      }),
    );
  }
}
