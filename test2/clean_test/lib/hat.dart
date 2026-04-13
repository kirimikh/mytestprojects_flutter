import 'package:flutter/material.dart';

class SliverHat extends StatelessWidget {
  const SliverHat({super.key});

  @override
  Widget build(ctx) {
    final double screenHeight = MediaQuery.of(ctx).size.height;
    return SliverAppBar(
      centerTitle: true,
      pinned: true,
      floating: false,
      expandedHeight: screenHeight,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const Text(
          'Exchange rates',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        background: Container(color: Colors.white),
      ),
    );
  }
}
