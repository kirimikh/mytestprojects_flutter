import 'package:clean_test/api_service.dart';
import 'package:flutter/material.dart';

class SliverContent extends StatelessWidget {
  const SliverContent({super.key});

  @override
  Widget build(ctx) {
    return SliverToBoxAdapter(
      child: FutureBuilder(
        future: getRates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Failed to load");
          } else {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Title(
                    color: Colors.white,
                    child: Text(
                      'Currency converter',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.all(12.0), child: TextField()),
                Padding(padding: EdgeInsets.all(12.0), child: Container()),
              ],
            );
          }
        },
      ),
    );
  }
}
