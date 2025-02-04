import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lapisco_challenge/blocs/search_city_bloc.dart/search_city_event.dart';
import 'package:lapisco_challenge/blocs/search_city_bloc.dart/search_city_state.dart';
import 'package:lapisco_challenge/services/weather_service.dart';

class SearchCityBloc extends Bloc<SearchCityEvent, SearchCityState> {
  final WeatherService weatherService;

  SearchCityBloc({required this.weatherService}) : super(SearchInitial()) {
    on<GetSearchByCity>(_onGetSearchByCity);
  }

  Future<void> _onGetSearchByCity(
      GetSearchByCity event, Emitter<SearchCityState> emit) async {
    emit(SearchLoading());
    try {
      final weatherData =
          await weatherService.fetchWeatherByCity(event.cityName);
      emit(SearchLoadedByCity(weatherData));
    } catch (e) {
      emit(SearchError("Erro ao carregar dados climáticos para a cidade."));
    }
  }
}
