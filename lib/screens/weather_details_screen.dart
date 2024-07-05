import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_weather/providers/weather_provider.dart';

class WeatherDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details'),
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              if (weatherProvider.weather != null) {
                weatherProvider.fetchWeather(weatherProvider.weather!.cityName);
              }
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _buildTabletLayout(weatherProvider);
          } else {
            return _buildMobileLayout(weatherProvider);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(WeatherProvider weatherProvider) {
    
    return Center(
       child: SingleChildScrollView(
      
      child: weatherProvider.isLoading
          ? CircularProgressIndicator()
          : weatherProvider.errorMessage != null
              ? Text(
                  weatherProvider.errorMessage!,
                  style: TextStyle(color: Colors.red),
                )
              : weatherProvider.weather == null
                  ? Text('Enter a city to get weather details.')
                  : Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(16),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              image: DecorationImage(
                                image: _getBackgroundImage(weatherProvider.weather!.temperature),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.black.withOpacity(0.3), // Reduce opacity of the overlay
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  weatherProvider.weather!.cityName,
                                  style: TextStyle(fontSize: 32, color: Colors.white),
                                ),
                                Text(
                                  '${weatherProvider.weather!.temperature} °C',
                                  style: TextStyle(fontSize: 32, color: Colors.white),
                                ),
                                Text(
                                  weatherProvider.weather!.condition,
                                  style: TextStyle(fontSize: 24, color: Colors.white),
                                ),
                                Image.network(
                                  'http://openweathermap.org/img/wn/${weatherProvider.weather!.icon}@2x.png',
                                ),
                                Text(
                                  'Humidity: ${weatherProvider.weather!.humidity}%',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Wind Speed: ${weatherProvider.weather!.windSpeed} m/s',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
    ));
  }

  Widget _buildTabletLayout(WeatherProvider weatherProvider) {
    return Center(
       child: SingleChildScrollView(
      child: weatherProvider.isLoading
          ? SizedBox(
              child: CircularProgressIndicator(),
              width: 50,
              height: 50,
            )
          : weatherProvider.errorMessage != null
              ? Text(
                  weatherProvider.errorMessage!,
                  style: TextStyle(color: Colors.red),
                )
              : weatherProvider.weather == null
                  ? Text('Enter a city to get weather details.')
                  : SizedBox(
                      width: 500, // Adjust the width for tablets
                      height: 600, // Adjust the height for tablets
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 4,
                        margin: EdgeInsets.all(16),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                image: DecorationImage(
                                  image: _getBackgroundImage(weatherProvider.weather!.temperature),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.black.withOpacity(0.3), // Reduce opacity of the overlay
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(150,150,0,0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    weatherProvider.weather!.cityName,
                                    style: TextStyle(fontSize: 32, color: Colors.white),
                                  ),
                                  Text(
                                    '${weatherProvider.weather!.temperature} °C',
                                    style: TextStyle(fontSize: 32, color: Colors.white),
                                  ),
                                  Text(
                                    weatherProvider.weather!.condition,
                                    style: TextStyle(fontSize: 24, color: Colors.white),
                                  ),
                                  Image.network(
                                    'http://openweathermap.org/img/wn/${weatherProvider.weather!.icon}@2x.png',
                                  ),
                                  Text(
                                    'Humidity: ${weatherProvider.weather!.humidity}%',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'Wind Speed: ${weatherProvider.weather!.windSpeed} m/s',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
    ));
  }

  ImageProvider _getBackgroundImage(double temperature) {
    if (temperature > 30) {
      return AssetImage('assets/warm.jpg');
    } else if (temperature > 20) {
      return AssetImage('assets/mild.jpg');
    } else {
      return AssetImage('assets/cold.jpg');
    }
  }
}
