import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:lapisco_challenge/models/weather_by_city/weather_by_city.dart';
import 'package:lapisco_challenge/models/weather_by_geolocation/weather_by_geo.dart';

class WeatherService {
  final String apiUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<WeatherByCity> fetchWeatherByCity(String cityName) async {
    final geocodingUrl = Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$cityName');
    log('geocodingUrl = $geocodingUrl');

    try {
      final geocodingResponse = await http.get(geocodingUrl);
      log('geocodingResponse(${geocodingResponse.statusCode}) = ${geocodingResponse.body}');

      if (geocodingResponse.statusCode == 200) {
        final geocodingData = json.decode(geocodingResponse.body);
        log('geocodingData = $geocodingData');

        if (geocodingData['results'] != null &&
            geocodingData['results'].isNotEmpty) {
          final latitude = geocodingData['results'][0]['latitude'];
          final longitude = geocodingData['results'][0]['longitude'];
          final cityNameFromApi = geocodingData['results'][0]['name'];

          final admin1FromApi =
              geocodingData['results'][0]['admin1'] ?? 'Desconhecido';
          log('admin1FromApi = $admin1FromApi');

          final weatherUrl = Uri.parse(
              '$apiUrl?latitude=$latitude&longitude=$longitude&current=temperature_2m,relative_humidity_2m,is_day,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=America%2FSao_Paulo');

          final weatherResponse = await http.get(weatherUrl);
          log('weatherResponse(${weatherResponse.statusCode}) = ${weatherResponse.body}');

          if (weatherResponse.statusCode == 200) {
            final weatherData = json.decode(weatherResponse.body);

            log('weatherData = $weatherData');

            if (weatherData['current'] != null) {
              log('Current weather data: ${weatherData['current']}');
              if (weatherData['current']['weather_code'] != null) {
                log('Current weather code: ${weatherData['current']['weather_code']}');
              } else {
                log('Weather code not available in current data');
              }
            } else {
              log('No current weather data found');
            }

            return WeatherByCity.fromJson({
              'city_name': cityNameFromApi,
              'admin1': admin1FromApi,
              ...weatherData,
            });
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

  Future<WeatherByGeolocation> fetchWeatherByGeolocation(
      double latitude, double longitude) async {
    final weatherUrl = Uri.parse(
        '$apiUrl?latitude=$latitude&longitude=$longitude'
        '&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code'
        '&daily=temperature_2m_max,temperature_2m_min,weather_code'
        '&timezone=auto');

    log('weatherUrl = $weatherUrl');

    try {
      final response = await http.get(weatherUrl);
      log('response(${response.statusCode}) = ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        log('weatherData = $data');

        if (data['current'] != null) {
          log('Current weather data: ${data['current']}');
          if (data['current']['weather_code'] != null) {
            log('Current weather code: ${data['current']['weather_code']}');
          } else {
            log('Weather code not available in current data');
          }
        } else {
          log('No current weather data found');
        }

        return WeatherByGeolocation.fromJson(data);
      } else {
        throw Exception('Erro ao carregar dados climáticos');
      }
    } catch (e) {
      log('Erro ao buscar dados climáticos: $e');
      throw Exception('Erro ao buscar dados climáticos: $e');
    }
  }
}
