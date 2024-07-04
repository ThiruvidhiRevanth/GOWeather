import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_weather/models/weather.dart';
import 'package:go_weather/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final WeatherService _weatherService = WeatherService();

  WeatherProvider() {
    _loadLastCity();
  }

  Future<void> _loadLastCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastCity = prefs.getString('lastCity');
    if (lastCity != null) {
      fetchWeather(lastCity);
    }
  }

  Future<void> _saveLastCity(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lastCity', cityName);
  }

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _weather = await _weatherService.fetchWeather(cityName);
      _saveLastCity(cityName);
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
