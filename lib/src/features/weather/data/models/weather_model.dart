// dart class representing API data(like temp, city)

class Weather {
  final String cityName;
  final double temp;

  Weather({required this.cityName, required this.temp});

  // factory constructor to create Weather from JSON
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temp: json['main']['temp'].toDouble(),
    );
  }

  /// Weather → represents the API data you care about
  /// fromJson → converts the API Map into a Weather object
  /// .toDouble() → ensures temperature is a double, even if API returns int
}
