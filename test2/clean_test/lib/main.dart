import 'package:flutter/material.dart';
import 'package:clean_test/hat.dart';
import 'package:clean_test/content.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: CustomScrollView(slivers: [SliverHat(), SliverContent()]),
      ),
    ),
  );
}
