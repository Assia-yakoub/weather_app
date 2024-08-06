class Weather {
  final String description;
  final double temperature;
  final double humidity;

  Weather({required this.description, required this.temperature, required this.humidity});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
    );
  }
}

class Forecast {
  final List<Weather> daily;

  Forecast({required this.daily});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List;
    List<Weather> weatherList = list.map((i) => Weather.fromJson(i)).toList();
    return Forecast(daily: weatherList);
  }
}
