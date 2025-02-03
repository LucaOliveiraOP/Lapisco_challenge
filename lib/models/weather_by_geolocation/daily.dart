import 'package:collection/collection.dart';

class Daily {
  final List<String>? time;
  final List<double>? temperature2mMax;
  final List<double>? temperature2mMin;

  const Daily({this.time, this.temperature2mMax, this.temperature2mMin});

  @override
  String toString() {
    return 'Daily(time: $time, temperature2mMax: $temperature2mMax, temperature2mMin: $temperature2mMin)';
  }

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      time: json['time']?.cast<String>(),
      temperature2mMax: json['temperature_2m_max']?.cast<double>(),
      temperature2mMin: json['temperature_2m_min']?.cast<double>(),
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
    if (other is! Daily) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      time.hashCode ^ temperature2mMax.hashCode ^ temperature2mMin.hashCode;
}
