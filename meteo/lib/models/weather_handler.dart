import 'package:meteo/models/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherHandler {
  final String API_KEY = "e90875c3b76e69fa56f7a4c02ed8d13b";

  Future<WeatherData> getWeather(String cityName) async {
    final String url =
        "http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$API_KEY&units=metric";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
