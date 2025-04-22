// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  int mainPressure;
  int mainHumidity;
  int mainSeaLevel;
  int mainGrndLevel;

  double windSpeed;
  int windDeg;
  double windGust;

  int cloudsAll;

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
    final cityName = map['name'];
    if (cityName is! String) {
      throw Exception('cityName not String');
    }
    final base = map['base'];
    if (base is! String) {
      throw Exception('base not String');
    }
    final visibility = map['visibility'];
    if (visibility is! int) {
      throw Exception('visibility not int');
    }
    final timezone = map['timezone'];
    if (timezone is! int) {
      throw Exception('timezone not int');
    }
    final dt = map['dt'];
    if (dt is! int) {
      throw Exception('dt not int');
    }
    //coord
    final coordLon = map['coord']['lon'];
    if (coordLon is! double) {
      throw Exception('coordLon not double');
    }
    final coordLat = map['coord']['lat'];
    if (coordLat is! double) {
      throw Exception('coordLat not double');
    }
    // weather
    final weatherMain = map['weather'][0]['main'];
    if (weatherMain is! String) {
      throw Exception('weatherMain not String');
    }
    final weatherDescription = map['weather'][0]['description'];
    if (weatherDescription is! String) {
      throw Exception('weatherDescription not String');
    }
    final weatherIcon = map['weather'][0]['icon'];
    if (weatherIcon is! String) {
      throw Exception('weatherIcon not String');
    }
    //main
    final mainTemperature = map['main']['temp'];
    if (mainTemperature is! double) {
      throw Exception('mainTemperature not double');
    }
    final mainFeelsLike = map['main']['feels_like'];
    if (mainFeelsLike is! double) {
      throw Exception('mainFeelsLike not double');
    }
    final mainTempMin = map['main']['temp_min'];
    if (mainTempMin is! double) {
      throw Exception('mainTempMin not double');
    }
    final mainTempMax = map['main']['temp_max'];
    if (mainTempMax is! double) {
      throw Exception('mainTempMax not double');
    }
    final mainPressure = map['main']['pressure'];
    if (mainPressure is! int) {
      throw Exception('mainPressure not int');
    }
    final mainHumidity = map['main']['humidity'];
    if (mainHumidity is! int) {
      throw Exception('mainHumidity not int');
    }
    final mainSeaLevel = map['main']['sea_level'];
    if (mainSeaLevel is! int) {
      throw Exception('mainSeaLevel not int');
    }
    final mainGrndLevel = map['main']['grnd_level'];
    if (mainGrndLevel is! int) {
      throw Exception('mainGrndLevel not int');
    }

    // လေ
    final windSpeed = map['wind']['speed'];
    if (windSpeed is! double) {
      throw Exception('windSpeed not double');
    }
    final windDeg = map['wind']['deg'];
    if (windDeg is! int) {
      throw Exception('windDeg not int');
    }
    final windGust = map['wind']['gust'];
    if (windGust is! double) {
      throw Exception('windGust not double');
    }
    // တိမ်
    final cloudsAll = map['clouds']['all'];
    //
    final sysCountry = map['sys']['country'];
    final sysSunrise = map['sys']['sunrise'];
    final sysSunset = map['sys']['sunset'];

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
