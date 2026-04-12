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

    final byn = Currency(
      abbreviation: 'BYN',
      scale: 1,
      name: 'беларуский рубль',
      rate: 1.0,
      id: 0,
    );

    data.insert(0, byn);

    setState(() {
      _currencies = data;
      _selectedA = byn;
    });
  }

  void _showCurrencyPicker(bool isFirstBtn) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: _currencies!.length,
          itemBuilder: (context, index) {
            final curr = _currencies![index];
            return ListTile(
              title: Text(curr.abbreviation),
              onTap: () {
                setState(() {
                  if (isFirstBtn) {
                    _selectedA = curr;
                  } else {
                    _selectedB = curr;
                  }
                  _calculateConversion();
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  void _calculateConversion() {
    if (_selectedA == null || _selectedB == null || _controllerA.text.isEmpty) {
      return;
    }

    double input = double.tryParse(_controllerA.text) ?? 0;

    double result = input * (_selectedA!.rate / _selectedB!.rate);

    _controllerB.text = result.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    _loadData();

    _controllerA.addListener(_calculateConversion);
  }

  @override
  Widget build(ctx) {
    if (_currencies == null) {
      return SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Converter',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                      onPressed: () => _showCurrencyPicker(true),
                      child: Text(_selectedA?.abbreviation ?? 'Choose'),
                    ),
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: TextField(
                      controller: _controllerA,
                      decoration: InputDecoration(
                        labelText: 'From USD',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                      onPressed: () => _showCurrencyPicker(false),
                      child: Text(_selectedB?.abbreviation ?? 'Choose'),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: TextField(
                      controller: _controllerB,
                      decoration: InputDecoration(
                        labelText: 'To BYN',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}

double calcAmount(double amountA, double rateA, double rateB) {
  double amountB = amountA * (rateA / rateB);
  return amountB;
}
