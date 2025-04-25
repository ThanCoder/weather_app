import 'package:flutter/material.dart';
import 'package:weather/app/components/index.dart';
import 'package:weather/app/dialogs/location_chooser_dialog.dart';
import 'package:weather/app/extensions/datetime_extension.dart';
import 'package:weather/app/extensions/platform_extension.dart';
import 'package:weather/app/models/weather_data_response.dart';
import 'package:weather/app/services/location_recent_services.dart';
import 'package:weather/app/services/weather_services.dart';
import 'package:weather/app/types/weather_units.dart';
import '../../general_server/index.dart';

import '../../constants.dart';
import '../../widgets/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getRecent();
  }

  bool isLoading = false;
  double lat = 0; //16.0360296;
  double lon = 0; //97.6315875;
  WeatherDataResponse? data;
  WeatherUnits units = WeatherUnits.metric;

  Future<void> init() async {
    try {
      setState(() {
        isLoading = true;
      });

      data = await WeatherServices.getCurrent(
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

  Widget _getContent() {
    if (data == null) {
      return SizedBox.fromSize();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text('မြို့နာမည်: ${data!.cityName}'),
        const Divider(),
        Text('☁️ Clouds'),
        Text(' တိမ်ဖုံးလွှမ်းမှု (ရာခိုင်နှုန်း): ${data!.cloudsAll}%'),
        const Divider(),
        Text('မိုးလေဝသအခြေအနေ'),
        ListTileWithDesc(
          padding: 4,
          title: 'မိုး အမျိုးအစား အုပ်စု: ${data!.weatherMain}',
          desc: '(ဥပမာ - Rain, Snow, Clouds)',
        ),
        Text('အကြောင်းအရာ: ${data!.weatherDescription}'),
        const Divider(),
        Text('🌡️ မိုးလေဝသအချက်အလက်များ'),
        Text(
            'လက်ရှိအပူချိန်: ${data!.mainTemperature} ${WeatherUnitsExtension.getLabel(units)}'),
        Text(
            'လူသားခံစားမှု အပူချိန်: ${data!.mainFeelsLike} ${WeatherUnitsExtension.getLabel(units)}'),
        Text('မြေပြင်ပေါ်ရှိ လေဖိအား: ${data!.mainGrndLevel}'),
        Text('စိုထိုင်းဆ: ${data!.mainHumidity}%'),
        Text('ပင်လယ်ရေ မျက်နှာပြင်ရှိ လေဖိအား (hPa): ${data!.mainPressure}'),
        Text(
            'ပင်လယ်ရေမျက်နှာပြင်ရှိလေဖိအား (အသေးစိတ်မိုဃ်းသည့်နေရာတွင်ရှိ): ${data!.mainSeaLevel}'),
        Text(
            'လက်ရှိ အမြင့်ဆုံး အပူချိန်: ${data!.mainTempMax} ${WeatherUnitsExtension.getLabel(units)}'),
        Text(
            'လက်ရှိ အနည်းဆုံး အပူချိန်: ${data!.mainTempMin} ${WeatherUnitsExtension.getLabel(units)}'),
        const Divider(),
        Text('💨 wind (လေတိုက်မှု)'),
        ListTileWithDesc(
          title: '${data!.windSpeed}',
          desc: 'လေတိုက်နှုန်း။ (Default: m/sec, Imperial: miles/hour)',
        ),
        ListTileWithDesc(
          title: '${data!.windDeg}',
          desc: 'လေတိုက်ဦးတည်မှု (အဆင့်)။',
        ),
        ListTileWithDesc(
          title: '${data!.windGust}',
          desc: 'လေတိုက်ပြင်းအား။',
        ),
        const Divider(),
        Text('🌅 စနစ်အချက်အလက်များ'),
        Text('နိုင်ငံကုတ်: ${data!.sysCountry}'),
        Text(
            'နံနက်နေထွက်ချိန်: ${DateTime.fromMillisecondsSinceEpoch(data!.sysSunrise * 1000, isUtc: true).toLocal().toParseTime(pattern: 'hh:mm a')}'),
        Text(
            'ညနေနေဝင်ချိန်: ${DateTime.fromMillisecondsSinceEpoch(data!.sysSunset * 1000, isUtc: true).toLocal().toParseTime(pattern: 'hh:mm a')}'),
        const Divider(),
        Text(
            '⏰ ဒေတာဖန်တီးချိန်: ${DateTime.fromMillisecondsSinceEpoch(data!.dt * 1000, isUtc: true).toLocal().toParseTime()}'),
        const Divider(),
        ListTileWithDesc(
          padding: 4,
          title: 'မြင်သာနိုင်မှု (မီတာဖြင့်): ${data!.visibility}m',
          desc: 'အများဆုံး 10,000m (10km)',
        ),
        const Divider(),
        Text('🌍 တည်နေရာ'),
        Text('Latitude: ${data!.coordLat}'),
        Text('Longitude: ${data!.coordLon}'),
        const Divider(),
        Text('⏰ Timezone'),
        Text(DateTime.fromMillisecondsSinceEpoch(data!.timezone * 1000,
                isUtc: true)
            .toLocal()
            .toParseTime()),
      ],
    );
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
      appBar: AppBar(
        title: Text(appTitle),
        actions: [
          GeneralServerNotiButton(),
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
                  SliverToBoxAdapter(
                    child: _getContent(),
                  )
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
