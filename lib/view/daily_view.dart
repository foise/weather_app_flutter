import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/util/temperature_convert.dart';

class DailySummaryView extends StatelessWidget {
  final Weather weather;

  DailySummaryView({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayOfWeek =
        toBeginningOfSentenceCase(DateFormat('EEE').format(this.weather.date));

    return Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(dayOfWeek ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300)),
              Text(
                  "${TemperatureConvert.kelvinToCelsius(this.weather.temp).round().toString()}°",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ]),
            Padding(
                padding: EdgeInsets.only(left: 5),
                child: Container(
                    alignment: Alignment.center,
                    child: _mapWeatherConditionToImage(this.weather.condition)))
          ],
        ));
  }

  Widget _mapWeatherConditionToImage(WeatherCondition condition) {
    Image image;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        image = Image.asset('assets/images/thunder_storm_small.png');
        break;
      case WeatherCondition.heavyCloud:
        image = Image.asset('assets/images/cloudy_small.png');
        break;
      case WeatherCondition.lightCloud:
        image = Image.asset('assets/images/light_cloud_small.png');
        break;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        image = Image.asset('assets/images/drizzle_small.png');
        break;
      case WeatherCondition.clear:
        image = Image.asset('assets/images/clear_small.png');
        break;
      case WeatherCondition.fog:
        image = Image.asset('assets/images/fog_small.png');
        break;
      case WeatherCondition.snow:
        image = Image.asset('assets/images/snow_small.png');
        break;
      case WeatherCondition.rain:
        image = Image.asset('assets/images/rain_small.png');
        break;
      case WeatherCondition.atmosphere:
        image = Image.asset('assets/images/atmosphere_small.png');
        break;

      default:
        image = Image.asset('assets/images/light_cloud_small.png');
    }

    return Padding(padding: const EdgeInsets.only(top: 5), child: image);
  }
}
