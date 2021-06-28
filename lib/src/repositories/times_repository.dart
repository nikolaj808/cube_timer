import 'package:cube_timer/src/database/database_service.dart';
import 'package:cube_timer/src/database/tables/times_table.dart';
import 'package:cube_timer/src/models/time.dart';

class TimesRepository {
  final DatabaseService databaseService;

  TimesRepository({required this.databaseService});

  Future<List<Time>> getTimes() async {
    final db = await databaseService.getInstance();

    final data = await db.query(TimesTable().name);

    final times = data.map((time) => Time.fromMap(time)).toList();

    return times;
  }

  Future<Time> createTime(Time time) async {
    final db = await databaseService.getInstance();

    final id = await db.insert(TimesTable().name, time.toMap());

    final newTime = time.copyWith(id: id);

    return newTime;
  }
}
