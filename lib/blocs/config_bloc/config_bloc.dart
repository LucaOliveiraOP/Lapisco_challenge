import 'package:flutter_bloc/flutter_bloc.dart';
import 'config_event.dart';
import 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc()
      : super(ConfigState(isDarkMode: false, isNotificationsEnabled: true)) {
    on<SetLightThemeEvent>((event, emit) {
      emit(state.copyWith(isDarkMode: false));
    });

    on<SetDarkThemeEvent>((event, emit) {
      emit(state.copyWith(isDarkMode: true));
    });

    on<SetNotificationsEnabledEvent>((event, emit) {
      emit(state.copyWith(isNotificationsEnabled: event.isEnabled));
    });
  }
}
