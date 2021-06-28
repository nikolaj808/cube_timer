import 'package:equatable/equatable.dart';

class Time extends Equatable {
  final int? id;
  final int time;
  final DateTime createdAt;

  const Time({
    this.id,
    required this.time,
    required this.createdAt,
  });

  Time copyWith({
    int? id,
    int? time,
    DateTime? createdAt,
  }) {
    return Time(
      id: id ?? this.id,
      time: time ?? this.time,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Time.fromMap(Map<String, dynamic> map) {
    return Time(
      id: map['id'] as int,
      time: map['time'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  @override
  List<Object> get props => [id ?? -1, time, createdAt];
}
