import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPlaceholder extends StatelessWidget {
  const ShimmerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 106,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 14,
            width: 110,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 4),
          Container(
            height: 12,
            width: 130,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 4),
          Container(
            height: 14,
            width: 40,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}