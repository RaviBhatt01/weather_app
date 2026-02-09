// functions that call api(http.get)

import 'dart:convert'; // for JSON decoding
import 'package:http/http.dart' as http; // for HTTP requests
import 'package:weather_app/src/features/weather/data/models/weather_model.dart';

class WeatherApiService {
  static const String _apiKey = 'f5322b33a229fa203be38ebe93a2c78f';

  // Making the function static to call it without creating an object
  static Future<Weather?> fetchWeather(String city) async {
    final Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print("\n${response.body}");

      // final double temp = data['main']['temp'];
      // print('Temperature in $city: $temp°C');

      final weather = Weather.fromJson(data);
      return weather; // return Weather object
      // print('Temperature in ${weather.cityName}: ${weather.temp}°C');
    } else {
      print("Request failed with status: ${response.statusCode}");
      return null; // return null if request fails
    }
  }

  static Future<Weather?> fetchWeatherByLocation(double lat, double lon) async {
    final Uri url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      print("Request failed with status: ${response.statusCode}");
      return null;
    }
  }
}
