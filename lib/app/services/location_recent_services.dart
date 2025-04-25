// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:weather/app/utils/index.dart';

class LocationRecentServices {
  static Future<void> set({
    required double lat,
    required double lon,
  }) async {
    final file = File(getRecentPath);
    final data = {'lat': lat, 'lon': lon};
    await file.writeAsString(jsonEncode(data));
  }

  static Future<LocationRecentResponse?> get() async {
    final file = File(getRecentPath);

    if (await file.exists()) {
      final data = jsonDecode(await file.readAsString());
      double lat = data['lat'] ?? 0;
      double lon = data['lon'] ?? 0;
      if (lat > 0 && lon > 0) {}
      return LocationRecentResponse(lat: lat, lon: lon);
    }
    return null;
  }

  static String get getRecentPath {
    return '${PathUtil.instance.getConfigPath()}/location.db.json';
  }
}

class LocationRecentResponse {
  double lat;
  double lon;
  LocationRecentResponse({
    required this.lat,
    required this.lon,
  });
}
