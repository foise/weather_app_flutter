import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';

class WeatherSummary extends StatelessWidget {
  final WeatherCondition condition;
  final double temp;
  final double feelsLike;
  final bool isdayTime;

  WeatherSummary(
      {Key key,
      @required this.condition,
      @required this.temp,
      @required this.feelsLike,
      @required this.isdayTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          children: [
            Text(
              '${_formatTemperature(this.temp)}°',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Feels like ${_formatTemperature(this.feelsLike)}°',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        _mapWeatherConditionToImage(this.condition, this.isdayTime),
      ]),
    );
  }

  String _formatTemperature(double t) {
    var temp = (t == null ? '' : t.round().toString());
    return temp;
  }

  Widget _mapWeatherConditionToImage(
      WeatherCondition condition, bool isDayTime) {
    Image image;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        image = Image.asset('assets/images/thunder_storm.png');
        break;
      case WeatherCondition.heavyCloud:
        image = Image.asset('assets/images/cloudy.png');
        break;
      case WeatherCondition.lightCloud:
        isDayTime
            ? image = Image.asset('assets/images/light_cloud.png')
            : image = Image.asset('assets/images/light_cloud-night.png');
        break;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        image = Image.asset('assets/images/drizzle.png');
        break;
      case WeatherCondition.clear:
        isDayTime
            ? image = Image.asset('assets/images/clear.png')
            : image = Image.asset('assets/images/clear-night.png');
        break;
      case WeatherCondition.fog:
        image = Image.asset('assets/images/fog.png');
        break;
      case WeatherCondition.snow:
        image = Image.asset('assets/images/snow.png');
        break;
      case WeatherCondition.rain:
        image = Image.asset('assets/images/rain.png');
        break;
      case WeatherCondition.atmosphere:
        image = Image.asset('assets/images/fog.png');
        break;

      default:
        image = Image.asset('assets/images/unknown.png');
    }

    return Padding(padding: const EdgeInsets.only(top: 5), child: image);
  }
}
