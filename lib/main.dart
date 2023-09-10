import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semana10_weather/pages/home_page.dart';
import 'package:semana10_weather/pages/weather_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.dmSansTextTheme(),
      ),
      // home: const HomePage(),
      home: const WeatherPage(),
    );
  }
}
