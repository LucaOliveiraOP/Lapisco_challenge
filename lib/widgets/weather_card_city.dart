import 'package:flutter/material.dart';
import 'package:lapisco_challenge/models/weather_by_city/weather_by_city.dart';
import 'package:lapisco_challenge/widgets/temperature_chart.dart';
import 'package:lottie/lottie.dart';

class WeatherCardByCity extends StatefulWidget {
  final WeatherByCity weatherData;

  const WeatherCardByCity({super.key, required this.weatherData});

  @override
  State<WeatherCardByCity> createState() => _WeatherCardByCityState();
}

class _WeatherCardByCityState extends State<WeatherCardByCity> {
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double cardHeight = screenHeight * 0.210;

    String lottieAsset = 'assets/images/solanimacao.json';
    if (widget.weatherData.weatherCode != null) {
      int weatherCode = widget.weatherData.weatherCode!;

      if (weatherCode == 0 || weatherCode == 1) {
        lottieAsset = 'assets/images/solanimacao.json';
      } else if (weatherCode >= 2 && weatherCode <= 4) {
        lottieAsset = 'assets/images/solnubladoanimacao.json';
      } else if (weatherCode >= 5 && weatherCode <= 8) {
        lottieAsset = 'assets/images/solchovendo.json';
      }
    }

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
                            maxTemps: widget.weatherData.dailyMaxTemperatures,
                            minTemps: widget.weatherData.dailyMinTemperatures,
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
                              '${widget.weatherData.cityName}, ${widget.weatherData.admin1}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const Spacer(),
                            Lottie.asset(
                              lottieAsset, // Lottie animation based on weatherCode
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
                              '${widget.weatherData.humidity}%',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const Icon(
                              Icons.water_drop_outlined,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.weatherData.temperature}°C',
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
                              '${widget.weatherData.windSpeed} km/h',
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
