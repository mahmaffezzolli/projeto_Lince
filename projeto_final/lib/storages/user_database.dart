import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/store.dart';

class StoreController {
  Future<Database> initDatabase() async {
    final database = await getDatabase();
    return database;
  }

  Future<void> delete(int id) async {
    final database = await initDatabase();

    await database.delete(
      TableStore.tableName,
      where: '${TableStore.id} = ?',
      whereArgs: [id],
    );
  }

  Future<List<Store>> getAllStores() async {
    final database = await initDatabase();
    final stores = await database.query(
      TableStore.tableName,
    );

    if (stores.isNotEmpty) {
      return stores.map((storeMap) => TableStore.fromMap(storeMap)).toList();
    }

    return [];
  }

  Future<void> insert(Store store) async {
    final database = await initDatabase();
    final map = TableStore.toMap(store);

    await database.insert(TableStore.tableName, map);
  }

  Future<Store?> getUser(String username, String password) async {
    final database = await initDatabase();
    final stores = await database.query(
      TableStore.tableName,
      where:
          '${TableStore.nameColumn} = ? AND ${TableStore.passwordColumn} = ?',
      whereArgs: [username, password],
    );

    if (stores.isNotEmpty) {
      final storeMap = stores.first;
      return TableStore.fromMap(storeMap);
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
        db.execute(TableStore.createTable);
      },
      version: 1,
    );
  }
}

class TableStore {
  static const String createTable = '''
CREATE TABLE $tableName (
  $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  $cnpjColumn TEXT NOT NULL,
  $nameColumn TEXT NOT NULL,
  $passwordColumn TEXT NOT NULL,
  $autonomyColumn TEXT NOT NULL
)
''';

  static const String tableName = 'store';
  static const String id = 'id';
  static const String cnpjColumn = 'cnpj';
  static const String nameColumn = 'name';
  static const String passwordColumn = 'password';
  static const String autonomyColumn = 'autonomy';
  static Map<String, dynamic> toMap(Store store) {
    final map = <String, dynamic>{};
    map[id] = store.id;
    map[nameColumn] = store.name;
    map[cnpjColumn] = store.cnpj;
    map[passwordColumn] = store.password;
    map[autonomyColumn] = store.autonomy;
    return map;
  }

  static Store fromMap(Map<String, dynamic> map) {
    return Store(
      id: map[id],
      cnpj: map[cnpjColumn],
      name: map[nameColumn],
      password: map[passwordColumn],
      autonomy: map[autonomyColumn],
    );
  }
}
