import 'package:lapisco_challenge/models/weather_by_geolocation/weather_by_geo.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoadedByGeolocation extends WeatherState {
  final WeatherByGeolocation weatherData;
  WeatherLoadedByGeolocation(this.weatherData);
}

class WeatherError extends WeatherState {
  final String errorMessage;
  WeatherError(this.errorMessage);
}
