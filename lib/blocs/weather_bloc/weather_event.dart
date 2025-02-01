abstract class WeatherEvent {}

class GetWeatherByCity extends WeatherEvent {
  final String cityName;
  GetWeatherByCity(this.cityName);
}

class GetWeatherByGeolocation extends WeatherEvent {
  final double latitude;
  final double longitude;
  GetWeatherByGeolocation(this.latitude, this.longitude);
}
