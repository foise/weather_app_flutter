import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/viewModel/city_entry_viewmodel.dart';
import 'viewModel/forecast_viewmodel.dart';
import 'view/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CityEntryViewModel>(
            create: (_) => CityEntryViewModel()),
        ChangeNotifierProvider<ForecastViewModel>(
            create: (_) => ForecastViewModel()),
      ],
      builder: (context, child) {
        return MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Provider',
      home: HomeView(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
