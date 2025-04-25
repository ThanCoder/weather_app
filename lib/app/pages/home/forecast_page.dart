import 'package:flutter/material.dart';
import 'package:weather/app/components/index.dart';
import 'package:weather/app/components/weather_forecast_list_item.dart';
import 'package:weather/app/dialogs/location_chooser_dialog.dart';
import 'package:weather/app/extensions/platform_extension.dart';
import 'package:weather/app/models/weather_forecast_data_response.dart';
import 'package:weather/app/services/location_recent_services.dart';
import 'package:weather/app/services/weather_services.dart';
import 'package:weather/app/types/weather_units.dart';

import '../../widgets/index.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  void initState() {
    super.initState();
    getRecent();
  }

  bool isLoading = false;
  double lat = 0; //16.0360296;
  double lon = 0; //97.6315875;
  List<WeatherForecastDataResponse> list = [];
  WeatherUnits units = WeatherUnits.metric;

  Future<void> init() async {
    try {
      setState(() {
        isLoading = true;
      });

      list = await WeatherServices.getForecast(
        lat: lat,
        lon: lon,
        units: units.name,
      );

      await setRecent();

      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      debugPrint(e.toString());
      showDialogMessage(context, 'error ရှိနေပါတယ်');
    }
  }

  void _getCurrentLocation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LocationChooserDialog(
        lat: lat,
        lon: lon,
        onApply: (lat, lon) {
          this.lat = lat;
          this.lon = lon;
          init();
        },
      ),
    );
  }

  Future<void> setRecent() async {
    await LocationRecentServices.set(lat: lat, lon: lon);
  }

  Future<void> getRecent() async {
    final res = await LocationRecentServices.get();
    if (res != null) {
      lat = res.lat;
      lon = res.lon;
      await init();
    } else {
      //location မရှိရင်
      _getCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      contentPadding: 0,
      appBar: AppBar(
        title: Text('ရာသီဥတု ခန့်မှန်းချက်'),
        actions: [
          !PlatformExtension.isDesktop()
              ? const SizedBox()
              : IconButton(
                  onPressed: init,
                  icon: Icon(Icons.refresh),
                ),
        ],
      ),
      body: isLoading
          ? TLoader()
          : RefreshIndicator(
              onRefresh: init,
              child: CustomScrollView(
                slivers: [
                  // SliverToBoxAdapter(
                  //   child: _getContent(),
                  // ),
                  SliverList.separated(
                    itemCount: list.length,
                    itemBuilder: (context, index) => WeatherForecastListItem(
                      units: units,
                      index: index,
                      data: list[index],
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: _getCurrentLocation,
        child: Icon(Icons.add),
      ),
    );
  }
}
