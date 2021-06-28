import 'package:cube_timer/src/database/create_table.dart';
import 'package:cube_timer/src/database/database_table.dart';
import 'package:sqflite/sqflite.dart';

class TimesTable extends DatabaseTable {
  @override
  Future<void> create(Database db, int version) async {
    await createTable(db, version, name, [
      'id INTEGER PRIMARY KEY',
      'time INTEGER',
      'createdAt INTEGER',
    ]);
  }

  @override
  String get name => 'times';
}
