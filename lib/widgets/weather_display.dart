import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lapisco_challenge/blocs/weather_bloc/weather_bloc.dart';
import 'package:lapisco_challenge/blocs/weather_bloc/weather_state.dart';
import 'package:lapisco_challenge/widgets/weather_card.dart';

class WeatherDisplay extends StatelessWidget {
  const WeatherDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WeatherLoaded) {
          return WeatherCard(weatherData: state.weatherData);
        } else if (state is WeatherError) {
          return const Center(child: Text('Erro ao carregar dados climáticos'));
        }
        return const Center(child: Text('Selecione uma cidade'));
      },
    );
  }
}
