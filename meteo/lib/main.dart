import 'package:flutter/material.dart';
import 'package:meteo/models/database_handler.dart';
import 'package:meteo/home.dart';
import 'package:meteo/widgets/side_menu.dart';

import 'models/city.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Météo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
