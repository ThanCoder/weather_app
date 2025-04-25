// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather/app/services/map_services.dart';

class WeatherDataResponse {
  String cityName;
  String base;
  int visibility;
  int timezone;
  int dt;

  double coordLon;
  double coordLat;

  String weatherMain;
  String weatherDescription;
  String weatherIcon;

  double mainTemperature;
  double mainFeelsLike;
  double mainTempMin;
  double mainTempMax;
  double mainPressure;
  double mainHumidity;
  double mainSeaLevel;
  double mainGrndLevel;

  double windSpeed;
  double windDeg;
  double windGust;

  double cloudsAll;

  String sysCountry;
  int sysSunrise;
  int sysSunset;

  WeatherDataResponse({
    required this.cityName,
    required this.base,
    required this.visibility,
    required this.timezone,
    required this.dt,
    required this.coordLon,
    required this.coordLat,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.mainTemperature,
    required this.mainFeelsLike,
    required this.mainTempMin,
    required this.mainTempMax,
    required this.mainPressure,
    required this.mainHumidity,
    required this.mainSeaLevel,
    required this.mainGrndLevel,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.cloudsAll,
    required this.sysCountry,
    required this.sysSunrise,
    required this.sysSunset,
  });

  factory WeatherDataResponse.fromMap(Map<String, dynamic> map) {
    // မိုးလေဝသ အချက်အလက်
    final cityName = MapServices.getString(map['name']);
    final base = MapServices.getString(map['base']);
    final visibility = MapServices.getInt(map['visibility']);
    final timezone = MapServices.getInt(map['timezone']);
    final dt = MapServices.getInt(map['dt']);
    //coord
    double coordLon = MapServices.getDouble(map['coord']['lon']);
    double coordLat = MapServices.getDouble(map['coord']['lat']);
    // weather
    final weatherMain = MapServices.getString(map['weather'][0]['main']);
    final weatherDescription =
        MapServices.getString(map['weather'][0]['description']);
    final weatherIcon = MapServices.getString(map['weather'][0]['icon']);
    //main
    final mainTemperature = MapServices.getDouble(map['main']['temp']);
    final mainFeelsLike = MapServices.getDouble(map['main']['feels_like']);
    final mainTempMin = MapServices.getDouble(map['main']['temp_min']);
    final mainTempMax = MapServices.getDouble(map['main']['temp_max']);
    final mainPressure = MapServices.getDouble(map['main']['pressure']);
    final mainHumidity = MapServices.getDouble(map['main']['humidity']);
    final mainSeaLevel = MapServices.getDouble(map['main']['sea_level']);
    final mainGrndLevel = MapServices.getDouble(map['main']['grnd_level']);

    // လေ
    final windSpeed = MapServices.getDouble(map['wind']['speed']);
    final windDeg = MapServices.getDouble(map['wind']['deg']);
    final windGust = MapServices.getDouble(map['wind']['gust']);
    // တိမ်
    final cloudsAll = MapServices.getDouble(map['clouds']['all']);
    //
    final sysCountry = MapServices.getString(map['sys']['country']);
    final sysSunrise = MapServices.getInt(map['sys']['sunrise']);
    final sysSunset = MapServices.getInt(map['sys']['sunset']);

    return WeatherDataResponse(
      cityName: cityName,
      base: base,
      visibility: visibility,
      timezone: timezone,
      dt: dt,
      coordLon: coordLon,
      coordLat: coordLat,
      weatherMain: weatherMain,
      weatherDescription: weatherDescription,
      weatherIcon: weatherIcon,
      mainTemperature: mainTemperature,
      mainFeelsLike: mainFeelsLike,
      mainTempMin: mainTempMin,
      mainTempMax: mainTempMax,
      mainPressure: mainPressure,
      mainHumidity: mainHumidity,
      mainSeaLevel: mainSeaLevel,
      mainGrndLevel: mainGrndLevel,
      windSpeed: windSpeed,
      windDeg: windDeg,
      windGust: windGust,
      cloudsAll: cloudsAll,
      sysCountry: sysCountry,
      sysSunrise: sysSunrise,
      sysSunset: sysSunset,
    );
  }
}
