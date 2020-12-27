import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/viewModel/forecast_viewmodel.dart';

class CityEntryViewModel with ChangeNotifier {
  String _city;

  CityEntryViewModel();

  String get city => _city;

  void refreshWeather(String newCity, BuildContext context) {
    Provider.of<ForecastViewModel>(context, listen: false)
        .getLatestWeather(_city);

    notifyListeners();
  }

  void updateCity(String newCity) {
    _city = newCity;
  }
}
