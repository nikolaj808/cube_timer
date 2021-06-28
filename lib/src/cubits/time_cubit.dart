import 'package:bloc/bloc.dart';
import 'package:cube_timer/src/models/time.dart';
import 'package:cube_timer/src/repositories/times_repository.dart';
import 'package:equatable/equatable.dart';

part 'time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  final TimesRepository timesRepository;

  TimeCubit({required this.timesRepository}) : super(TimesLoading());

  Future<void> getTimes() async {
    final times = await timesRepository.getTimes();

    emit(TimesLoaded(times: times));
  }

  Future<void> createTime(Time time) async {
    final currentState = state;

    final currentTimes =
        currentState is TimesLoaded ? currentState.times : List<Time>.empty();

    emit(TimeCreating());

    final newTime = await timesRepository.createTime(time);

    emit(TimeCreateSuccess());

    emit(TimesLoaded(times: [...currentTimes, newTime]));
  }
}
