import 'dart:developer';

class WeatherByCity {
  final String cityName;
  final String admin1;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final List<double> dailyMaxTemperatures;
  final List<double> dailyMinTemperatures;
  final int? weatherCode;

  WeatherByCity({
    required this.weatherCode,
    required this.cityName,
    required this.admin1,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.dailyMaxTemperatures,
    required this.dailyMinTemperatures,
  });

  factory WeatherByCity.fromJson(Map<String, dynamic> json) {
    var results = json;
    log("teste =$results");
    String admin1 = (results.isNotEmpty && results['admin1'] != null)
        ? results['admin1']
        : 'Desconhecido';

    return WeatherByCity(
      weatherCode: json['current'] != null
          ? (json['current']['weather_code'] != null
              ? int.tryParse(json['current']['weather_code'].toString())
              : null)
          : null,
      cityName: json['city_name'] ?? 'Desconhecida',
      admin1: admin1,
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
