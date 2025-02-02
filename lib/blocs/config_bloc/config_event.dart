abstract class ConfigEvent {}

class SetLightThemeEvent extends ConfigEvent {}

class SetDarkThemeEvent extends ConfigEvent {}

class SetNotificationsEnabledEvent extends ConfigEvent {
  final bool isEnabled;

  SetNotificationsEnabledEvent(this.isEnabled);
}
