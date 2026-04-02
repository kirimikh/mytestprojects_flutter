import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              floating: true,
              pinned: true,

              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text(
                  'Курсы валют',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              expandedHeight: 200,
            ),
          ],
        ),
      ),
    ),
  );
}
