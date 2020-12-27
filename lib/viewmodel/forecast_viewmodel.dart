import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/api/openweather_api.dart';
import 'package:weather_app/model/forecast.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/service/forecast_service.dart';
import 'package:weather_app/util/temperature_convert.dart';

class ForecastViewModel with ChangeNotifier {
  bool isRequestPending = false;
  bool isWeatherLoaded = false;
  bool isRequestError = false;

  WeatherCondition _condition;
  String _description;
  double _minTemp;
  double _maxTemp;
  double _temp;
  double _feelsLike;
  int _locationId;
  DateTime _lastUpdated;
  String _city;
  double _latitude;
  double _longitude;
  List<Weather> _daily;
  bool _isDayTime;

  WeatherCondition get condition => _condition;
  String get description => _description;
  double get minTemp => _minTemp;
  double get maxTemp => _maxTemp;
  double get temp => _temp;
  double get feelsLike => _feelsLike;
  int get locationId => _locationId;
  DateTime get lastUpdated => _lastUpdated;
  String get city => _city;
  double get longitude => _longitude;
  double get latitide => _latitude;
  bool get isDaytime => _isDayTime;
  List<Weather> get daily => _daily;

  ForecastService forecastService;
  Forecast latest;

  ForecastViewModel() {
    forecastService = ForecastService(OpenWeatherMapWeatherApi());
  }

  Future<Forecast> getLatestWeather(String city) async {
    setRequestPendingState(true);
    this.isRequestError = false;

    try {
      latest = await forecastService
          .getWeather(city)
          .catchError((onError) => this.isRequestError = true);
    } catch (e) {
      this.isRequestError = true;
    }

    this.isWeatherLoaded = true;
    updateModel(latest, city);
    setRequestPendingState(false);
    notifyListeners();
    return latest;
  }

  void setRequestPendingState(bool isPending) {
    this.isRequestPending = isPending;
    notifyListeners();
  }

  void updateModel(Forecast forecast, String city) {
    if (isRequestError) return;

    _condition = forecast.current.condition;
    _city = city;
    _description = forecast.current.description;
    _lastUpdated = forecast.lastUpdated;
    _temp = TemperatureConvert.kelvinToCelsius(forecast.current.temp);
    _feelsLike =
        TemperatureConvert.kelvinToCelsius(forecast.current.feelLikeTemp);
    _longitude = forecast.longitude;
    _latitude = forecast.latitude;
    _daily = forecast.daily;
    _isDayTime = forecast.isDayTime;
  }
}
