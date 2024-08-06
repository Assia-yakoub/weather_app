import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_api_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherApiService _apiService = WeatherApiService();
  Weather? currentWeather;
  Forecast? forecast;
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchWeather(String city) async {
    isLoading = true;
    notifyListeners();
    try {
      currentWeather = await _apiService.fetchCurrentWeather(city);
      forecast = await _apiService.fetch5DayForecast(city);
      errorMessage = '';
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
