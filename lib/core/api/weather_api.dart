import 'dart:convert';

import 'package:t_client/t_client.dart';
import 'package:weather/core/models/weather_response.dart';
import 'package:weather/core/result_t.dart';
import 'package:weather/core/util/app_util.dart';
import 'package:weather/keys.dart';

class WeatherApi {
  static Future<Result<WeatherResponse, String>> getWeather() async {
    final client = TClient();
    final cf = AppUtil.instance.config;

    try {
      // ─────────────────────────────
      // Coordinates
      // ─────────────────────────────

      final latitude = cf.getDouble('latitude', lat);
      final longitude = cf.getDouble('longitude', long);

      // ─────────────────────────────
      // 1. Weather API
      // ─────────────────────────────

      final weatherQuery = <String, dynamic>{
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),

        'current': [
          'temperature_2m',
          'apparent_temperature',
          'relative_humidity_2m',
          'precipitation',
          'weather_code',
          'wind_speed_10m',
          'wind_direction_10m',
          'is_day',
        ].join(','),

        'hourly': [
          'temperature_2m',
          'weather_code',
          'precipitation_probability',
        ].join(','),

        'daily': [
          'weather_code',
          'temperature_2m_max',
          'temperature_2m_min',
          'sunrise',
          'sunset',
          'precipitation_probability_max',
          'wind_speed_10m_max',
        ].join(','),

        'timezone': 'auto',
        'forecast_days': '7',
      };

      final weatherUri = Uri.parse(apiUrl)
          .replace(queryParameters: weatherQuery);

      final weatherRes = await client.get(weatherUri.toString());

      if (weatherRes.isErr) {
        return Err(weatherRes.unwrapError());
      }

      final weatherBody = jsonDecode(weatherRes.unwrap().body);

      if (weatherBody is! Map<String, dynamic>) {
        return Err('Invalid weather response');
      }

      // ─────────────────────────────
      // 2. Reverse Geocoding
      // ─────────────────────────────

      final locationUri = Uri.https('nominatim.openstreetmap.org', '/reverse', {
        'lat': latitude.toString(),
        'lon': longitude.toString(),
        'format': 'json',
        'zoom': '10',
        'addressdetails': '1',
      });

      final locationRes = await client.send(
        locationUri.toString(),
        headers: {'User-Agent': 'WeatherApp/1.0'},
      );

      String cityName = weatherBody['timezone'] as String? ?? 'Unknown';
      String? county;
      String? state;
      String? country;
      String? countryCode;

      if (locationRes.isOk) {
        final body = await locationRes.unwrap().transform(utf8.decoder).join();

        final locationBody = jsonDecode(body);

        // print('Geocoding response: $locationBody');

        if (locationBody is Map<String, dynamic>) {
          final address = locationBody['address'];

          if (address is Map<String, dynamic>) {
            cityName =
                address['city'] as String? ??
                address['town'] as String? ??
                address['village'] as String? ??
                address['municipality'] as String? ??
                address['county'] as String? ??
                cityName;

            county = address['county'] as String?;
            state = address['state'] as String?;
            country = address['country'] as String?;
            countryCode = address['country_code'] as String?;
          }
        }
      }   

      // ─────────────────────────────
      // 3. WeatherResponse
      // ─────────────────────────────

      final weather = WeatherResponse.fromJson(weatherBody).copyWith(
        location: WeatherLocation(
          name: cityName,
          county: county,
          state: state,
          country: country,
          countryCode: countryCode,
        ),
      );

      return Ok(weather);
    } catch (e) {
      return Err(e.toString());
    }
  }
}
