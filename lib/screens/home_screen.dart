import 'package:flutter/material.dart';
import 'package:lapisco_challenge/widgets/weather_display_by_city.dart';
import 'package:lapisco_challenge/widgets/weather_display_by_geolocation.dart';
import 'package:lapisco_challenge/screens/settings_screen.dart';
import 'package:lapisco_challenge/widgets/location_search_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previsão do Tempo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LocationSearchField(),
                    const SizedBox(height: 16),
                    WeatherDisplayByCity(),
                    const SizedBox(height: 16),
                    WeatherDisplayByGeolocation(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
