abstract class WeatherEvent {}

class GetWeatherByGeolocation extends WeatherEvent {
  final double latitude;
  final double longitude;
  GetWeatherByGeolocation(this.latitude, this.longitude);
}
