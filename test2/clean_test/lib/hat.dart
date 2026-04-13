import 'package:flutter/material.dart';

class SliverHat extends StatelessWidget {
  const SliverHat({super.key});

  @override
  Widget build(ctx) {
    final double screenHeight = MediaQuery.of(ctx).size.height;
    return SliverAppBar(
      centerTitle: true,
      pinned: true,
      expandedHeight: screenHeight,

      flexibleSpace: FlexibleSpaceBar(
        background: Center(
          child: Text(
            'Exchange rates',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
