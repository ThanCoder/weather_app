import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/app/constants.dart';
import 'package:weather/app/models/weather_data_response.dart';
import 'package:weather/app/services/index.dart';

class WeatherServices {
  static final WeatherServices instance = WeatherServices._();
  WeatherServices._();
  factory WeatherServices() => instance;

  Future<WeatherDataResponse> getData({
    required double lat,
    required double lon,
    String units = 'standard',
  }) async {
    // https://api.openweathermap.org/data/2.5/weather?lat=18.840603%26lon=95.257997%26appid=5ec9cf7b007c5179f9493274aa9fcacf

    final url = '$appCurrentWeatherApiUrl?lat=$lat&lon=$lon&appid=$getApiKey';
    final proxyUrl =
        DioServices.instance.getForwardProxyUrl(Uri.encodeComponent(url));
    final res = await DioServices.instance.getDio.get(proxyUrl);
    return WeatherDataResponse.fromMap(res.data);
  }

  String get getApiKey {
    final key = dotenv.env['WEATHER_API_KEY'] ?? '';
    if (key.isEmpty) throw Exception('apiKey not found');
    return key;
  }
}
