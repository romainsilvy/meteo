import 'package:flutter/material.dart';

class WeatherLocation {
  final String city;
  final String dateTime;
  final String temparature;
  final String weatherType;
  final String iconUrl;

  WeatherLocation({
    required this.city,
    required this.dateTime,
    required this.temparature,
    required this.weatherType,
    required this.iconUrl,
  });
}

final locationList = [
  WeatherLocation(
    city: 'Kolkata',
    dateTime: '07:50 PM — Monday, 9 Nov 2020',
    temparature: '24\u2103',
    weatherType: 'Night',
    iconUrl: 'assets/images/moon.svg',
  ),
  WeatherLocation(
    city: 'London',
    dateTime: '02:20 PM — Monday, 9 Nov 2020',
    temparature: '15\u2103',
    weatherType: 'Cloudy',
    iconUrl: 'assets/images/cloudy.svg',
  ),
  WeatherLocation(
    city: 'New York',
    dateTime: '09:20 AM — Monday, 9 Nov 2020',
    temparature: '17\u2103',
    weatherType: 'Sunny',
    iconUrl: 'assets/images/sun.svg',
  ),
  WeatherLocation(
    city: 'Sydney',
    dateTime: '01:20 AM — Tuesday, 10 Nov 2020',
    temparature: '10\u2103',
    weatherType: 'Rainy',
    iconUrl: 'assets/images/rain.svg',
  ),
];
