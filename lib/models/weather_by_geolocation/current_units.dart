import 'package:collection/collection.dart';

class CurrentUnits {
  final String? time;
  final String? interval;
  final String? temperature2m;
  final String? relativeHumidity2m;
  final String? windSpeed10m;

  const CurrentUnits({
    this.time,
    this.interval,
    this.temperature2m,
    this.relativeHumidity2m,
    this.windSpeed10m,
  });

  @override
  String toString() {
    return 'CurrentUnits(time: $time, interval: $interval, temperature2m: $temperature2m, relativeHumidity2m: $relativeHumidity2m, windSpeed10m: $windSpeed10m)';
  }

  factory CurrentUnits.fromJson(Map<String, dynamic> json) {
    return CurrentUnits(
      time: json['time'],
      interval: json['interval'],
      temperature2m: json['temperature_2m'],
      relativeHumidity2m: json['relative_humidity_2m'],
      windSpeed10m: json['wind_speed_10m'],
    );
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'interval': interval,
        'temperature_2m': temperature2m,
        'relative_humidity_2m': relativeHumidity2m,
        'wind_speed_10m': windSpeed10m,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CurrentUnits) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      time.hashCode ^
      interval.hashCode ^
      temperature2m.hashCode ^
      relativeHumidity2m.hashCode ^
      windSpeed10m.hashCode;
}
