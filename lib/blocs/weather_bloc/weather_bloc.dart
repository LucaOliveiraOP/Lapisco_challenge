import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lapisco_challenge/services/weather_service.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc({required this.weatherService}) : super(WeatherInitial()) {
    on<GetWeatherByGeolocation>(_onGetWeatherByGeolocation);
  }

  Future<void> _onGetWeatherByGeolocation(
      GetWeatherByGeolocation event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    try {
      Position position = await weatherService.getLocationAndPermission();

      final weatherData = await weatherService.fetchWeatherByGeolocation(
          position.latitude, position.longitude);

      emit(WeatherLoadedByGeolocation(weatherData));
    } catch (e) {
      emit(WeatherError(
          "Erro ao carregar dados climáticos pela geolocalização."));
    }
  }
}
