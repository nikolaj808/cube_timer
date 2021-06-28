import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CubeTiming extends StatelessWidget {
  const CubeTiming({
    Key? key,
    required StopWatchTimer stopWatchTimer,
    required Color? centerTextColor,
  })  : _stopWatchTimer = stopWatchTimer,
        _centerTextColor = centerTextColor,
        super(key: key);

  final StopWatchTimer _stopWatchTimer;
  final Color? _centerTextColor;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _stopWatchTimer.rawTime,
      initialData: 0,
      builder: (context, snapshot) {
        final value = snapshot.data!;

        final displayTime = StopWatchTimer.getDisplayTime(
          value,
          hours: false,
        );

        return Text(
          displayTime,
          style: Theme.of(context).primaryTextTheme.headline2?.copyWith(
                color: _centerTextColor ??
                    Theme.of(context).primaryTextTheme.headline6?.color,
              ),
        );
      },
    );
  }
}
