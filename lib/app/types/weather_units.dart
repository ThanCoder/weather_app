enum WeatherUnits {
  metric,
  imperial,
}

extension WeatherUnitsExtension on WeatherUnits {
  static String getLabel(WeatherUnits type) {
    if (type == WeatherUnits.imperial) {
      return '°F';
    }
    if (type == WeatherUnits.metric) {
      return '°C';
    }
    return '°C';
  }
}
