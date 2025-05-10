import 'package:flutter/material.dart';
import 'package:weather/app/models/weather_forecast_data_response.dart';
import 'package:weather/app/types/weather_units.dart';
import 'package:weather/app/widgets/index.dart';

class WeatherForecastListItem extends StatelessWidget {
  WeatherUnits units;
  int index;
  WeatherForecastDataResponse data;
  WeatherForecastListItem({
    super.key,
    required this.units,
    required this.index,
    required this.data,
  });

  String _getDayName() {
    if (index == 0) {
      return 'ဒီနေ့ ခန့်မှန်းချက်';
    }
    if (index == 1) {
      return 'မနက်ဖြန် ခန့်မှန်းချက်';
    }
    return 'လာမယ့် $index ရက် ခန့်မှန်းချက်';
  }

  Widget _getDayNameWidget() {
    return Text(
      _getDayName(),
      style: TextStyle(
        color: Colors.blue,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            _getDayNameWidget(),

            ListTileWithDesc(
              title: '${(data.pop * 100).toInt()}%',
              desc: 'မိုးရွာနိုင်ချေ။ (0 မှ 1 အတွင်း – 0 = 0%, 1 = 100%)။',
            ),
            ListTileWithDesc(
              title: '${data.cloudsAll}%',
              desc: ' တိမ်ဖုံးနှုန်း (ရာခိုင်နှုန်း)။',
            ),

            ListTileWithDesc(
              title: data.sysPod.toString(),
              desc: 'နေ့လယ်/ည။ (n = ည၊ d = နေ့)',
            ),
            ListTileWithDesc(
              title: '${data.visibility}M',
              desc:
                  'မြင်ကွင်းကျယ်အနည်းဆုံး။ (မီတာဖြင့်၊ အများဆုံး ၁၀ကီလိုမီတာ)။',
            ),
            ListTileWithDesc(
              title: data.rain3h.toString(),
              desc: 'နောက်ဆုံး ၃နာရီအတွင်း မိုးရွာသည့်ရေပမာဏ (mm)။',
            ),
            ListTileWithDesc(
              title: data.snow3h.toString(),
              desc: 'နောက်ဆုံး ၃နာရီအတွင်း နှင်းကျသည့်အရွယ်အစား (mm)',
            ),
            const Divider(),
            // main
            ListTileWithDesc(
              title:
                  '${data.mainFeelsLike}  ${WeatherUnitsExtension.getLabel(units)}',
              desc: 'လူတွေ ခံစားမယ့်အပူချိန်။',
            ),
            ListTileWithDesc(
              title:
                  '${data.mainTemp}  ${WeatherUnitsExtension.getLabel(units)}',
              desc:
                  'အပူချိန်။ (Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit)',
            ),

            ListTileWithDesc(
              title:
                  '${data.mainTempMax} ${WeatherUnitsExtension.getLabel(units)}',
              desc: 'ခန့်မှန်းချက်အချိန်မှာ အမြင့်ဆုံးအပူချိန်။',
            ),
            ListTileWithDesc(
              title:
                  '${data.mainTempMin}  ${WeatherUnitsExtension.getLabel(units)}',
              desc: 'ခန့်မှန်းချက်အချိန်မှာ အနိမ့်ဆုံးအပူချိန်။',
            ),
            ListTileWithDesc(
              title: '${data.mainGrndLevel}',
              desc: 'မြေမျက်နှာပြင်အနီးရှိ လေဖိအား (hPa)။',
            ),
            ListTileWithDesc(
              title: '${data.mainHumidity}%',
              desc: ' စိုထိုင်းဆ (ရာခိုင်နှုန်း)။',
            ),
            ListTileWithDesc(
              title: '${data.mainPressure}',
              desc: 'ပင်လယ်ရေမျက်နှာပြင်ပေါ်ရှိ လေဖိအား (hPa)။',
            ),
            ListTileWithDesc(
              title: '${data.mainSeaLevel}',
              desc: 'ပင်လယ်ရေမျက်နှာပြင်ပေါ်ရှိ လေဖိအား (hPa)။',
            ),

            const Divider(),
            ListTileWithDesc(
              title: data.weatherMain,
              desc: ' မိုးလေဝသအုပ်စု (ဥပမာ Rain, Snow, Clouds စသည်)။',
            ),
            ListTileWithDesc(
              title: data.weatherDescription,
              desc: 'အုပ်စုအတွင်း မိုးလေဝသအခြေအနေဖော်ပြချက်။',
            ),
            Text('အတွင်းပိုင်း အသုံးအဆောင်အချက်အလက်: ${data.mainTempKf}'),

            const Divider(),

            ListTileWithDesc(
              title: '${data.windSpeed}',
              desc: 'လေတိုက်နှုန်း။ (Default: m/sec, Imperial: miles/hour)',
            ),
            ListTileWithDesc(
              title: '${data.windDeg}',
              desc: 'လေတိုက်ဦးတည်မှု (အဆင့်)။',
            ),
            ListTileWithDesc(
              title: '${data.windGust}',
              desc: 'လေတိုက်ပြင်းအား။',
            ),
            const Divider(),
            // ListTileWithDesc(
            //   title:
            //       'ခန့်မှန်းထားသောအချိန်: ${DateTime.fromMillisecondsSinceEpoch(data.dt, isUtc: true).toParseTime()}',
            //   desc: 'ခန့်မှန်းထားသောအချိန် (Unix format, UTC)။',
            // ),
            // ListTileWithDesc(
            //   title: 'ခန့်မှန်းထားသောအချိန်: ${data.dtTxt}',
            //   desc: 'ခန့်မှန်းထားသောအချိန် (ISO format, UTC)။',
            // ),
          ],
        ),
      ),
    );
  }
}
