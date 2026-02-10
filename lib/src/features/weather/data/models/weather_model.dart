// dart class representing API data(like temp, city)

class Weather {
  final String cityName;
  final double temp;
  final int humidity;
  final double windSpeed;
  final String weatherCondition;
  final String icon;
  final double feelsLike;
  final int pressure;
  final int visibility;
  final DateTime sunrise;
  final DateTime sunset;

  Weather({
    required this.cityName,
    required this.temp,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCondition,
    required this.icon,
    required this.feelsLike,
    required this.pressure,
    required this.visibility,
    required this.sunrise,
    required this.sunset,
  });

  // factory constructor to create Weather from JSON
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temp: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      weatherCondition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      feelsLike: json['main']['feels_like'].toDouble(),
      pressure: json['main']['pressure'],
      visibility: json['visibility'],
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        json['sys']['sunrise'] * 1000,
      ),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
    );
  }

  /// Weather → represents the API data you care about
  /// fromJson → converts the API Map into a Weather object
  /// .toDouble() → ensures temperature is a double, even if API returns int
}
