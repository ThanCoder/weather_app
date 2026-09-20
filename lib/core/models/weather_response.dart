// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeatherResponse {
  const WeatherResponse({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.utcOffsetSeconds,
    required this.location,
    required this.date,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;
    final hourly = json['hourly'] as Map<String, dynamic>;
    final daily = json['daily'] as Map<String, dynamic>;

    return WeatherResponse(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      timezone: json['timezone'] as String? ?? 'auto',
      utcOffsetSeconds: json['utc_offset_seconds'] as int? ?? 0,

      location: WeatherLocation(
        name: json['timezone'] as String? ?? 'Unknown',
        country: null,
      ),

      date: DateTime.parse(current['time'] as String),

      current: CurrentWeather.fromJson(current),

      hourly: HourlyWeather.fromJson(hourly),

      daily: DailyWeather.fromJson(daily),
    );
  }

  final double latitude;
  final double longitude;

  final String timezone;
  final int utcOffsetSeconds;

  final WeatherLocation location;

  final DateTime date;

  final CurrentWeather current;

  final List<HourlyWeather> hourly;

  final List<DailyWeather> daily;

  WeatherResponse copyWith({
    double? latitude,
    double? longitude,
    String? timezone,
    int? utcOffsetSeconds,
    WeatherLocation? location,
    DateTime? date,
    CurrentWeather? current,
    List<HourlyWeather>? hourly,
    List<DailyWeather>? daily,
  }) {
    return WeatherResponse(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timezone: timezone ?? this.timezone,
      utcOffsetSeconds: utcOffsetSeconds ?? this.utcOffsetSeconds,
      location: location ?? this.location,
      date: date ?? this.date,
      current: current ?? this.current,
      hourly: hourly ?? this.hourly,
      daily: daily ?? this.daily,
    );
  }
}

final class WeatherLocation {
  const WeatherLocation({
    required this.name,
    this.county,
    this.state,
    this.country,
    this.countryCode,
  });

  final String name;
  final String? county;
  final String? state;
  final String? country;
  final String? countryCode;
}

final class WeatherLocationResult {
  const WeatherLocationResult({required this.name, this.country});

  factory WeatherLocationResult.fromJson(Map<String, dynamic> json) {
    return WeatherLocationResult(
      name: json['name'] as String? ?? 'Unknown',
      country: json['country'] as String?,
    );
  }

  final String name;
  final String? country;
}

final class CurrentWeather {
  const CurrentWeather({
    required this.time,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.precipitation,
    required this.weatherCode,
    required this.windSpeed,
    required this.windDirection,
    required this.isDay,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      time: DateTime.parse(json['time'] as String),

      temperature: (json['temperature_2m'] as num?)?.toDouble() ?? 0,

      feelsLike: (json['apparent_temperature'] as num?)?.toDouble() ?? 0,

      humidity: (json['relative_humidity_2m'] as num?)?.toInt() ?? 0,

      precipitation: (json['precipitation'] as num?)?.toDouble() ?? 0,

      weatherCode: (json['weather_code'] as num?)?.toInt() ?? 0,

      windSpeed: (json['wind_speed_10m'] as num?)?.toDouble() ?? 0,

      windDirection: (json['wind_direction_10m'] as num?)?.toDouble() ?? 0,

      isDay: (json['is_day'] as num?)?.toInt() == 1,
    );
  }

  final DateTime time;

  /// °C
  final double temperature;

  /// °C
  final double feelsLike;

  /// %
  final int humidity;

  /// mm
  final double precipitation;

  /// WMO weather interpretation code
  final int weatherCode;

  /// km/h
  final double windSpeed;

  /// °
  final double windDirection;

  final bool isDay;
}

final class HourlyWeather {
  const HourlyWeather({
    required this.time,
    required this.temperature,
    required this.weatherCode,
    required this.precipitationProbability,
  });

  final DateTime time;

  /// °C
  final double temperature;

  /// WMO weather interpretation code
  final int weatherCode;

  /// %
  final int precipitationProbability;

  static List<HourlyWeather> fromJson(Map<String, dynamic> json) {
    final times = (json['time'] as List).cast<String>();

    final temperatures = (json['temperature_2m'] as List).cast<num>();

    final weatherCodes = (json['weather_code'] as List).cast<num>();

    final precipitation = (json['precipitation_probability'] as List)
        .cast<num>();

    final length = [
      times.length,
      temperatures.length,
      weatherCodes.length,
      precipitation.length,
    ].reduce((a, b) => a < b ? a : b);

    return List.generate(
      length,
      (index) => HourlyWeather(
        time: DateTime.parse(times[index]),
        temperature: temperatures[index].toDouble(),
        weatherCode: weatherCodes[index].toInt(),
        precipitationProbability: precipitation[index].toInt(),
      ),
    );
  }
}

final class DailyWeather {
  const DailyWeather({
    required this.date,
    required this.temperatureMax,
    required this.temperatureMin,
    required this.weatherCode,
    required this.sunrise,
    required this.sunset,
    required this.precipitationProbability,
    required this.windSpeedMax,
  });

  final DateTime date;

  /// °C
  final double temperatureMax;

  /// °C
  final double temperatureMin;

  /// WMO weather interpretation code
  final int weatherCode;

  final DateTime sunrise;
  final DateTime sunset;

  /// %
  final int precipitationProbability;

  /// km/h
  final double windSpeedMax;

  static List<DailyWeather> fromJson(Map<String, dynamic> json) {
    final dates = (json['time'] as List).cast<String>();

    final maxTemperatures = (json['temperature_2m_max'] as List).cast<num>();

    final minTemperatures = (json['temperature_2m_min'] as List).cast<num>();

    final weatherCodes = (json['weather_code'] as List).cast<num>();

    final sunrises = (json['sunrise'] as List).cast<String>();

    final sunsets = (json['sunset'] as List).cast<String>();

    final precipitation = (json['precipitation_probability_max'] as List)
        .cast<num>();

    final windSpeeds = (json['wind_speed_10m_max'] as List).cast<num>();

    final length = [
      dates.length,
      maxTemperatures.length,
      minTemperatures.length,
      weatherCodes.length,
      sunrises.length,
      sunsets.length,
      precipitation.length,
      windSpeeds.length,
    ].reduce((a, b) => a < b ? a : b);

    return List.generate(
      length,
      (index) => DailyWeather(
        date: DateTime.parse(dates[index]),

        temperatureMax: maxTemperatures[index].toDouble(),

        temperatureMin: minTemperatures[index].toDouble(),

        weatherCode: weatherCodes[index].toInt(),

        sunrise: DateTime.parse(sunrises[index]),

        sunset: DateTime.parse(sunsets[index]),

        precipitationProbability: precipitation[index].toInt(),

        windSpeedMax: windSpeeds[index].toDouble(),
      ),
    );
  }
}
