import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/features/weather/cubit/cubit/weather_cubit.dart';

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
          "Weather App",
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
                        spacing: 120,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 100),
                          Column(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: Colors.white60,
                                size: 30,
                              ),
                              Text(
                                state.weather.cityName,
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${state.weather.temp}°C",
                            style: TextStyle(fontSize: 45, color: Colors.white),
                          ),
                          SizedBox(height: 100),
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
