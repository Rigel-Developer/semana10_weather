import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:semana10_weather/models/forecast_model.dart';
import 'package:semana10_weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  ForecastModel? forecastModel;
  // ForecastModel? forecastModel2;

  List<Hour> listHour = [];

  getDataCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    ApiService apiServices = ApiService();
    forecastModel = await apiServices.getForecastLocation(
        position.latitude, position.longitude);
    listHour = forecastModel!.forecast!.forecastday![0].hour!.reversed
        .take(5)
        .toList();

    // return forecastModel;
    setState(() {});
  }

  getDateFuture() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    ApiService apiServices = ApiService();
    ForecastModel fore = await apiServices.getFutureWeather(
        position.latitude, position.longitude);
    return fore;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataCurrentLocation();
    // getDateFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: const Color(0xff282B38),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff282B38),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 200,
            child: CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                // autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                disableCenter: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              items: listHour
                  .map(
                    (item) => Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                              width: 300,
                              height: 200,
                              margin: const EdgeInsets.all(5.0),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 24),
                              decoration: BoxDecoration(
                                color: const Color(0xff2D3341),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.time!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white.withOpacity(0.33),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Today is very cold, you should wear a coat and a hat",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )),
                          Positioned(
                            top: -30,
                            right: 30,
                            child: Image.network(
                              "https:${item.condition!.icon}",
                              scale: 0.8,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listHour.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Next 7 days",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: getDateFuture(),
                // initialData: ,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ForecastModel? forecastModel2 =
                        snapshot.data as ForecastModel?;
                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        // scrollDirection: Axis.horizontal,
                        itemCount:
                            forecastModel2!.forecast!.forecastday!.length,
                        itemBuilder: (context, index) {
                          return ItemListTimeWidget(
                            day: forecastModel2.forecast!.forecastday![index],
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ItemListTimeWidget extends StatelessWidget {
  // ForecastModel forecastModel2;
  Forecastday day;
  ItemListTimeWidget({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day.date!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text(
                    "${day.day!.maxtempC.toString()}°",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${day.day!.maxtempF.toString()}°",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  )
                ],
              ),
              Image.network(
                "https:${day.day!.condition!.icon}",
                // scale: 0.8,
              ),
            ],
          )
        ],
      ),
    );
  }
}
