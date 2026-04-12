import 'package:clean_test/api_service.dart';
import 'package:flutter/material.dart';
import 'currency.dart';

class SliverContent extends StatefulWidget {
  const SliverContent({super.key});

  @override
  State<SliverContent> createState() => _SliverContentState();
}

class _SliverContentState extends State<SliverContent> {
  final _controllerA = TextEditingController();
  final _controllerB = TextEditingController();
  Currency? _selectedA;
  Currency? _selectedB;
  double result = 0;

  List<Currency>? _currencies;

  void _loadData() async {
    final data = await getRates();

    setState(() {
      _currencies = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(ctx) {
    if (_currencies == null) {
      return SliverToBoxAdapter(child: CircularProgressIndicator());
    } else {
      return SliverToBoxAdapter(
        child: Column(
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

            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextField(
                controller: _controllerA,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter the amount",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => {},
              ),
            ),

            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextField(
                controller: _controllerB,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter the amount",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => {},
              ),
            ),
          ],
        ),
      );
    }
  }
}

double calcSum(double amountA, double rateA, double rateB) {
  double amountB = amountA * (rateA / rateB);
  return amountB;
}
