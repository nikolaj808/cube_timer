import 'package:cube_timer/src/database/tables/times_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  final _databaseVersion = 1;
  final _databaseName = 'cube_timer.db';

  Future<Database> getInstance() async {
    final databasePath = await getDatabasesPath();

    return openDatabase(
      join(databasePath, _databaseName),
      singleInstance: true,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await _createDatabase(db, version);
        await _seedDatabase(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _dropDatabase(db);
        await _createDatabase(db, newVersion);
        await _seedDatabase(db);
      },
    );
  }

  Future<void> _dropDatabase(Database db) async {
    await db.execute('drop table if exists ${TimesTable().name}');
  }

  Future<void> _createDatabase(Database db, int version) async {
    await TimesTable().create(db, version);
  }

  Future<void> _seedDatabase(Database db) async {}
}
