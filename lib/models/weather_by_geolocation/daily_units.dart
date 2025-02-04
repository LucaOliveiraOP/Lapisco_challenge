import 'package:collection/collection.dart';

class DailyUnits {
  final String? time;
  final String? temperature2mMax;
  final String? temperature2mMin;

  const DailyUnits({
    this.time,
    this.temperature2mMax,
    this.temperature2mMin,
  });

  @override
  String toString() {
    return 'DailyUnits(time: $time, temperature2mMax: $temperature2mMax, temperature2mMin: $temperature2mMin)';
  }

  factory DailyUnits.fromJson(Map<String, dynamic> json) {
    return DailyUnits(
      time: json['time'],
      temperature2mMax: json['temperature_2m_max'],
      temperature2mMin: json['temperature_2m_min'],
    );
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'temperature_2m_max': temperature2mMax,
        'temperature_2m_min': temperature2mMin,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DailyUnits) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      time.hashCode ^ temperature2mMax.hashCode ^ temperature2mMin.hashCode;
}
