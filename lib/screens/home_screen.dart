import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lapisco_challenge/blocs/config_bloc/config_bloc.dart';
import 'package:lapisco_challenge/blocs/config_bloc/config_state.dart';
import 'package:lapisco_challenge/widgets/weather_display_by_city.dart';
import 'package:lapisco_challenge/widgets/weather_display_by_geolocation.dart';
import 'package:lapisco_challenge/screens/settings_screen.dart';
import 'package:lapisco_challenge/widgets/location_search_field.dart';
import 'package:lapisco_challenge/blocs/weather_bloc/weather_bloc.dart';
import 'package:lapisco_challenge/blocs/weather_bloc/weather_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context).add(GetWeatherByGeolocation());
  }

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
      body: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, state) {
          final backgroundImage = state.isDarkMode
              ? 'assets/images/background2.png'
              : 'assets/images/background.png';
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
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
          );
        },
      ),
    );
  }
}
