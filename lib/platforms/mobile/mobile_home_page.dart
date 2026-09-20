import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:weather/core/api/weather_api.dart';
import 'package:weather/core/models/weather_response.dart';
import 'package:weather/platforms/components/dialog/error_alert_dialog.dart';
import 'package:weather/platforms/mobile/weather_mobile_page.dart';

class MobileHomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  WeatherResponse? weather;

  @override
  void initState() {
    init();
    super.initState();
  }

  bool isLoading = false;

  Future<void> init() async {
    setState(() {
      isLoading = true;
    });
    final res = await WeatherApi.getWeather();
    if (!mounted) return;
    if (res.isErr) {
      setState(() {
        isLoading = false;
      });
      showErrorDialog(context, res.unwrapError());
      return;
    }
    weather = res.unwrap();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body);
  }

  Widget get _body {
    if (isLoading) {
      return Center(child: TLoaderRandom());
    }
    if (weather == null) {
      return Center(child: Text('Weather is null!'));
    }
    return WeatherMobilePage(weather: weather!);
  }
}
