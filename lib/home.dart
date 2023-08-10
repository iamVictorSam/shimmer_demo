import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'items.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Effect'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProduct(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProduct() => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) => Shimmer.fromColors(
            baseColor: Colors.black54,
            highlightColor: Colors.black12,
            direction: ShimmerDirection.ttb,
            period: const Duration(milliseconds: 900),
            child: const Items()),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 1 / 1.7,
        ),
      );
}

// Shimmer.fromColors(
// baseColor: Colors.black54,
// highlightColor: Colors.purple,
// direction: ShimmerDirection.ttb,
// enabled: true,
// loop: 2,
// period: const Duration(seconds: 3),
// child: _buildProduct(),
// )
