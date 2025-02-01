import 'package:lapisco_challenge/models/weather_data.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherData weatherData;
  WeatherLoaded(this.weatherData);
}

class WeatherError extends WeatherState {
  final String errorMessage;
  WeatherError(this.errorMessage);
}
