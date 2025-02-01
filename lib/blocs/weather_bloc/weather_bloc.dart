import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lapisco_challenge/services/weather_service.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc({required this.weatherService}) : super(WeatherInitial()) {
    on<GetWeatherByCity>(_onGetWeatherByCity);
    on<GetWeatherByGeolocation>(_onGetWeatherByGeolocation);
  }

  FutureOr<void> _onGetWeatherByCity(
      GetWeatherByCity event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weatherData =
          await weatherService.fetchWeatherByCity(event.cityName);
      emit(WeatherLoaded(weatherData));
    } catch (e) {
      emit(WeatherError("Erro ao carregar dados climáticos para a cidade."));
    }
  }

  FutureOr<void> _onGetWeatherByGeolocation(
      GetWeatherByGeolocation event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weatherData = await weatherService.fetchWeatherByGeolocation(
          event.latitude, event.longitude);
      emit(WeatherLoaded(weatherData));
    } catch (e) {
      emit(WeatherError(
          "Erro ao carregar dados climáticos pela geolocalização."));
    }
  }
}
