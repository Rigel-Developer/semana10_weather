import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:semana10_weather/models/forecast_model.dart';
import 'package:semana10_weather/models/weather_model.dart';
import 'package:semana10_weather/services/weather_service.dart';

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
    ApiService apiServices = ApiService();

    weatherModel = await apiServices.getWeather(_controller.text);
    forecastModel = await apiServices.getForecast(_controller.text);
    // setState(() {});
  }

  getDataCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    ApiService apiServices = ApiService();
    weatherModel = await apiServices.getWeatherLocation(
        position.latitude, position.longitude);
    forecastModel = await apiServices.getForecastLocation(
        position.latitude, position.longitude);
    return forecastModel;
    // setState(() {});
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.7,
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search another location...",
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.5)),
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
                IconButton(
                  onPressed: () {
                    getDataCurrentLocation();
                  },
                  icon: Icon(
                    Icons.my_location,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            FutureBuilder(
                future: getDataCurrentLocation(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data as ForecastModel;
                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            data.forecast?.forecastday?[0].hour?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ItemWeatherWidget(
                            time: data
                                .forecast?.forecastday?[0].hour?[index].time,
                            tempF: data
                                .forecast?.forecastday?[0].hour?[index].tempF,
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
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
