import 'package:weather/core/models/weather_response.dart';

class MockWeatherData {
  static WeatherResponse create() {
    final now = DateTime(2026, 9, 20, 14);

    return WeatherResponse(
      latitude: 16.027538,
      longitude: 96.639337,
      timezone: 'Asia/Yangon',
      utcOffsetSeconds: 23400,

      location: const WeatherLocation(name: 'Yangon', country: 'Myanmar'),

      date: now,

      current: CurrentWeather(
        time: now,
        temperature: 31,
        feelsLike: 34,
        humidity: 72,
        precipitation: 0,
        weatherCode: 2,
        windSpeed: 12,
        windDirection: 220,
        isDay: true,
      ),

      hourly: [
        HourlyWeather(
          time: DateTime(2026, 9, 20, 14),
          temperature: 31,
          weatherCode: 1,
          precipitationProbability: 20,
        ),

        HourlyWeather(
          time: DateTime(2026, 9, 20, 15),
          temperature: 31,
          weatherCode: 2,
          precipitationProbability: 25,
        ),

        HourlyWeather(
          time: DateTime(2026, 9, 20, 16),
          temperature: 30,
          weatherCode: 3,
          precipitationProbability: 30,
        ),

        HourlyWeather(
          time: DateTime(2026, 9, 20, 17),
          temperature: 29,
          weatherCode: 61,
          precipitationProbability: 45,
        ),

        HourlyWeather(
          time: DateTime(2026, 9, 20, 18),
          temperature: 28,
          weatherCode: 61,
          precipitationProbability: 55,
        ),

        HourlyWeather(
          time: DateTime(2026, 9, 20, 19),
          temperature: 27,
          weatherCode: 2,
          precipitationProbability: 40,
        ),

        HourlyWeather(
          time: DateTime(2026, 9, 20, 20),
          temperature: 27,
          weatherCode: 2,
          precipitationProbability: 35,
        ),

        HourlyWeather(
          time: DateTime(2026, 9, 20, 21),
          temperature: 26,
          weatherCode: 3,
          precipitationProbability: 30,
        ),
      ],

      daily: [
        DailyWeather(
          date: DateTime(2026, 9, 20),
          temperatureMax: 31,
          temperatureMin: 24,
          weatherCode: 2,
          sunrise: DateTime(2026, 9, 20, 5, 48),
          sunset: DateTime(2026, 9, 20, 18, 2),
          precipitationProbability: 30,
          windSpeedMax: 18,
        ),

        DailyWeather(
          date: DateTime(2026, 9, 21),
          temperatureMax: 30,
          temperatureMin: 24,
          weatherCode: 61,
          sunrise: DateTime(2026, 9, 21, 5, 48),
          sunset: DateTime(2026, 9, 21, 18, 1),
          precipitationProbability: 60,
          windSpeedMax: 17,
        ),

        DailyWeather(
          date: DateTime(2026, 9, 22),
          temperatureMax: 29,
          temperatureMin: 23,
          weatherCode: 3,
          sunrise: DateTime(2026, 9, 22, 5, 48),
          sunset: DateTime(2026, 9, 22, 18, 1),
          precipitationProbability: 40,
          windSpeedMax: 15,
        ),

        DailyWeather(
          date: DateTime(2026, 9, 23),
          temperatureMax: 30,
          temperatureMin: 24,
          weatherCode: 2,
          sunrise: DateTime(2026, 9, 23, 5, 49),
          sunset: DateTime(2026, 9, 23, 18, 0),
          precipitationProbability: 35,
          windSpeedMax: 16,
        ),

        DailyWeather(
          date: DateTime(2026, 9, 24),
          temperatureMax: 28,
          temperatureMin: 23,
          weatherCode: 61,
          sunrise: DateTime(2026, 9, 24, 5, 49),
          sunset: DateTime(2026, 9, 24, 18, 0),
          precipitationProbability: 65,
          windSpeedMax: 18,
        ),

        DailyWeather(
          date: DateTime(2026, 9, 25),
          temperatureMax: 31,
          temperatureMin: 24,
          weatherCode: 0,
          sunrise: DateTime(2026, 9, 25, 5, 49),
          sunset: DateTime(2026, 9, 25, 17, 59),
          precipitationProbability: 15,
          windSpeedMax: 14,
        ),

        DailyWeather(
          date: DateTime(2026, 9, 26),
          temperatureMax: 30,
          temperatureMin: 24,
          weatherCode: 2,
          sunrise: DateTime(2026, 9, 26, 5, 50),
          sunset: DateTime(2026, 9, 26, 17, 59),
          precipitationProbability: 25,
          windSpeedMax: 15,
        ),
      ],
    );
  }
}
