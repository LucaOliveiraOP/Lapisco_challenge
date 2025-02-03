import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lapisco_challenge/blocs/search_city_bloc.dart/search_city_bloc.dart';
import 'package:lapisco_challenge/blocs/search_city_bloc.dart/search_city_state.dart';
import 'package:lapisco_challenge/widgets/weather_card_city.dart';

class WeatherDisplayByCity extends StatelessWidget {
  const WeatherDisplayByCity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCityBloc, SearchCityState>(
      listener: (context, state) {
        if (state is SearchLoadedByCity) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                "Cidade adicionada com sucesso!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: const Color(0xFF28A745),
              duration: const Duration(seconds: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
          );
        } else if (state is SearchError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: BlocBuilder<SearchCityBloc, SearchCityState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchLoadedByCity) {
            return WeatherCardByCity(weatherData: state.weatherData);
          } else if (state is SearchError) {
            return Center(child: Text(state.errorMessage));
          }
          return const Center(
            child: Text('Agora, pesquise por uma cidade'),
          );
        },
      ),
    );
  }
}
