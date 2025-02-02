import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lapisco_challenge/models/weather_by_geolocation/weather_data.dart';
import 'package:lapisco_challenge/widgets/temperature_chart.dart';

class WeatherCardByGeolocation extends StatefulWidget {
  final WeatherByGeolocation weatherData;

  const WeatherCardByGeolocation({super.key, required this.weatherData});

  @override
  State<WeatherCardByGeolocation> createState() =>
      _WeatherCardByGeolocationState();
}

class _WeatherCardByGeolocationState extends State<WeatherCardByGeolocation> {
  String cityName = '';
  bool _showChart = false;

  Future<void> getName(double latitude, double longitude) async {
    log('latitude = $latitude && longitude = $longitude');
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    log('placemarks = $placemarks');
    cityName =
        '${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea}';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getName(
        widget.weatherData.latitude ?? 0, widget.weatherData.longitude ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double cardHeight = screenHeight * 0.25;
    double cardWidth = screenWidth * 0.9;

    return GestureDetector(
      onTap: () {
        setState(() {
          _showChart = !_showChart;
        });
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _showChart
                ? SizedBox(
                    key: ValueKey<bool>(_showChart),
                    width: cardWidth,
                    height: cardHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: cardHeight * 0.7,
                          child: BarChartSample2(
                            maxTemps:
                                widget.weatherData.daily?.temperature2mMax ??
                                    [],
                            minTemps:
                                widget.weatherData.daily?.temperature2mMin ??
                                    [],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showChart = false;
                            });
                          },
                          child: const Text('Voltar'),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    key: ValueKey<bool>(_showChart),
                    width: cardWidth,
                    height: cardHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cityName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.thermostat_outlined,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.weatherData.current?.temperature2m ?? '-'}${widget.weatherData.currentUnits?.temperature2m ?? '-'}',
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.water_drop_outlined,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.weatherData.current?.relativeHumidity2m ?? '-'}${widget.weatherData.currentUnits?.relativeHumidity2m ?? '-'}',
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
                              '${widget.weatherData.current?.windSpeed10m ?? '-'}${widget.weatherData.currentUnits?.windSpeed10m ?? '-'}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getWeatherIcon(
                                  widget.weatherData.current?.temperature2m ??
                                      0),
                              size: 40,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  IconData _getWeatherIcon(double temperature) {
    if (temperature > 25) {
      return Icons.sunny;
    } else if (temperature < 15) {
      return Icons.cloud;
    } else {
      return Icons.cloud_queue;
    }
  }
}
