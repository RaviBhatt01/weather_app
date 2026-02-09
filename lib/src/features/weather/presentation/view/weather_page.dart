import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
    // _fetchWeather();
    _getCurrentLocation();
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

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _error = "Location services are disabled";
        _isLoading = false;
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _error = "Location permission denied";
          _isLoading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _error = "Location permission permanently denied";
        _isLoading = false;
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    print("LAT: ${position.latitude}, LON: ${position.longitude}");

    // fetch weather using coordinates
    Weather? weather = await WeatherApiService.fetchWeatherByLocation(
      position.latitude,
      position.longitude,
    );

    setState(() {
      if (weather != null) {
        _weather = weather;
        _error = null;
      } else {
        _error = "Failed to load weather";
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: () => _getCurrentLocation(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: _isLoading
                ? const CircularProgressIndicator()
                : _error != null
                ? Text(_error!)
                : Column(
                    spacing: 100,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Text(
                        "City: ${_weather!.cityName}",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Text(
                        "${_weather!.temp}°C",
                        style: TextStyle(fontSize: 45, color: Colors.white),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
