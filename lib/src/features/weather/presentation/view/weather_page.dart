import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/features/weather/cubit/cubit/weather_cubit.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/weather_detail.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().fetchWeatherByLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather Forecast",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: () => context.read<WeatherCubit>().fetchWeatherByLocation(),
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Center(
                child: state is WeatherLoading
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(height: 200),
                            CircularProgressIndicator(),
                          ],
                        ),
                      )
                    : state is WeatherError
                    ? Column(
                        mainAxisAlignment: .center,
                        children: [
                          SizedBox(height: 200),
                          Text(
                            state.message,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      )
                    : state is WeatherLoaded
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          Column(
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                color: Colors.white60,
                                size: 30,
                              ),
                              Text(
                                state.weather.cityName,
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Weather Icon
                          if (state.weather.icon.isNotEmpty)
                            Image.network(
                              'https://openweathermap.org/img/wn/${state.weather.icon}@4x.png',
                              width: 150,
                              height: 150,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.cloud,
                                  size: 100,
                                  color: Colors.white,
                                );
                              },
                            ),
                          Text(
                            "${state.weather.temp.round()}°C",
                            style: const TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            state.weather.weatherCondition,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Feels like ${state.weather.feelsLike.round()}°C",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white54,
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Additional Data Row
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    WeatherDetail(
                                      icon: Icons.water_drop,
                                      label: "Humidity",
                                      value: "${state.weather.humidity}%",
                                    ),
                                    WeatherDetail(
                                      icon: Icons.air,
                                      label: "Wind",
                                      value: "${state.weather.windSpeed} m/s",
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Divider(color: Colors.white24),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    WeatherDetail(
                                      icon: Icons.speed,
                                      label: "Pressure",
                                      value: "${state.weather.pressure} hPa",
                                    ),
                                    WeatherDetail(
                                      icon: Icons.visibility,
                                      label: "Visibility",
                                      value:
                                          "${(state.weather.visibility / 1000).toStringAsFixed(1)} km",
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                const Divider(color: Colors.white24),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    WeatherDetail(
                                      icon: Icons.wb_sunny_outlined,
                                      label: "Sunrise",
                                      value:
                                          "${state.weather.sunrise.hour}:${state.weather.sunrise.minute.toString().padLeft(2, '0')}",
                                    ),
                                    WeatherDetail(
                                      icon: Icons.nightlight_round_outlined,
                                      label: "Sunset",
                                      value:
                                          "${state.weather.sunset.hour}:${state.weather.sunset.minute.toString().padLeft(2, '0')}",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      )
                    : SizedBox.shrink(),
              ),
            );
          },
        ),
      ),
    );
  }
}
