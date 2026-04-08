class Currency {
  final String abbreviation;
  final int scale;
  final String name;
  final double rate;
  final int id;

  Currency({
    required this.abbreviation,
    required this.scale,
    required this.name,
    required this.rate,
    required this.id,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      abbreviation: json['Cur_Abbreviation'],
      scale: json['Cur_Scale'],
      name: json['Cur_Name'],
      rate: json['Cur_OfficialRate'].toDouble(),
      id: json['Cur_ID'],
    );
  }
}
