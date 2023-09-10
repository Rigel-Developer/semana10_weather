import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:semana10_weather/models/forecast_model.dart';
import 'package:semana10_weather/models/weather_model.dart';

class ApiService {
  String apiKey = "f50229e839b54e52b7902327230909";

  Future<WeatherModel?> getWeatherLocation(
    double latitude,
    double longitude,
  ) async {
    Uri url = Uri.parse(
        "https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$latitude,$longitude&aqi=no");

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = convert.jsonDecode(response.body);
      WeatherModel weatherModel = WeatherModel.fromJson(data);
      return weatherModel;
    }
    return null;
  }

  Future<ForecastModel?> getForecastLocation(
    double latitude,
    double longitude,
  ) async {
    Uri url = Uri.parse(
        "https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$latitude,$longitude&aqi=no&alerts=no&dt=${DateTime.now().toString().substring(0, 10)}");

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = convert.jsonDecode(response.body);
      ForecastModel forecastModel = ForecastModel.fromJson(data);
      return forecastModel;
    }
    return null;
  }

  Future<WeatherModel> getWeather(String city) async {
    String url =
        "https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no";

    var weather = await http.get(Uri.parse(url));
    var jsonWeather = convert.jsonDecode(weather.body);
    WeatherModel weatherModel = WeatherModel.fromJson(jsonWeather);
    return weatherModel;
  }

  Future<ForecastModel> getForecast(
    String city,
  ) async {
    String forecastUrl =
        "https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&aqi=no&alerts=no&dt=${DateTime.now().toString().substring(0, 10)}";
    var forecast = await http.get(Uri.parse(forecastUrl));
    var jsonForecast = convert.jsonDecode(forecast.body);
    ForecastModel forecastModel = ForecastModel.fromJson(jsonForecast);
    return forecastModel;
  }

  Future<ForecastModel> getFutureWeather(
    double latitude,
    double longitude,
  ) async {
    DateTime now = DateTime.now();
    DateTime datePlusthree = now.add(const Duration(days: 3));

    String forecastUrl =
        "https://api.weatherapi.com/v1/history.json?key=$apiKey&q=$latitude,$longitude&days=7&aqi=no&alerts=no&dt=${now.toString().substring(0, 10)}&end_dt=${datePlusthree.toString().substring(0, 10)}";

    var forecast = await http.get(Uri.parse(forecastUrl));
    var jsonForecast = convert.jsonDecode(forecast.body);
    ForecastModel forecastModel = ForecastModel.fromJson(jsonForecast);
    return forecastModel;
  }
}
