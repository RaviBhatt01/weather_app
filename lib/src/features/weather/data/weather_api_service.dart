// functions that call api(http.get)

import 'dart:convert'; // for JSON decoding
import 'package:http/http.dart' as http; // for HTTP requests

class WeatherApiService {
  static const String _apiKey = 'f5322b33a229fa203be38ebe93a2c78f';

  // Making the function static to call it without creating an object
  static Future<void> fetchWeather(String city) async {
    final Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final double temp = data['main']['temp'];
      print('Temperature in $city: $temp°C');

    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }
}
