import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lapisco_challenge/models/weather_data.dart';

class WeatherService {
  final String apiUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<WeatherData> fetchWeatherByCity(String cityName) async {
    final geocodingUrl = Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$cityName');

    try {
      final geocodingResponse = await http.get(geocodingUrl);

      if (geocodingResponse.statusCode == 200) {
        final geocodingData = json.decode(geocodingResponse.body);

        if (geocodingData['results'] != null &&
            geocodingData['results'].isNotEmpty) {
          final latitude = geocodingData['results'][0]['latitude'];
          final longitude = geocodingData['results'][0]['longitude'];

          final weatherUrl = Uri.parse(
              '$apiUrl?latitude=$latitude&longitude=$longitude&daily=temperature_2m_max,temperature_2m_min&timezone=auto');

          final weatherResponse = await http.get(weatherUrl);

          if (weatherResponse.statusCode == 200) {
            final weatherData = json.decode(weatherResponse.body);
            return WeatherData.fromJson(weatherData);
          } else {
            throw Exception('Erro ao carregar dados climáticos');
          }
        } else {
          throw Exception('Cidade não encontrada');
        }
      } else {
        throw Exception('Erro ao obter coordenadas da cidade');
      }
    } catch (e) {
      throw Exception('Erro ao obter dados da cidade: $e');
    }
  }

  Future<WeatherData> fetchWeatherByGeolocation(
      double latitude, double longitude) async {
    final weatherUrl = Uri.parse(
        '$apiUrl?latitude=$latitude&longitude=$longitude&daily=temperature_2m_max,temperature_2m_min&timezone=auto');

    try {
      final response = await http.get(weatherUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherData.fromJson(data);
      } else {
        throw Exception('Erro ao carregar dados climáticos');
      }
    } catch (e) {
      throw Exception('Erro ao buscar dados climáticos: $e');
    }
  }
}
