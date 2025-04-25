import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/app/constants.dart';
import 'package:weather/app/models/weather_data_response.dart';
import 'package:weather/app/models/weather_forecast_data_response.dart';
import 'package:weather/app/services/index.dart';

class WeatherServices {
  // current
  static Future<WeatherDataResponse> getCurrent({
    required double lat,
    required double lon,
    required String units,
  }) async {
    // https://api.openweathermap.org/data/2.5/weather?lat=18.840603%26lon=95.257997%26appid=5ec9cf7b007c5179f9493274aa9fcacf

    final url =
        '$appCurrentWeatherApiUrl/weather?lat=$lat&lon=$lon&appid=$getApiKey&units=$units';
    final proxyUrl =
        DioServices.instance.getForwardProxyUrl(Uri.encodeComponent(url));
    final res = await DioServices.instance.getDio.get(proxyUrl);
    return WeatherDataResponse.fromMap(res.data);
  }

  //forecast
  static Future<List<WeatherForecastDataResponse>> getForecast({
    required double lat,
    required double lon,
    required String units,
  }) async {
    final url =
        '$appCurrentWeatherApiUrl/forecast?lat=$lat&lon=$lon&appid=$getApiKey&units=$units';
    final proxyUrl =
        DioServices.instance.getForwardProxyUrl(Uri.encodeComponent(url));
    final res = await DioServices.instance.getDio.get(proxyUrl);
    return WeatherForecastDataResponse.getListFromRespData(res.data);
  }

  static String get getApiKey {
    final key = dotenv.env['WEATHER_API_KEY'] ?? '';
    if (key.isEmpty) throw Exception('apiKey not found');
    return key;
  }
}
