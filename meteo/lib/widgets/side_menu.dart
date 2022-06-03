import 'package:flutter/material.dart';
import 'package:meteo/models/city.dart';
import 'package:meteo/models/database_handler.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

class NavDrawer extends StatelessWidget {
  @override
  final DatabaseHandler handler = DatabaseHandler();

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Mes villes',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/city.jpg'))),
          ),
          //retrieve city from database
          FutureBuilder(
            future: handler.getAllCities(),
            builder:
                (BuildContext context, AsyncSnapshot<List<City>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(snapshot.data![index].name),
                      leading: Icon(Icons.location_city),
                      trailing: IconButton(
                        icon: new Icon(Icons.delete),
                        onPressed: () {},
                      ),
                      onTap: () {
                        // Navigator.pop(context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => MyHomePage(
                        //             title: snapshot.data[index].name)));
                      },
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          //button to insert cities
          ListTile(
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
                // setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }
}
