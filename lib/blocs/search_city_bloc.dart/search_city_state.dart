import 'package:lapisco_challenge/models/weather_by_city/weather_by_city.dart';

abstract class SearchCityState {}

class SearchInitial extends SearchCityState {}

class SearchLoading extends SearchCityState {}

class SearchLoadedByCity extends SearchCityState {
  final WeatherByCity weatherData;
  SearchLoadedByCity(this.weatherData);
}

class SearchError extends SearchCityState {
  final String errorMessage;
  SearchError(this.errorMessage);
}
