import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/api/weather_api.dart';
import 'package:weather_app/model/forecast.dart';

import 'package:weather_app/model/location.dart';

class OpenWeatherMapWeatherApi extends WeatherApi {
  static const endPointUrl = 'https://api.openweathermap.org/data/2.5';
  static const apiKey = "d9aa7e1f3071741baf755f50448314db";
  http.Client httpClient;

  OpenWeatherMapWeatherApi() {
    this.httpClient = new http.Client();
  }

  @override
  Future<Location> getLocation(String city) async {
    final requestUrl = '$endPointUrl/weather?q=$city&appid=$apiKey';
    final response = await this.httpClient.get(Uri.encodeFull(requestUrl));

    if (response.statusCode != 200) {
      throw Exception(
          'error retrieving location for city $city: ${response.statusCode}');
    }

    return Location.fromJson(jsonDecode(response.body));
  }

  @override
  Future<Forecast> getWeather(Location location) async {
    final requestUrl =
        '$endPointUrl/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=hourly,minutely&appid=$apiKey';
    final response = await this.httpClient.get(Uri.encodeFull(requestUrl));

    if (response.statusCode != 200) {
      throw Exception('error retrieving weather: ${response.statusCode}');
    }

    return Forecast.fromJson(jsonDecode(response.body));
  }
}
