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
                    _calculateConversion(fromTop: false);
                  } else {
                    _selectedB = curr;
                    _calculateConversion(fromTop: true);
                  }
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  void _calculateConversion({bool fromTop = true}) {
    final leader = fromTop ? _controllerA : _controllerB;
    final follower = fromTop ? _controllerB : _controllerA;

    final currencyFrom = fromTop ? _selectedA : _selectedB;
    final currencyTo = fromTop ? _selectedB : _selectedA;

    if (currencyFrom == null || currencyTo == null || leader.text.isEmpty) {
      follower.clear();
      return;
    }

    double input = double.tryParse(leader.text.replaceAll(',', '.')) ?? 0;

    double result =
        (input * currencyFrom.rate / currencyFrom.scale) /
        (currencyTo.rate / currencyTo.scale);

    String newText = result.toStringAsFixed(2);
    if (follower.text != newText) {
      follower.text = newText;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
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
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (val) => _calculateConversion(fromTop: true),
                      decoration: InputDecoration(
                        labelText: 'From',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => {
                            _controllerA.clear(),
                            _controllerB.clear(),
                          },
                          icon: Icon(Icons.clear),
                        ),
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
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (val) => _calculateConversion(fromTop: false),
                      decoration: InputDecoration(
                        labelText: 'To',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => {
                            _controllerA.clear(),
                            _controllerB.clear(),
                          },
                          icon: Icon(Icons.clear),
                        ),
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
