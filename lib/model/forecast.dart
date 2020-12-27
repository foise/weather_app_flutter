import 'package:weather_app/model/weather.dart';

class Forecast {
  final DateTime lastUpdated;
  final double longitude;
  final double latitude;
  final List<Weather> daily;
  final Weather current;
  final bool isDayTime;
  String city;

  Forecast(
      {this.lastUpdated,
      this.longitude,
      this.latitude,
      this.daily: const [],
      this.current,
      this.city,
      this.isDayTime});

  static Forecast fromJson(dynamic json) {
    var weather = json['current']['weather'][0];

    int timeOffset = json['timezone_offset'] * 1000;
    int timeGMT = json['current']['dt'] * 1000;

    var date =
        DateTime.fromMillisecondsSinceEpoch(timeGMT + timeOffset, isUtc: true);

    var sunrise = DateTime.fromMillisecondsSinceEpoch(
        json['current']['sunrise'] * 1000,
        isUtc: true);

    var sunset = DateTime.fromMillisecondsSinceEpoch(
        json['current']['sunset'] * 1000,
        isUtc: true);

    bool isDay = date.isAfter(sunrise) && date.isBefore(sunset);

    // get the forecast for the next 3 days, excluding the current day
    bool hasDaily = json['daily'] != null;
    var tempDaily = [];
    if (hasDaily) {
      List items = json['daily'];
      tempDaily = items
          .map((item) => Weather.fromDailyJson(item))
          .toList()
          .skip(1)
          .take(3)
          .toList();
    }

    var currentForecast = Weather(
        cloudiness: int.parse(json['current']['clouds'].toString()),
        temp: json['current']['temp'].toDouble(),
        condition: Weather.mapStringToWeatherCondition(
            weather['main'], int.parse(json['current']['clouds'].toString())),
        description: weather['description'],
        feelLikeTemp: json['current']['feels_like'],
        date: date);

    return Forecast(
        lastUpdated: DateTime.now(),
        current: currentForecast,
        latitude: json['lat'].toDouble(),
        longitude: json['lon'].toDouble(),
        daily: tempDaily,
        isDayTime: isDay);
  }
}
