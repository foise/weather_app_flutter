import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/viewModel/city_entry_viewmodel.dart';

import 'package:weather_app/viewModel/forecast_viewmodel.dart';
import 'package:weather_app/view/weather_description_view.dart';
import 'package:weather_app/view/weather_summary_view.dart';
import 'package:weather_app/view/gradient_container.dart';

import 'city_entry_view.dart';
import 'daily_view.dart';
import 'last_updated_view.dart';
import 'location_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForecastViewModel>(
      builder: (context, weatherViewModel, child) => Scaffold(
        body: _buildGradientContainer(weatherViewModel.condition,
            weatherViewModel.isDaytime, buildHomeView(context)),
      ),
    );
  }

  Widget buildHomeView(BuildContext context) {
    return Consumer<ForecastViewModel>(
      builder: (context, weatherViewModel, child) => Container(
        height: MediaQuery.of(context).size.height,
        child: RefreshIndicator(
          color: Colors.transparent,
          backgroundColor: Colors.transparent,
          onRefresh: () => refreshWeather(weatherViewModel, context),
          child: ListView(
            children: <Widget>[
              CityEntryView(),
              weatherViewModel.isRequestPending
                  ? buildBusyIndicator()
                  : weatherViewModel.isRequestError
                      ? Center(
                          child: Text(
                            'Ooops...something went wrong',
                            style: TextStyle(fontSize: 21, color: Colors.white),
                          ),
                        )
                      : weatherViewModel.isWeatherLoaded
                          ? Column(
                              children: [
                                LocationView(
                                  longitude: weatherViewModel.longitude,
                                  latitude: weatherViewModel.latitide,
                                  city: weatherViewModel.city,
                                  date: weatherViewModel.latest.current.date,
                                ),
                                SizedBox(height: 50),
                                WeatherSummary(
                                    condition: weatherViewModel.condition,
                                    temp: weatherViewModel.temp,
                                    feelsLike: weatherViewModel.feelsLike,
                                    isdayTime: weatherViewModel.isDaytime),
                                SizedBox(height: 30),
                                WeatherDescriptionView(
                                    weatherDescription:
                                        weatherViewModel.description),
                                SizedBox(height: 100),
                                Text("Weather for the next 3 days:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    )),
                                buildDailySummary(weatherViewModel.daily),
                                LastUpdatedView(
                                    lastUpdatedOn:
                                        weatherViewModel.lastUpdated),
                              ],
                            )
                          : buildEnterCity(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEnterCity() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          'Enter City',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    );
  }

  Widget buildBusyIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
        SizedBox(
          height: 20,
        ),
        Text(
          'Please Wait...',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    );
  }

  Widget buildDailySummary(List<Weather> dailyForecast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dailyForecast
          .map(
            (item) => new DailySummaryView(
              weather: item,
            ),
          )
          .toList(),
    );
  }

  Future<void> refreshWeather(
      ForecastViewModel weatherVM, BuildContext context) {
    // get the current city
    String city = Provider.of<CityEntryViewModel>(context, listen: false).city;
    return weatherVM.getLatestWeather(city);
  }

  GradientContainer _buildGradientContainer(
      WeatherCondition condition, bool isDayTime, Widget child) {
    GradientContainer container;

    // if night time then just default to a blue/grey
    if (isDayTime != null && !isDayTime)
      container = GradientContainer(color: Colors.blueGrey, child: child);
    else {
      switch (condition) {
        case WeatherCondition.clear:
        case WeatherCondition.lightCloud:
          container = GradientContainer(color: Colors.yellow, child: child);
          break;
        case WeatherCondition.fog:
        case WeatherCondition.atmosphere:
        case WeatherCondition.rain:
        case WeatherCondition.drizzle:
        case WeatherCondition.mist:
        case WeatherCondition.heavyCloud:
          container = GradientContainer(color: Colors.indigo, child: child);
          break;
        case WeatherCondition.snow:
          container = GradientContainer(color: Colors.lightBlue, child: child);
          break;
        case WeatherCondition.thunderstorm:
          container = GradientContainer(color: Colors.deepPurple, child: child);
          break;
        default:
          container = GradientContainer(color: Colors.lightBlue, child: child);
      }
    }

    return container;
  }
}
