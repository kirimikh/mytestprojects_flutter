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
                  'Exchange rates',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
                  ),
                ),
              ),
              expandedHeight: 200,
            ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(100.0),
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
