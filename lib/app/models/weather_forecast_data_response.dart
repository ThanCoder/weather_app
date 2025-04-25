import 'package:weather/app/services/map_services.dart';

class WeatherForecastDataResponse {
  int dt;
  double visibility;
  double pop;
  String dtTxt;
  double cloudsAll;

  int population;
  int sunrise;
  int sunset;

  double windSpeed;
  double windDeg;
  double windGust;

  String sysPod;

  double mainTemp;
  double mainFeelsLike;
  double mainTempMin;
  double mainTempMax;
  double mainPressure;
  double mainSeaLevel;
  double mainGrndLevel;
  double mainHumidity;
  double mainTempKf;

  String weatherMain;
  String weatherDescription;

  double rain3h;
  double snow3h;
  WeatherForecastDataResponse({
    required this.dt,
    required this.visibility,
    required this.pop,
    required this.dtTxt,
    required this.cloudsAll,
    required this.population,
    required this.sunrise,
    required this.sunset,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.sysPod,
    required this.mainTemp,
    required this.mainFeelsLike,
    required this.mainTempMin,
    required this.mainTempMax,
    required this.mainPressure,
    required this.mainSeaLevel,
    required this.mainGrndLevel,
    required this.mainHumidity,
    required this.mainTempKf,
    required this.weatherMain,
    required this.weatherDescription,
    required this.rain3h,
    required this.snow3h,
  });

  factory WeatherForecastDataResponse.fromMap(
      Map<String, dynamic> mainMap, Map<String, dynamic> map) {
    return WeatherForecastDataResponse(
      // main map
      population:
          MapServices.get<int>(mainMap, ['population'], defaultValue: 0),
      sunrise: MapServices.get<int>(mainMap, ['sunrise'], defaultValue: 0),
      sunset: MapServices.get<int>(mainMap, ['sunset'], defaultValue: 0),
      //map
      dt: MapServices.get<int>(map, ['dt'], defaultValue: 0),
      visibility: MapServices.getDouble(map['visibility']),
      pop: MapServices.getDouble(map['pop']),
      dtTxt: MapServices.getString(map['sys']['pod']),
      cloudsAll: MapServices.getDouble(map['clouds']['all']),
      windSpeed: MapServices.getDouble(map['wind']['speed']),
      windDeg: MapServices.getDouble(map['wind']['deg']),
      windGust: MapServices.getDouble(map['wind']['gust']),
      sysPod: MapServices.getString(map['sys']['pod']),
      mainTemp: MapServices.getDouble(map['main']['temp']),
      mainFeelsLike: MapServices.getDouble(map['main']['feels_like']),
      mainTempMin: MapServices.getDouble(map['main']['temp_min']),
      mainTempMax: MapServices.getDouble(map['main']['temp_max']),
      mainPressure: MapServices.getDouble(map['main']['pressure']),
      mainSeaLevel: MapServices.getDouble(map['main']['sea_level']),
      mainGrndLevel: MapServices.getDouble(map['main']['grnd_level']),
      mainHumidity: MapServices.getDouble(map['main']['humidity']),
      mainTempKf: MapServices.getDouble(map['main']['temp_kf']),
      weatherMain: MapServices.getString(map['weather'][0]['main']),
      weatherDescription:
          MapServices.getString(map['weather'][0]['description']),
      rain3h: MapServices.get<double>(map, ['rain', '3h'], defaultValue: 0.0),
      snow3h: MapServices.get<double>(map, ['snow', '3h'], defaultValue: 0.0),
      // rain3h: 0,
    );
  }

  static List<WeatherForecastDataResponse> getListFromRespData(
      Map<String, dynamic> map) {
    List<WeatherForecastDataResponse> list = [];
    List<dynamic> resList = map['list'] ?? [];
    list = resList
        .map((m) => WeatherForecastDataResponse.fromMap(map, m))
        .toList();
    return list;
  }

  @override
  String toString() {
    return 'main: $weatherMain';
  }
}
