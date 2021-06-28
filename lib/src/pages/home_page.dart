import 'package:cube_timer/src/screens/stats_screen.dart';
import 'package:cube_timer/src/screens/timing_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _changePage(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          print(index);
          _changePage(index);
        },
        items: [
          BottomNavigationBarItem(
            label: 'Timing',
            tooltip: 'Timing',
            icon: Icon(Icons.timer_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Stats',
            tooltip: 'Stats',
            icon: Icon(Icons.stacked_bar_chart_rounded),
          ),
        ],
      ),
      body: PageView(
        onPageChanged: _changePage,
        children: [
          TimingScreen(),
          StatsScreen(),
        ],
      ),
    );
  }
}
