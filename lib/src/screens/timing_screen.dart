import 'package:cube_timer/src/widgets/cube_scramble.dart';
import 'package:cube_timer/src/widgets/cube_timing.dart';
import 'package:cube_timer/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimingScreen extends StatefulWidget {
  @override
  _TimingScreenState createState() => _TimingScreenState();
}

class _TimingScreenState extends State<TimingScreen> {
  Color? _centerTextColor;

  late StopWatchTimer _stopWatchTimer;

  late String _scrambleString;

  void _startTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  void _stopTimer() {
    _saveTime();
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  void _resetTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
  }

  void _saveTime() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
  }

  @override
  void initState() {
    _stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);

    _stopWatchTimer.records.listen((records) {
      if (records.isNotEmpty) print(records.first.rawValue);
    });

    _scrambleString = Utilities.generateRandomScrambleString();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (_stopWatchTimer.isRunning) {
          _stopTimer();
        }
      },
      onTapDown: (_) {
        if (_stopWatchTimer.isRunning) {
          _stopTimer();
        }

        setState(() {
          _centerTextColor = Colors.red;
        });
      },
      onTapUp: (_) {
        setState(() {
          _centerTextColor = Colors.white;
        });
      },
      onLongPressStart: (_) {
        setState(() {
          _centerTextColor = Colors.green;
        });
      },
      onLongPressEnd: (_) {
        if (!_stopWatchTimer.isRunning) {
          _resetTimer();
          _startTimer();
        }
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CubeScramble(
              scrambleString: _scrambleString,
            ),
            CubeTiming(
              stopWatchTimer: _stopWatchTimer,
              centerTextColor: _centerTextColor,
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
