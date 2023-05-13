import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weathervoir/src/ui/home_weather.dart';
import 'src/app.dart';

final dio = Dio();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeWeather(),
    );
  }
}
