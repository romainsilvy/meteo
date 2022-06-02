import 'package:flutter/material.dart';
import 'package:meteo/main.dart';

class NavDrawer extends StatelessWidget {
  @override
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
          //button to insert cities
          ListTile(
            title: Text('Paris'),
            leading: Icon(Icons.location_city),
            trailing: IconButton(
              icon: new Icon(Icons.delete),
              onPressed: () {},
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('London'),
            leading: Icon(Icons.location_city),
            trailing: IconButton(
              icon: new Icon(Icons.delete),
              onPressed: () {},
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('New York'),
            leading: Icon(Icons.location_city),
            trailing: IconButton(
              icon: new Icon(Icons.delete),
              onPressed: () {},
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('Tokyo'),
            leading: Icon(Icons.location_city),
            trailing: IconButton(
              icon: new Icon(Icons.delete),
              onPressed: () {},
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Ajouter une ville'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => AddCity()),
              // );
            },
          ),
        ],
      ),
    );
  }
}
