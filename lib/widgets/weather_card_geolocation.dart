import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lapisco_challenge/models/weather_by_geolocation/weather_by_geo.dart';
import 'package:lapisco_challenge/widgets/temperature_chart.dart';
import 'package:lottie/lottie.dart';

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
    double cardHeight = screenHeight * 0.210;

    String lottieAsset = 'assets/images/solanimacao.json';
    if (widget.weatherData.weatherCode != null) {
      int weatherCode = widget.weatherData.weatherCode!;

      if (weatherCode == 0) {
        lottieAsset = 'assets/images/solanimacao.json';
      } else if (weatherCode >= 1 && weatherCode <= 4) {
        lottieAsset = 'assets/images/solnubladoanimacao.json';
      } else if (weatherCode >= 5 && weatherCode <= 8) {
        lottieAsset = 'assets/images/solchovendo.json';
      }
    }

    return GestureDetector(
      onTap: () {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _showChart = !_showChart;
          });
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
                    width: screenWidth * 0.9,
                    height: cardHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          "Máximas e mínimas dos próximos 7 dias.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        SizedBox(
                          height: cardHeight * 0.75,
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
                      ],
                    ),
                  )
                : SizedBox(
                    key: ValueKey<bool>(_showChart),
                    width: screenWidth * 0.9,
                    height: cardHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              cityName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const Spacer(),
                            Lottie.asset(
                              lottieAsset,
                              width: 100,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 8),
                            Text(
                              '${widget.weatherData.current?.relativeHumidity2m ?? '-'}${widget.weatherData.currentUnits?.relativeHumidity2m ?? '-'}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const Icon(
                              Icons.water_drop_outlined,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.weatherData.current?.temperature2m ?? '-'}${widget.weatherData.currentUnits?.temperature2m ?? '-'}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const Icon(
                              Icons.thermostat_outlined,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 8),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.weatherData.current?.windSpeed10m ?? '-'}${widget.weatherData.currentUnits?.windSpeed10m ?? '-'}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.air_outlined,
                              color: Colors.green,
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
}
