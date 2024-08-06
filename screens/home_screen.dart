import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    weatherProvider.fetchWeather(_controller.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            weatherProvider.isLoading
                ? CircularProgressIndicator()
                : weatherProvider.errorMessage.isNotEmpty
                    ? Text(weatherProvider.errorMessage)
                    : weatherProvider.currentWeather != null
                        ? Column(
                            children: [
                              Text(
                                'Current Weather in ${_controller.text}',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                'Temperature: ${weatherProvider.currentWeather!.temperature}°C',
                              ),
                              Text(
                                'Humidity: ${weatherProvider.currentWeather!.humidity}%',
                              ),
                              Text(
                                'Description: ${weatherProvider.currentWeather!.description}',
                              ),
                              SizedBox(height: 20),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: weatherProvider.forecast?.daily.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final weather = weatherProvider.forecast!.daily[index];
                                    return ListTile(
                                      title: Text(
                                        'Day ${index + 1}: ${weather.description}',
                                      ),
                                      subtitle: Text(
                                        'Temp: ${weather.temperature}°C, Humidity: ${weather.humidity}%',
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        : Container(),
          ],
        ),
      ),
    );
  }
}
