import 'package:cube_timer/src/screens/stats_screen.dart';
import 'package:cube_timer/src/screens/timing_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0);

  late int _currentIndex;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
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
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: [
          TimingScreen(),
          StatsScreen(),
        ],
      ),
    );
  }
}
