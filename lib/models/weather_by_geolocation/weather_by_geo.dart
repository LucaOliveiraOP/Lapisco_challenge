import 'current.dart';
import 'current_units.dart';
import 'daily.dart';
import 'daily_units.dart';

class WeatherByGeolocation {
  final double? latitude;
  final double? longitude;
  final double? generationtimeMs;
  final int? utcOffsetSeconds;
  final String? timezone;
  final String? timezoneAbbreviation;
  final int? elevation;
  final CurrentUnits? currentUnits;
  final Current? current;
  final DailyUnits? dailyUnits;
  final Daily? daily;
  final int? weatherCode;

  const WeatherByGeolocation({
    this.weatherCode,
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.currentUnits,
    this.current,
    this.dailyUnits,
    this.daily,
  });

  factory WeatherByGeolocation.fromJson(Map<String, dynamic> json) {
    return WeatherByGeolocation(
      weatherCode: json['current'] != null
          ? (json['current']['weather_code'] != null
              ? int.tryParse(json['current']['weather_code'].toString())
              : null)
          : null,
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      generationtimeMs: json['generationtime_ms']?.toDouble(),
      utcOffsetSeconds: json['utc_offset_seconds']?.toInt(),
      timezone: json['timezone']?.toString(),
      timezoneAbbreviation: json['timezone_abbreviation']?.toString(),
      elevation: json['elevation']?.toInt(),
      currentUnits: json['current_units'] != null
          ? CurrentUnits.fromJson(json['current_units'])
          : null,
      current:
          json['current'] != null ? Current.fromJson(json['current']) : null,
      dailyUnits: json['daily_units'] != null
          ? DailyUnits.fromJson(json['daily_units'])
          : null,
      daily: json['daily'] != null ? Daily.fromJson(json['daily']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'generationtime_ms': generationtimeMs,
        'utc_offset_seconds': utcOffsetSeconds,
        'timezone': timezone,
        'timezone_abbreviation': timezoneAbbreviation,
        'elevation': elevation,
        'current_units': currentUnits?.toJson(),
        'current': current?.toJson(),
        'daily_units': dailyUnits?.toJson(),
        'daily': daily?.toJson(),
        'weather_code': weatherCode,
      };
}
