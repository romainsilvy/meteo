// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meteo/models/weather_location.dart';
import 'package:meteo/widgets/single_weather.dart';
import 'package:meteo/widgets/side_menu.dart';
import 'package:meteo/widgets/slider_dot.dart';
import 'package:meteo/models/database_handler.dart';
import 'package:meteo/models/city.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  late String bgImg;
  final DatabaseHandler handler = DatabaseHandler();

  _OnPageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Drawer _drawer() {
    return Drawer(
      child: FutureBuilder(
        future: handler.getAllCities(),
        builder: (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: (snapshot.data!.length ?? 0) + 2,
              itemBuilder: (BuildContext context, int index) {
                //print an item on top of the list
                if (index == 0)
                  return DrawerHeader(
                    child: Text(
                      'Mes villes',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 25),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/city.jpg'))),
                  );
                else if (index <= snapshot.data!.length) {
                  return ListTile(
                    title: Text(snapshot.data![index - 1].name),
                    leading: Icon(Icons.location_city),
                    trailing: IconButton(
                      icon: new Icon(Icons.delete),
                      onPressed: () {
                        handler.deleteCity(snapshot.data![index - 1].name);
                        setState(() {});
                      },
                    ),
                    onTap: () {},
                  );
                } else {
                  return ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Ajouter une ville'),
                    onTap: () async {
                      String? cityName = await prompt(
                        context,
                        title: const Text('Ajoutez une ville'),
                      );
                      if (cityName != null) {
                        City city = City(name: cityName);
                        await handler.insertCity(city);
                        setState(() {});
                      }
                    },
                  );
                }
              },
            );
          } else {
            return ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Chargement...'),
                ),
              ],
            );
            // )
          }
        },
      ),
      // button to insert cities
      // ListTile(
      //   leading: Icon(Icons.add),
      //   title: Text('Ajouter une ville'),
      //   onTap: () async {
      //     String? cityName = await prompt(
      //       context,
      //       title: const Text('Ajoutez une ville'),
      //     );
      //     if (cityName != null) {
      //       City city = City(name: cityName);
      //       await handler.insertCity(city);
      //       setState(() {});
      //     }
      //   },
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (locationList[_currentPage].weatherType == 'Sunny') {
    bgImg = 'assets/images/sunny.jpeg';
    // } else if (locationList[_currentPage].weatherType == 'Night') {
    //   bgImg = 'assets/images/night.jpeg';
    // } else if (locationList[_currentPage].weatherType == 'Rainy') {
    //   bgImg = 'assets/images/rainy.jpeg';
    // } else if (locationList[_currentPage].weatherType == 'Cloudy') {
    //   bgImg = 'assets/images/cloudy.jpeg';
    // }

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: _drawer(),
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
        FutureBuilder(
            future: handler.getAllCities(),
            builder:
                (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  margin: EdgeInsets.only(top: 140, left: 15),
                  child: Row(children: [
                    for (int i = 0; i < snapshot.data!.length; i++)
                      if (i == _currentPage)
                        SliderDot(true)
                      else
                        SliderDot(false),
                  ]),
                );
              } else {
                return Container();
              }
            }),
        FutureBuilder(
            future: handler.getAllCities(),
            builder:
                (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
              if (snapshot.hasData) {
                return PageView.builder(
                    scrollDirection: Axis.horizontal,
                    onPageChanged: _OnPageChange,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (ctx, i) =>
                        SingleWeather(index: i, name: snapshot.data![i].name));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ])),
    );
  }
}
