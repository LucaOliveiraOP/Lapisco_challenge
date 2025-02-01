import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lapisco_challenge/blocs/weather_bloc/weather_bloc.dart';
import 'package:lapisco_challenge/blocs/weather_bloc/weather_event.dart';
import 'package:lapisco_challenge/screens/settings_screen.dart';
import 'package:lapisco_challenge/widgets/weather_display.dart';
import 'package:lapisco_challenge/utils/config.dart';

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
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _LocationSearchField(),
            const SizedBox(height: 16),
            const WeatherDisplay(),
          ],
        ),
      ),
    );
  }
}

class _LocationSearchField extends StatefulWidget {
  @override
  State<_LocationSearchField> createState() => _LocationSearchFieldState();
}

class _LocationSearchFieldState extends State<_LocationSearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Digite uma cidade',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            final cityName = _controller.text.trim();
            if (cityName.isNotEmpty) {
              context.read<WeatherBloc>().add(GetWeatherByCity(cityName));
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.my_location),
          onPressed: () async {
            try {
              Position position = await Config.getCurrentLocation();

              context.read<WeatherBloc>().add(
                    GetWeatherByGeolocation(
                        position.latitude, position.longitude),
                  );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro ao obter localização: $e')),
              );
            }
          },
        ),
      ],
    );
  }
}
