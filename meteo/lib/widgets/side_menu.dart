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
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 25),
            ),
            // decoration: BoxDecoration(
            //     color: Colors.green,
            //     image: DecorationImage(
            //         fit: BoxFit.fill,
            //         image: AssetImage('assets/images/cover.jpg'))),
          ),
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
        ],
      ),
    );
  }
}
