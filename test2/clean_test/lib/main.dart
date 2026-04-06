import 'package:flutter/material.dart';
import 'hat.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverHat(),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(1000.0),
                    child: Title(
                      color: Colors.white,
                      child: Text('Currency converter'),
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(12.0), child: TextField()),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
