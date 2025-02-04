import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lapisco_challenge/blocs/config_bloc/config_bloc.dart';
import 'package:lapisco_challenge/blocs/config_bloc/config_state.dart';
import 'package:lapisco_challenge/blocs/search_city_bloc.dart/search_city_bloc.dart';
import 'package:lapisco_challenge/blocs/weather_bloc/weather_bloc.dart';
import 'package:lapisco_challenge/screens/settings_screen.dart';
import 'package:lapisco_challenge/services/weather_service.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherService = WeatherService();

    return MultiBlocProvider(
      providers: [
        RepositoryProvider(create: (_) => weatherService),
        BlocProvider(create: (_) => ConfigBloc()),
        BlocProvider(
          create: (context) => WeatherBloc(weatherService: weatherService),
        ),
        BlocProvider(
          create: (context) => SearchCityBloc(weatherService: weatherService),
        ),
      ],
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, configState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              brightness:
                  configState.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            home: const HomeScreen(),
            routes: {
              '/settings': (context) => const SettingsPage(),
            },
          );
        },
      ),
    );
  }
}
