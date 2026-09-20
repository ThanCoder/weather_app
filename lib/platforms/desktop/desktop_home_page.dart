import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:weather/core/api/weather_api.dart';
import 'package:weather/core/models/weather_response.dart';
import 'package:weather/platforms/components/dialog/error_alert_dialog.dart';
import 'package:weather/platforms/desktop/weather_desktop_page.dart';

class DesktopHomePage extends StatefulWidget {
  const DesktopHomePage({super.key});

  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: init, icon: Icon(Icons.refresh_outlined)),
        ],
      ),
      body: _body,
    );
  }

  Widget get _body {
    if (isLoading) {
      return Center(child: TLoaderRandom());
    }
    if (weather != null) {
      return WeatherDesktopPage(weather: weather!);
    }
    return Center(child: Text('Weather is null!'));
  }
}
