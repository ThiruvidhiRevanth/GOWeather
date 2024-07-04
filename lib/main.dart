import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_weather/providers/weather_provider.dart';
import 'package:go_weather/screens/home_screen.dart';
import 'dart:async'; 

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GO Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        
      ),
      home: MyWidget(),
    );
  }
}
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
   @override 
  void initState() { 
    super.initState(); 
    Timer(Duration(seconds: 3), 
          ()=>Navigator.pushReplacement(context, 
                                        MaterialPageRoute(builder: 
                                                          (context) =>  
                                                          HomeScreen() 
                                                         ) 
                                       ) 
         ); 
  } 
  @override
   Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor:Color(0xFF0A2B3F ),
      body: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/logo.png'),
        ),
      ]),
    );
  }
}

 