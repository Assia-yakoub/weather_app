import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherApiService {
  final String apiKey = 'YOUR_API_KEY';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Weather> fetchCurrentWeather(String city) async {
    final response = await http.get(Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<Forecast> fetch5DayForecast(String city) async {
    final response = await http.get(Uri.parse('$baseUrl/forecast?q=$city&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return Forecast.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load forecast');
    }
  }
}
