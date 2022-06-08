import 'package:flutter/material.dart';
import 'package:meteo/models/city.dart';
import 'package:meteo/models/database_handler.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  final DatabaseHandler handler = DatabaseHandler();

  Widget build(BuildContext context) {
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
}

DrawerHeader _buildDrawerHeader() {
  return DrawerHeader(
    child: Text(
      'Mes villes',
      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 25),
    ),
    decoration: BoxDecoration(
        color: Colors.green,
        image: DecorationImage(
            fit: BoxFit.fill, image: AssetImage('assets/images/city.jpg'))),
  );
}
