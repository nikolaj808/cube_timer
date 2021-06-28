import 'package:cube_timer/src/cubits/time_cubit.dart';
import 'package:cube_timer/src/database/database_service.dart';
import 'package:cube_timer/src/pages/home_page.dart';
import 'package:cube_timer/src/repositories/times_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final databaseService = DatabaseService();
    final timesRepository = TimesRepository(databaseService: databaseService);

    return BlocProvider(
      create: (_) => TimeCubit(timesRepository: timesRepository)..getTimes(),
      child: MaterialApp(
        title: 'Cube Timer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(primaryColor: Colors.indigo),
        home: HomePage(),
      ),
    );
  }
}
