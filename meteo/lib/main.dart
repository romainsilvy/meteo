import 'package:flutter/material.dart';
import 'package:meteo/models/database_handler.dart';
import 'package:meteo/models/weather_handler.dart';
import 'package:meteo/models/weather.dart';

import 'package:meteo/widgets/side_menu.dart';

import 'models/city.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Paris'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DatabaseHandler handler;
  final WeatherHandler weatherHandler = WeatherHandler();

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB().whenComplete(() async {
      await handler.clearAllCities();
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Paris'),
      ),
      //retrieve the weather data of lyon
      body: FutureBuilder(
        future: weatherHandler.getWeather('Paris'),
        builder: (BuildContext context, AsyncSnapshot<WeatherData> snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${snapshot.data!.main!.temp.toString()}°C',
                    style: TextStyle(fontSize: 50),
                  ),
                  Text(
                    '${snapshot.data!.weather![0].description}',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
