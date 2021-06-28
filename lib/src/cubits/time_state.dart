part of 'time_cubit.dart';

abstract class TimeState extends Equatable {
  const TimeState();

  @override
  List<Object> get props => [];
}

class TimesLoading extends TimeState {}

class TimesLoaded extends TimeState {
  final List<Time> times;

  TimesLoaded({required this.times});

  @override
  List<Object> get props => times;

  @override
  String toString() => 'TimesLoaded { times: $times }';
}

class TimeCreating extends TimeState {}

class TimeCreateSuccess extends TimeState {}
