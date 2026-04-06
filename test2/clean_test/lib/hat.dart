import 'package:flutter/material.dart';

class SliverHat extends StatelessWidget {
  const SliverHat({super.key});

  @override
  Widget build(ctx) {
    return SliverAppBar(
      centerTitle: true,
      floating: true,
      pinned: true,

      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: const Text(
          'Exchange rates',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
        ),
      ),
      expandedHeight: 200,
    );
  }
}
