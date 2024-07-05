import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_weather/models/weather.dart';

class WeatherService {
  static const _apiKey = 'your_api_key';
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  Future<Weather> fetchWeather(String cityName) async {
    final response = await http.get(Uri.parse('$_baseUrl?q=$cityName&units=metric&appid=$_apiKey'));

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw('Failed to load weather');
    }
  }
}
