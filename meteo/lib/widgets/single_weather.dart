import 'package:flutter/material.dart';
import 'package:meteo/models/daily_weather_data.dart';
import 'package:meteo/models/weather_data.dart';
import 'package:meteo/models/weather_handler.dart';
import 'package:meteo/models/database_handler.dart';

import 'package:intl/intl.dart';

// class SingleWeather extends StatelessWidget {
// final int index;
// const SingleWeather(this.index);

//   @override

// }

class SingleWeather extends StatefulWidget {
  final int index;
  final String name;

  const SingleWeather({Key? key, required this.index, required this.name})
      : super(key: key);

  @override
  State<SingleWeather> createState() => _SingleWeatherState();
}

class _SingleWeatherState extends State<SingleWeather> {
  late DatabaseHandler handler;
  double lat = 45.76;
  double lon = 4.83;
  final WeatherHandler weatherHandler = WeatherHandler();

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
                future: weatherHandler.getWeather(widget.name),
                builder: (BuildContext context,
                    AsyncSnapshot<WeatherData> snapshot) {
                  if (snapshot.hasData) {
                    lat = snapshot.data!.coord!.lat!;
                    lon = snapshot.data!.coord!.lon!;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 150),
                                      Text(
                                        snapshot.data!.name!,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 35,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${DateTime.fromMillisecondsSinceEpoch(snapshot.data!.dt! * 1000).hour + DateTime.fromMillisecondsSinceEpoch(snapshot.data!.timezone! * 1000).hour} : ${DateTime.fromMillisecondsSinceEpoch(snapshot.data!.dt! * 1000).minute} - ${DateTime.fromMillisecondsSinceEpoch(snapshot.data!.dt! * 1000).day}/${DateTime.fromMillisecondsSinceEpoch(snapshot.data!.dt! * 1000).month}/${DateTime.fromMillisecondsSinceEpoch(snapshot.data!.dt! * 1000).year}',
                                        style: const TextStyle(
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
                                      '${snapshot.data!.main!.temp.toString()}??C',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 85,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Row(
                                      children: [
                                        Image.network(
                                          'http://openweathermap.org/img/wn/${snapshot.data!.weather![0].icon}.png',
                                          height: 34,
                                          width: 34,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data!.weather![0].main!,
                                          style: const TextStyle(
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
                        ]);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          FutureBuilder(
              future: weatherHandler.getDailyWeather(lat, lon),
              builder: (BuildContext context,
                  AsyncSnapshot<DailyWeatherData> snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
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
                                DateFormat('EEEE').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        snapshot.data!.daily![1].dt! * 1000)),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${snapshot.data!.daily![1].temp!.day.toString()}??C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              //display a   png icon from the web
                              Image.network(
                                'http://openweathermap.org/img/wn/${snapshot.data!.daily![1].weather![0].icon}.png',
                              )
                            ]),
                            Column(children: [
                              Text(
                                DateFormat('EEEE').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        snapshot.data!.daily![2].dt! * 1000)),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${snapshot.data!.daily![2].temp!.day.toString()}??C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Image.network(
                                'http://openweathermap.org/img/wn/${snapshot.data!.daily![2].weather![0].icon}.png',
                              )
                            ]),
                            Column(children: [
                              Text(
                                DateFormat('EEEE').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        snapshot.data!.daily![3].dt! * 1000)),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${snapshot.data!.daily![3].temp!.day.toString()}??C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Image.network(
                                'http://openweathermap.org/img/wn/${snapshot.data!.daily![3].weather![0].icon}.png',
                              )
                            ]),
                            Column(children: [
                              Text(
                                DateFormat('EEEE').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        snapshot.data!.daily![4].dt! * 1000)),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${snapshot.data!.daily![4].temp!.day.toString()}??C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Image.network(
                                'http://openweathermap.org/img/wn/${snapshot.data!.daily![4].weather![0].icon}.png',
                              )
                            ]),
                            Column(children: [
                              Text(
                                DateFormat('EEEE').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        snapshot.data!.daily![5].dt! * 1000)),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${snapshot.data!.daily![5].temp!.day.toString()}??C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Image.network(
                                'http://openweathermap.org/img/wn/${snapshot.data!.daily![5].weather![0].icon}.png',
                              )
                            ]),
                          ]),
                    ),
                  ]);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
    );
  }
}
