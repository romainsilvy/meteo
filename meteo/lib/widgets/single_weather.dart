import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meteo/models/weather.dart';
import 'package:meteo/models/weather_handler.dart';
import 'package:meteo/models/database_handler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meteo/models/weather_location.dart';

// class SingleWeather extends StatelessWidget {
// final int index;
// const SingleWeather(this.index);

//   @override

// }

class SingleWeather extends StatefulWidget {
  final int index;

  const SingleWeather({Key? key, required this.index}) : super(key: key);

  @override
  State<SingleWeather> createState() => _SingleWeatherState();
}

class _SingleWeatherState extends State<SingleWeather> {
  late DatabaseHandler handler;
  final WeatherHandler weatherHandler = WeatherHandler();

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: FutureBuilder(
          future: weatherHandler.getWeather(locationList[widget.index].city),
          builder: (BuildContext context, AsyncSnapshot<WeatherData> snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 150),
                              Text(
                                snapshot.data!.name!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                snapshot.data!.timezone!.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${snapshot.data!.main!.temp.toString()}°C',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 85,
                                  fontWeight: FontWeight.w300),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  locationList[widget.index].iconUrl,
                                  height: 34,
                                  width: 34,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  locationList[widget.index].weatherType,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(children: [
                              Text(
                                'Mardi',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '10\u2103',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/images/moon.svg',
                                height: 24,
                                width: 24,
                                color: Colors.white,
                              ),
                            ]),
                            Column(children: [
                              Text(
                                'Mercredi',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '17\u2103',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/images/cloudy.svg',
                                height: 24,
                                width: 24,
                                color: Colors.white,
                              ),
                            ]),
                            Column(children: [
                              Text(
                                'Jeudi',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '14\u2103',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/images/moon.svg',
                                height: 24,
                                width: 24,
                                color: Colors.white,
                              ),
                            ]),
                            Column(children: [
                              Text(
                                'Vendredi',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '25\u2103',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/images/rain.svg',
                                height: 24,
                                width: 24,
                                color: Colors.white,
                              ),
                            ]),
                            Column(children: [
                              Text(
                                'Samedi',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '34\u2103',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/images/sun.svg',
                                height: 24,
                                width: 24,
                                color: Colors.white,
                              ),
                            ]),
                          ]),
                    ),
                  ]),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
