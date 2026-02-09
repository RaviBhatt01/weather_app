import 'package:flutter/material.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/src/features/weather/data/weather_api_service.dart';
import 'package:weather_app/src/features/weather/data/models/weather_model.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() async {
  Weather? weather = await WeatherApiService.fetchWeather('Kathmandu');

  if (weather != null) {
    print("City: ${weather.cityName}");
    print("Temperature: ${weather.temp}°C");
  } else {
    print("Could not fetch weather");
  }
}
