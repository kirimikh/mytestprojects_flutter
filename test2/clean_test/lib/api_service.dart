import 'dart:convert';
import 'package:http/http.dart' as http;
import 'currency.dart';

Future<List<Currency>> getRates() async {
  final url = Uri.parse('https://api.nbrb.by/exrates/rates?periodicity=0');

  final responce = await http.get(url);

  if (responce.statusCode == 200) {
    final List<dynamic> jsonResponce = json.decode(responce.body);
    return jsonResponce.map((item) => Currency.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load');
  }
}
