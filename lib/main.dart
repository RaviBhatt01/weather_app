import 'package:flutter/material.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/src/features/weather/data/weather_api_service.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() async {
  await WeatherApiService.fetchWeather('Kathmandu');
}
