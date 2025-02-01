import 'package:flutter/material.dart';
import 'package:lapisco_challenge/models/weather_data.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherCard({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weatherData.cityName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),

            // Temperatura
            Row(
              children: [
                const Icon(
                  Icons.thermostat_outlined,
                  color: Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  '${weatherData.temperature}°C',
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Umidade
            Row(
              children: [
                const Icon(
                  Icons.water_drop_outlined,
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                Text(
                  '${weatherData.humidity}%',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(
                  Icons.air_outlined,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                Text(
                  '${weatherData.windSpeed} km/h',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
