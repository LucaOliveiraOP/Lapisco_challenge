import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lapisco_challenge/blocs/search_city_bloc.dart/search_city_bloc.dart';
import 'package:lapisco_challenge/blocs/search_city_bloc.dart/search_city_event.dart';
import 'package:lapisco_challenge/blocs/weather_bloc/weather_bloc.dart';
import 'package:lapisco_challenge/blocs/weather_bloc/weather_event.dart';

class LocationSearchField extends StatefulWidget {
  const LocationSearchField({super.key});

  @override
  State<LocationSearchField> createState() => _LocationSearchFieldState();
}

class _LocationSearchFieldState extends State<LocationSearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWeatherByGeolocation();
  }

  Future<void> _fetchWeatherByGeolocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      log('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      if (!mounted) return;
      context
          .read<WeatherBloc>()
          .add(GetWeatherByGeolocation(position.latitude, position.longitude));
    } catch (e) {
      if (!mounted) return;
      log("Erro ao obter geolocalização: $e");
    }
  }

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
              context.read<SearchCityBloc>().add(GetSearchByCity(cityName));
            }
          },
        ),
      ],
    );
  }
}
