import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/vehicle.dart';

class VehicleController {
  Future<Database> initDatabase() async {
    final database = await getDatabase();
    return database;
  }

  Future<List<Vehicle>> searchVehicle(String query) async {
    final database = await initDatabase();

    final vehicles = await database.rawQuery('''
    SELECT * FROM ${TableVehicle.tableName}
    WHERE ${TableVehicle.modelColumn} LIKE ? OR ${TableVehicle.brandColumn} LIKE ?
  ''', ['%$query%', '%$query%']);

    if (vehicles.isNotEmpty) {
      return vehicles.map((vehicleMap) => TableVehicle.fromMap(vehicleMap)).toList();
    }

    return [];
  }

  Future<void> updateVehicle(Vehicle vehicle) async {
    final database = await initDatabase();

    await database.update(
      TableVehicle.tableName,
      TableVehicle.toMap(vehicle),
      where: '${TableVehicle.id} = ?',
      whereArgs: [vehicle.id],
    );
  }

  Future<void> deleteVehicle(int id) async {
    final database = await initDatabase();

    await database.delete(
      TableVehicle.tableName,
      where: '${TableVehicle.id} = ?',
      whereArgs: [id],
    );

  }

  Future<List<Vehicle>> getAllVehicles() async {
    final database = await initDatabase();
    final vehicles = await database.query(
      TableVehicle.tableName,
    );

    if (vehicles.isNotEmpty) {
      return vehicles.map((vehicleMap) => TableVehicle.fromMap(vehicleMap)).toList();
    }

    return [];
  }

  Future<void> insert(Vehicle vehicle) async {
    final database = await initDatabase();
    final map = TableVehicle.toMap(vehicle);

    await database.insert(TableVehicle.tableName, map);
  }

  Future<Vehicle?> getVehicle(String model, String brand) async {
    final database = await initDatabase();
    final vehicles = await database.query(
      TableVehicle.tableName,
      where:
      '${TableVehicle.modelColumn} = ? AND ${TableVehicle.brandColumn} = ?',
      whereArgs: [model, brand],
    );

    if (vehicles.isNotEmpty) {
      final vehicleMap = vehicles.first;
      return TableVehicle.fromMap(vehicleMap);
    }

    return null;
  }

  Future<Database> getDatabase() async {
    final path = join(
      await getDatabasesPath(),
      'register.db',
    );
    return await openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(TableVehicle.createTable);
      },
      version: 1,
    );
  }

  Future<bool> doesRecordExistWithId(int id) async {
    final database = await initDatabase();
    final count = Sqflite.firstIntValue(await database.rawQuery(
      'SELECT COUNT(*) FROM ${TableVehicle.tableName} WHERE ${TableVehicle.id} = ?',
      [id],
    ));
    return count! > 0;
  }
}

class TableVehicle {
  static const String createTable = '''
CREATE TABLE $tableName (
  $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  $brandColumn TEXT NOT NULL,
  $modelColumn TEXT NOT NULL,
  $manufactureYearColumn TEXT NOT NULL,
  $plateColumn TEXT NOT NULL,
  $vehicleYearColumn TEXT NOT NULL,
  $priceColumn TEXT NOT NULL,
  $purchaseDateColumn TEXT NOT NULL
)
''';

  static const String tableName = 'vehicle';
  static const String id = 'id';
  static const String brandColumn = 'brand';
  static const String modelColumn = 'model';
  static const String manufactureYearColumn = 'manufactureYear';
  static const String plateColumn = 'plate';
  static const String vehicleYearColumn = 'vehicleYear';
  static const String priceColumn = 'price';
  static const String purchaseDateColumn = 'purchaseDate';

  static Map<String, dynamic> toMap(Vehicle vehicle) {
    final map = <String, dynamic>{};
    map[id] = vehicle.id;
    map[brandColumn] = vehicle.brand;
    map[modelColumn] = vehicle.model;
    map[manufactureYearColumn] = vehicle.manufactureYear;
    map[plateColumn] = vehicle.plate;
    map[vehicleYearColumn] = vehicle.vehicleYear;
    map[priceColumn] = vehicle.price;
    map[purchaseDateColumn] = vehicle.purchaseDate;

    return map;
  }

  static Vehicle fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map[id],
      brand: map[brandColumn],
      model: map[modelColumn],
      manufactureYear: map[manufactureYearColumn],
      plate: map[plateColumn],
      vehicleYear: map[vehicleYearColumn],
      price: map[priceColumn],
      purchaseDate: map[purchaseDateColumn],
    );
  }
}
