import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:semana10_weather/models/forecast_model.dart';
import 'package:semana10_weather/models/weather_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  WeatherModel? weatherModel;
  ForecastModel? forecastModel;

  getData() async {
    // Llamada a la API
    String apiKey = "f50229e839b54e52b7902327230909";
    String url =
        "https://api.weatherapi.com/v1/current.json?key=$apiKey&q=${_controller.text}&aqi=no";

    String forecastUrl =
        "https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=${_controller.text}&days=7&aqi=no&alerts=no&dt=${DateTime.now().toString().substring(0, 10)}";
    var weather = await http.get(Uri.parse(url));
    var forecast = await http.get(Uri.parse(forecastUrl));

    if (weather.statusCode == 200) {
      // Si la llamada fue exitosa
      var jsonWeather = convert.jsonDecode(weather.body);
      var jsonForecast = convert.jsonDecode(forecast.body);
      forecastModel = ForecastModel.fromJson(jsonForecast);
      weatherModel = WeatherModel.fromJson(jsonWeather);

      setState(() {});
    } else {
      // Si la llamada no fue exitosa
      print("Request failed with status: ${weather.statusCode}.");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: const Color(0xff282B38),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff282B38),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Icon(
              Icons.wb_sunny_outlined,
              size: 100,
              color: Colors.white.withOpacity(0.7),
            ), // Icono del clima
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weatherModel?.current?.tempF.toString() ?? "0",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 100,
                    height: 2,
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre el número y el °C
                Text(
                  "°C",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.33),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              weatherModel?.location?.name ?? "City",
              style:
                  TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Feels like ${weatherModel?.current?.feelslikeC}",
                    style: TextStyle(color: Colors.white.withOpacity(0.5))),
                const SizedBox(width: 20),
                Text("Humedity ${weatherModel?.current?.humidity}",
                    style: TextStyle(color: Colors.white.withOpacity(0.5))),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: width * 0.7,
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search another location...",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      getData();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            forecastModel != null
                ? SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: forecastModel
                              ?.forecast?.forecastday?[0].hour?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return ItemWeatherWidget(
                          time: forecastModel
                              ?.forecast?.forecastday?[0].hour?[index].time,
                          tempF: forecastModel
                              ?.forecast?.forecastday?[0].hour?[index].tempF,
                        );
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class ItemWeatherWidget extends StatelessWidget {
  String? time;
  double? tempF;
  ItemWeatherWidget({
    super.key,
    required this.time,
    required this.tempF,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 30,
      ),
      decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(4, 4),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            time!.split(" ")[1],
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 5),
          const Icon(
            Icons.sunny,
            color: Colors.white,
            size: 25,
          ),
          const SizedBox(height: 5),
          Text(
            "${tempF.toString()} °C",
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
