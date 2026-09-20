import 'package:flutter/material.dart';

extension WeatherCodeX on int {
  IconData get weatherIcon {
    return switch (this) {
      0 => Icons.wb_sunny,

      1 || 2 => Icons.wb_cloudy,

      3 => Icons.cloud,

      45 || 48 => Icons.foggy,

      51 || 53 || 55 => Icons.grain,

      61 || 63 || 65 => Icons.water_drop,

      71 || 73 || 75 => Icons.ac_unit,

      80 || 81 || 82 => Icons.grain,

      95 || 96 || 99 => Icons.thunderstorm,

      _ => Icons.cloud,
    };
  }

  String get weatherCondition {
    return switch (this) {
      0 => 'Clear sky',

      1 => 'Mainly clear',

      2 => 'Partly cloudy',

      3 => 'Overcast',

      45 || 48 => 'Fog',

      51 || 53 || 55 => 'Drizzle',

      61 || 63 || 65 => 'Rain',

      71 || 73 || 75 => 'Snow',

      80 || 81 || 82 => 'Rain showers',

      95 => 'Thunderstorm',

      96 || 99 => 'Thunderstorm with hail',

      _ => 'Unknown',
    };
  }
}
