import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_weather/providers/weather_provider.dart';
import 'package:go_weather/screens/weather_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GOWeather'),
         backgroundColor:Colors.lightBlueAccent,
  foregroundColor:Colors.white,
  centerTitle:true,

      ),
       body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return _buildTabletLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 250, 16, 0),
      child: SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _cityController,
            decoration: InputDecoration(
              labelText: 'Enter city name',
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              final cityName = _cityController.text;
              if (cityName.isNotEmpty) {
                context.read<WeatherProvider>().fetchWeather(cityName);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherDetailsScreen(),
                  ),
                );
              }
            },
            child: Text('Get Weather'),
          ),
        ],
      ),
    ));
  }

  Widget _buildTabletLayout() {
    return Center(

       child: SingleChildScrollView(
      child: Container(
        width: 400,
        child: Padding(
          
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Enter city name',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  final cityName = _cityController.text;
                  if (cityName.isNotEmpty) {
                    context.read<WeatherProvider>().fetchWeather(cityName);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WeatherDetailsScreen(),
                      ),
                    );
                  }
                },
                child: Text('Get Weather'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}