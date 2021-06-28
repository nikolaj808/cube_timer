import 'package:animated_background/animated_background.dart';
import 'package:cube_timer/src/cubits/time_cubit.dart';
import 'package:cube_timer/src/models/time.dart';
import 'package:cube_timer/src/widgets/cube_scramble.dart';
import 'package:cube_timer/src/widgets/cube_timing.dart';
import 'package:cube_timer/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimingScreen extends StatefulWidget {
  @override
  _TimingScreenState createState() => _TimingScreenState();
}

class _TimingScreenState extends State<TimingScreen>
    with TickerProviderStateMixin {
  bool _started = false;

  Color? _centerTextColor;

  late StopWatchTimer _stopWatchTimer;

  late String _scrambleString;

  void _startTimer() {
    setState(() {
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
      _started = true;
    });
  }

  void _stopTimer() {
    setState(() {
      _saveTime();
      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
      _started = false;
    });
  }

  void _resetTimer() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
  }

  void _saveTime() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
  }

  Widget _getTimingScreenWrapper({required Widget child}) {
    if (!_started) {
      return child;
    }

    return AnimatedBackground(
      vsync: this,
      behaviour: RandomParticleBehaviour(
        options: ParticleOptions(
          image: Image.asset('assets/cube.png'),
          spawnOpacity: 0.0,
          opacityChangeRate: 0.25,
          minOpacity: 0.3,
          maxOpacity: 0.6,
          spawnMinSpeed: 30.0,
          spawnMaxSpeed: 70.0,
          spawnMinRadius: 20.0,
          spawnMaxRadius: 30.0,
          particleCount: 40,
        ),
      ),
      child: child,
    );
  }

  @override
  void initState() {
    _stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);

    _stopWatchTimer.records.listen((records) {
      if (records.isNotEmpty)
        context.read<TimeCubit>().createTime(Time(
              time: records.first.rawValue!,
              createdAt: DateTime.now(),
            ));
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
      child: _getTimingScreenWrapper(
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
