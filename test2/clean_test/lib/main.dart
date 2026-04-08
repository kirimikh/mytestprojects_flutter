import 'package:flutter/material.dart';
import 'hat.dart';
import 'content.dart';
import 'api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print("--- ЗАПУСК ТЕСТА API ---");
  try {
    final data = await getRates();
    print("Успех! Найдено валют: ${data.length}");
    print("Первая валюта: ${data[0].abbreviation} - ${data[0].rate}");
  } catch (e) {
    print("Ошибка при загрузке: $e");
  }

  runApp(
    MaterialApp(
      home: Scaffold(
        body: CustomScrollView(slivers: [SliverHat(), SliverContent()]),
      ),
    ),
  );
}
