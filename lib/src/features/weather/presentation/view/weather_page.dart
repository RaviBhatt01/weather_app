import 'package:flutter/material.dart';
import 'package:weather_app/src/features/weather/data/models/weather_model.dart';
import 'package:weather_app/src/features/weather/data/weather_api_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Weather? _weather;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final result = await WeatherApiService.fetchWeather("Kathmandu");

    setState(() {
      if (result != null) {
        _weather = result;
      } else {
        _error = "Failed to load weather";
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App"), centerTitle: true),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _error != null
            ? Text(_error!)
            : Column(
                spacing: 100,
                mainAxisAlignment: .center,
                children: [
                  Text("City: ${_weather!.cityName}", style: TextStyle(fontSize: 25)),
                  Text("${_weather!.temp}°C", style: TextStyle(fontSize: 45)),
                  SizedBox(height: 10),
                ],
              ),
      ),
    );
  }
}
