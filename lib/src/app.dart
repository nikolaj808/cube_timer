import 'package:cube_timer/src/pages/home_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cube Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(primaryColor: Colors.indigo),
      home: HomePage(),
    );
  }
}
