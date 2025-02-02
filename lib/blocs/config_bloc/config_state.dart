class ConfigState {
  final bool isDarkMode;
  final bool isNotificationsEnabled;

  ConfigState({
    required this.isDarkMode,
    required this.isNotificationsEnabled,
  });

  ConfigState copyWith({
    bool? isDarkMode,
    bool? isNotificationsEnabled,
  }) {
    return ConfigState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isNotificationsEnabled:
          isNotificationsEnabled ?? this.isNotificationsEnabled,
    );
  }
}
