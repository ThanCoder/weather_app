import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weather/app/components/index.dart';
import 'package:weather/app/dialogs/location_chooser_dialog.dart';
import 'package:weather/app/extensions/datetime_extension.dart';
import 'package:weather/app/extensions/platform_extension.dart';
import 'package:weather/app/models/weather_data_response.dart';
import 'package:weather/app/services/weather_services.dart';
import 'package:weather/app/utils/index.dart';
import '../general_server/index.dart';

import '../constants.dart';
import '../widgets/index.dart';

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

  Future<void> init() async {
    try {
      setState(() {
        isLoading = true;
      });

      data = await WeatherServices.instance.getData(lat: lat, lon: lon);

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
        Text('☁️ clouds'),
        Text(' တိမ်ဖုံးလွှမ်းမှု (ရာခိုင်နှုန်း): ${data!.cloudsAll}%'),
        const Divider(),
        ListTileWithDesc(
          padding: 4,
          title: 'မြင်သာနိုင်မှု (မီတာဖြင့်): ${data!.visibility}',
          desc: 'အများဆုံး 10,000m (10km)',
        ),
        const Divider(),
        Text('🌍 coord'),
        Text('တည်နေရာရဲ့ လတ္တီကျု (Latitude): ${data!.coordLat}'),
        Text('တည်နေရာရဲ့ ရေပြင်ပြင်လျှပ် (Longitude): ${data!.coordLon}'),
        const Divider(),
        Text('weather (မိုးလေဝသအခြေအနေ)'),
        ListTileWithDesc(
          padding: 4,
          title: 'မိုးအမျိုးအစားအုပ်စု: ${data!.weatherMain}',
          desc: '(ဥပမာ - Rain, Snow, Clouds)',
        ),
        Text('အကြောင်းအရာ: ${data!.weatherDescription}'),
        const Divider(),
        const Divider(),
        Text('🌡️ main (အဓိက မိုးလေဝသအချက်အလက်များ)'),
        Text('လက်ရှိအပူချိန်: ${data!.mainTemperature}'),
        Text('လူသားခံစားမှုအပူချိန်: ${data!.mainFeelsLike}'),
        Text('မြေပြင်ပေါ်ရှိလေဖိအား: ${data!.mainGrndLevel}'),
        Text('စိုထိုင်းဆ (ရာခိုင်နှုန်း %): ${data!.mainHumidity}%'),
        Text('ပင်လယ်ရေမျက်နှာပြင်ရှိလေဖိအား (hPa): ${data!.mainPressure}'),
        Text(
            'ပင်လယ်ရေမျက်နှာပြင်ရှိလေဖိအား (အသေးစိတ်မိုဃ်းသည့်နေရာတွင်ရှိ): ${data!.mainSeaLevel}'),
        Text('လက်ရှိအမြင့်ဆုံးအပူချိန်: ${data!.mainTempMax}'),
        Text('လက်ရှိအနည်းဆုံးအပူချိန်: ${data!.mainTempMin}'),
        const Divider(),
        Text('💨 wind (လေတိုက်မှု)'),
        Text('လေအရှိန်: ${data!.windSpeed}'),
        Text(' လေတိုက်လာသော ဦးတည်ရာ (ဒီဂရီ): ${data!.windDeg}'),
        Text(' လေတိုက်တစ်ချောင်း၏ အရှိန်မြင့်ဆုံး: ${data!.windGust}'),
        const Divider(),
        Text('🌅 sys (စနစ်အချက်အလက်များ)'),
        Text('နိုင်ငံကုတ် (ဥပမာ - MM, US): ${data!.sysCountry}'),
        Text(
            'နံနက်နေထွက်ချိန် (UNIX, UTC): ${DateTime.fromMillisecondsSinceEpoch(data!.sysSunrise * 1000, isUtc: true).toLocal().toParseTime(pattern: 'hh:mm a')}'),
        Text(
            'ညနေနေဝင်ချိန် (UNIX, UTC): ${DateTime.fromMillisecondsSinceEpoch(data!.sysSunset * 1000, isUtc: true).toLocal().toParseTime(pattern: 'hh:mm a')}'),
        const Divider(),
        Text(
            'ဒေတာဖန်တီးချိန် (UNIX Timestamp, UTC): ${DateTime.fromMillisecondsSinceEpoch(data!.dt * 1000, isUtc: true).toLocal().toParseTime()}'),
        const Divider(),
        Text('⏰ timezone'),
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
    final file = File(getRecentPath);
    final data = {'lat': lat, 'lon': lon};
    await file.writeAsString(jsonEncode(data));
  }

  Future<void> getRecent() async {
    final file = File(getRecentPath);
    if (await file.exists()) {
      final data = jsonDecode(await file.readAsString());
      double lat = data['lat'] ?? 0;
      double lon = data['lon'] ?? 0;
      if (lat > 0) {
        this.lat = lat;
      }
      if (lon > 0) {
        this.lon = lon;
      }
      await init();
    } else {
      //location မရှိရင်
      _getCurrentLocation();
    }
  }

  String get getRecentPath {
    return '${PathUtil.instance.getConfigPath()}/location.db.json';
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
