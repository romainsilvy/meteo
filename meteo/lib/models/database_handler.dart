import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:meteo/models/city.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'example.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE cities(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  //insert city
  Future<void> insertCity(City city) async {
    final Database db = await initializeDB();
    await db.insert('users', city.toMap());
  }

  //get all cities
  Future<List<City>> getCities() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('cities');
    return List.generate(maps.length, (i) {
      return City(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  //delete city
  Future<void> deleteCity(City city) async {
    final Database db = await initializeDB();
    await db.delete('cities', where: 'id = ?', whereArgs: [city.id]);
  }
}
