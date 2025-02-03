class WeatherByCity {
  final String cityName;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final List<double> dailyMaxTemperatures;
  final List<double> dailyMinTemperatures;

  WeatherByCity({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.dailyMaxTemperatures,
    required this.dailyMinTemperatures,
  });

  factory WeatherByCity.fromJson(Map<String, dynamic> json) {
    return WeatherByCity(
      cityName: json['city_name'] ?? 'Desconhecida',
      temperature: json['current']['temperature_2m'] ?? 0.0,
      humidity: json['current']['relative_humidity_2m'] ?? 0,
      windSpeed: json['current']['wind_speed_10m'] ?? 0.0,
      dailyMaxTemperatures:
          List<double>.from(json['daily']['temperature_2m_max'] ?? []),
      dailyMinTemperatures:
          List<double>.from(json['daily']['temperature_2m_min'] ?? []),
    );
  }
}
