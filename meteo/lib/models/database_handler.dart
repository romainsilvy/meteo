import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:meteo/models/city.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'city.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE cities(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  //insert city
  Future<int> insertCity(City city) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('cities', city.toMap());
    return result;
  }

  //get all cities
  Future<List<City>> getAllCities() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('cities');
    return List.generate(maps.length, (i) {
      return City(
        name: maps[i]['name'],
      );
    });
  }

  //delete city
  Future<void> deleteCity(String name) async {
    final Database db = await initializeDB();
    await db.delete('cities', where: 'name = ?', whereArgs: [name]);
  }

  //clear all cities
  Future<void> clearAllCities() async {
    final Database db = await initializeDB();
    await db.delete('cities');
  }
}
