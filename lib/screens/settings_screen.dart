import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lapisco_challenge/blocs/config_bloc/config_bloc.dart';
import 'package:lapisco_challenge/blocs/config_bloc/config_event.dart';
import 'package:lapisco_challenge/blocs/config_bloc/config_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, state) {
          final backgroundImage = state.isDarkMode
              ? 'assets/images/background2.png'
              : 'assets/images/background.png';

          // Definir as cores de texto dependendo do tema
          final textColor = state.isDarkMode ? Colors.white : Colors.black;
          final shadowColor = state.isDarkMode ? Colors.black : Colors.white;

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        'Modo Escuro',
                        style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: shadowColor,
                            ),
                          ],
                        ),
                      ),
                      // Texto real
                      Text(
                        'Modo Escuro',
                        style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<ConfigBloc, ConfigState>(
                    builder: (context, configState) {
                      return Switch(
                        value: configState.isDarkMode,
                        onChanged: (bool value) {
                          if (value) {
                            context.read<ConfigBloc>().add(SetDarkThemeEvent());
                          } else {
                            context
                                .read<ConfigBloc>()
                                .add(SetLightThemeEvent());
                          }
                          final snackBar = SnackBar(
                            content: const Text(
                              'Tema alterado com sucesso!',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: const Color(0xFF28A745),
                            duration: const Duration(seconds: 2),
                            padding: const EdgeInsets.only(
                                left: 16, top: 16, bottom: 16),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        activeColor: const Color(0xFF28A745),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  // Texto "Notificações" com contorno
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Texto com contorno (sombra)
                      Text(
                        'Notificações',
                        style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: shadowColor,
                            ),
                          ],
                        ),
                      ),
                      // Texto real
                      Text(
                        'Notificações',
                        style: TextStyle(
                          fontSize: 20,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: false,
                    onChanged: (bool value) {
                      final snackBar = SnackBar(
                        content: const Text(
                          'Essa funcionalidade ainda não foi implementada!',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 2),
                        padding: const EdgeInsets.only(
                            left: 16, top: 16, bottom: 16),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    activeColor: Colors.red,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
