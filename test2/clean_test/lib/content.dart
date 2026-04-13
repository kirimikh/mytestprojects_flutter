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
  final _controllerC = TextEditingController();
  final _controllerD = TextEditingController();
  final _controllerE = TextEditingController();
  final _controllerF = TextEditingController();
  final _controllerG = TextEditingController();
  final _controllerH = TextEditingController();
  // final _controllerI = TextEditingController();
  Currency? _selectedA;
  Currency? _selectedB;
  Currency? _selectedC;
  Currency? _selectedD;
  Currency? _selectedE;
  Currency? _selectedF;
  Currency? _selectedG;
  Currency? _selectedH;
  // Currency? _selectedI;
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

  void _showCurrencyPicker(String selectedField) {
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
                  if (selectedField == "A") {
                    _selectedA = curr;
                    _calculateConversion(
                      _controllerB,
                      _controllerA,
                      _selectedB,
                      _selectedA,
                    );
                  } else if (selectedField == "B") {
                    _selectedB = curr;
                    _calculateConversion(
                      _controllerA,
                      _controllerB,
                      _selectedA,
                      _selectedB,
                    );
                  } else if (selectedField == "C") {
                    _selectedC = curr;
                    _calculateConversion(
                      _controllerD,
                      _controllerC,
                      _selectedD,
                      _selectedC,
                    );
                  } else if (selectedField == "D") {
                    _selectedD = curr;
                    _calculateConversion(
                      _controllerC,
                      _controllerD,
                      _selectedC,
                      _selectedD,
                    );
                  } else if (selectedField == "E") {
                    _selectedE = curr;
                    _calculateConversion(
                      _controllerF,
                      _controllerE,
                      _selectedF,
                      _selectedE,
                    );
                  } else if (selectedField == "F") {
                    _selectedF = curr;
                    _calculateConversion(
                      _controllerE,
                      _controllerF,
                      _selectedE,
                      _selectedF,
                    );
                  } else if (selectedField == "G") {
                    _selectedG = curr;
                    _calculateConversion(
                      _controllerH,
                      _controllerG,
                      _selectedH,
                      _selectedG,
                    );
                  } else if (selectedField == "H") {
                    _selectedH = curr;
                    _calculateConversion(
                      _controllerG,
                      _controllerH,
                      _selectedG,
                      _selectedH,
                    );
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

  void _calculateConversion(
    leaderController,
    followerController,
    currencyFrom,
    currencyTo,
  ) {
    if (currencyFrom == null ||
        currencyTo == null ||
        leaderController.text.isEmpty) {
      followerController.clear();
      return;
    }

    double input =
        double.tryParse(leaderController.text.replaceAll(',', '.')) ?? 0;

    double result =
        (input * currencyFrom.rate / currencyFrom.scale) /
        (currencyTo.rate / currencyTo.scale);

    String newText = result.toStringAsFixed(2);
    if (followerController.text != newText) {
      followerController.text = newText;
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
                      onPressed: () => _showCurrencyPicker("A"),
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
                      onChanged: (val) => _calculateConversion(
                        _controllerA,
                        _controllerB,
                        _selectedA,
                        _selectedB,
                      ),
                      decoration: InputDecoration(
                        labelText: 'From',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => {
                            _controllerA.clear(),
                            _controllerB.clear(),
                            // _controllerC.clear(),
                            // _controllerD.clear(),
                            // _controllerE.clear(),
                            // _controllerF.clear(),
                            // _controllerG.clear(),
                            // _controllerH.clear(),
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
                      onPressed: () => _showCurrencyPicker("B"),
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
                      onChanged: (val) => _calculateConversion(
                        _controllerB,
                        _controllerA,
                        _selectedB,
                        _selectedA,
                      ),
                      decoration: InputDecoration(
                        labelText: 'To',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => {
                            _controllerA.clear(),
                            _controllerB.clear(),
                            // _controllerC.clear(),
                            // _controllerD.clear(),
                            // _controllerE.clear(),
                            // _controllerF.clear(),
                            // _controllerG.clear(),
                            // _controllerH.clear(),
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
                      onPressed: () => _showCurrencyPicker("C"),
                      child: Text(_selectedC?.abbreviation ?? 'Choose'),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: TextField(
                      controller: _controllerC,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (val) => _calculateConversion(
                        _controllerC,
                        _controllerD,
                        _selectedC,
                        _selectedD,
                      ),
                      decoration: InputDecoration(
                        labelText: 'To',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => {
                            // _controllerA.clear(),
                            // _controllerB.clear(),
                            _controllerC.clear(),
                            _controllerD.clear(),
                            // _controllerE.clear(),
                            // _controllerF.clear(),
                            // _controllerG.clear(),
                            // _controllerH.clear(),
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
                      onPressed: () => _showCurrencyPicker("D"),
                      child: Text(_selectedD?.abbreviation ?? 'Choose'),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: TextField(
                      controller: _controllerD,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (val) => _calculateConversion(
                        _controllerD,
                        _controllerC,
                        _selectedD,
                        _selectedC,
                      ),
                      decoration: InputDecoration(
                        labelText: 'To',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => {
                            // _controllerA.clear(),
                            // _controllerB.clear(),
                            _controllerC.clear(),
                            _controllerD.clear(),
                            // _controllerE.clear(),
                            // _controllerF.clear(),
                            // _controllerG.clear(),
                            // _controllerH.clear(),
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
                      onPressed: () => _showCurrencyPicker("E"),
                      child: Text(_selectedE?.abbreviation ?? 'Choose'),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: TextField(
                      controller: _controllerE,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (val) => _calculateConversion(
                        _controllerE,
                        _controllerF,
                        _selectedE,
                        _selectedF,
                      ),
                      decoration: InputDecoration(
                        labelText: 'To',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => {
                            // _controllerA.clear(),
                            // _controllerB.clear(),
                            // _controllerC.clear(),
                            // _controllerD.clear(),
                            _controllerE.clear(),
                            _controllerF.clear(),
                            // _controllerG.clear(),
                            // _controllerH.clear(),
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
                      onPressed: () => _showCurrencyPicker("F"),
                      child: Text(_selectedF?.abbreviation ?? 'Choose'),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: TextField(
                      controller: _controllerF,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (val) => _calculateConversion(
                        _controllerF,
                        _controllerE,
                        _selectedF,
                        _selectedE,
                      ),
                      decoration: InputDecoration(
                        labelText: 'To',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => {
                            // _controllerA.clear(),
                            // _controllerB.clear(),
                            // _controllerC.clear(),
                            // _controllerD.clear(),
                            _controllerE.clear(),
                            _controllerF.clear(),
                            // _controllerG.clear(),
                            // _controllerH.clear(),
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
                      onPressed: () => _showCurrencyPicker("G"),
                      child: Text(_selectedG?.abbreviation ?? 'Choose'),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: TextField(
                      controller: _controllerG,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (val) => _calculateConversion(
                        _controllerG,
                        _controllerH,
                        _selectedG,
                        _selectedH,
                      ),
                      decoration: InputDecoration(
                        labelText: 'To',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => {
                            // _controllerA.clear(),
                            // _controllerB.clear(),
                            // _controllerC.clear(),
                            // _controllerD.clear(),
                            // _controllerE.clear(),
                            // _controllerF.clear(),
                            _controllerG.clear(),
                            _controllerH.clear(),
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
                      onPressed: () => _showCurrencyPicker("H"),
                      child: Text(_selectedH?.abbreviation ?? 'Choose'),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: TextField(
                      controller: _controllerH,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onChanged: (val) => _calculateConversion(
                        _controllerH,
                        _controllerG,
                        _selectedH,
                        _selectedG,
                      ),
                      decoration: InputDecoration(
                        labelText: 'To',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => {
                            // _controllerA.clear(),
                            // _controllerB.clear(),
                            // _controllerC.clear(),
                            // _controllerD.clear(),
                            // _controllerE.clear(),
                            // _controllerF.clear(),
                            _controllerG.clear(),
                            _controllerH.clear(),
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
