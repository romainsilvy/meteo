// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meteo/models/weather_location.dart';
import 'package:meteo/widgets/single_weather.dart';
import 'package:meteo/widgets/side_menu.dart';
import 'package:meteo/widgets/slider_dot.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  late String bgImg;

  _OnPageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (locationList[_currentPage].weatherType == 'Sunny') {
      bgImg = 'assets/images/sunny.jpeg';
    } else if (locationList[_currentPage].weatherType == 'Night') {
      bgImg = 'assets/images/night.jpeg';
    } else if (locationList[_currentPage].weatherType == 'Rainy') {
      bgImg = 'assets/images/rainy.jpeg';
    } else if (locationList[_currentPage].weatherType == 'Cloudy') {
      bgImg = 'assets/images/cloudy.jpeg';
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Ma ville',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          child: Stack(children: [
        Image.asset(
          bgImg,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Container(
          decoration: BoxDecoration(color: Colors.black38),
        ),
        Container(
          margin: EdgeInsets.only(top: 140, left: 15),
          child: Row(children: [
            for (int i = 0; i < locationList.length; i++)
              if (i == _currentPage) SliderDot(true) else SliderDot(false),
          ]),
        ),
        PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _OnPageChange,
            itemCount: locationList.length,
            itemBuilder: (ctx, i) => SingleWeather(i)),
      ])),
    );
  }
}
