import 'package:cube_timer/src/cubits/time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeCubit, TimeState>(
      builder: (context, state) {
        if (state is TimesLoaded) {
          final times = state.times;

          return ListView.builder(
            itemCount: times.length,
            itemBuilder: (context, index) {
              final time = times.elementAt(index);

              return ListTile(
                title: Text('${(time.time ~/ 1000)}.${(time.time % 1000)}s'),
                subtitle: Text(Jiffy(time.createdAt).format('dd/MM/yyyy H:m')),
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
