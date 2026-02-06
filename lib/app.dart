import 'package:flutter/material.dart';
import 'package:weather_app/src/features/weather/presentation/view/weather_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Weather App', home: const WeatherPage());
  }
}

