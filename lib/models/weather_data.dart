class WeatherData {
  final String cityName;
  final double temperature;
  final double humidity;
  final double windSpeed;
  final String description;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['city'] ?? 'Desconhecida',
      temperature: json['temperature'] ?? 0.0,
      humidity: json['humidity'] ?? 0.0,
      windSpeed: json['windspeed'] ?? 0.0,
      description: json['weather']['description'] ?? 'Desconhecido',
    );
  }
}
