abstract class SearchCityEvent {}

class GetSearchByCity extends SearchCityEvent {
  final String cityName;
  GetSearchByCity(this.cityName);
}
