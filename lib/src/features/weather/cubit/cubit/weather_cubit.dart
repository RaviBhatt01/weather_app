import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/src/features/weather/data/models/weather_model.dart';
import 'package:weather_app/src/features/weather/data/weather_api_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  Future<void> fetchWeatherByLocation() async {
    emit(WeatherLoading());

    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(WeatherError("Location services are disabled"));
        return;
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(WeatherError("Location permissions are denied"));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(WeatherError("Location permissions are permanently denied"));
        return;
      }

      Position position = await Geolocator.getCurrentPosition();

      print("LAT: ${position.latitude}, LON: ${position.longitude}");

      final weather = await WeatherApiService.fetchWeatherByLocation(
        position.latitude,
        position.longitude,
      );

      if (weather != null) {
        emit(WeatherLoaded(weather));
      } else {
        emit(WeatherError("Failed to load weather"));
      }
    } catch (e) {
      emit(WeatherError("Failed to load weather"));
    }
  }
}
