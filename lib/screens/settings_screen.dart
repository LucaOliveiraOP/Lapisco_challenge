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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Modo Escuro',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              BlocBuilder<ConfigBloc, ConfigState>(
                builder: (context, configState) {
                  return Switch(
                    value: configState.isDarkMode,
                    onChanged: (bool value) {
                      if (value) {
                        context.read<ConfigBloc>().add(SetDarkThemeEvent());
                      } else {
                        context.read<ConfigBloc>().add(SetLightThemeEvent());
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
              const Text(
                'Notificações',
                style: TextStyle(fontSize: 20, color: Colors.black),
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
                    padding:
                        const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                activeColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
