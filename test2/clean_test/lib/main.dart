import 'package:flutter/material.dart';
import 'hat.dart';
import 'content.dart';
// import 'api_service.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: CustomScrollView(slivers: [SliverHat(), SliverContent()]),
      ),
    ),
  );
}
