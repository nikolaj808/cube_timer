import 'dart:async';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _running = false;
  Color? _centerTextColor;
  Stream<double>? _stream;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cube Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(primaryColor: Colors.indigo),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.star_outline),
          onPressed: () {
            if (_running) {
              setState(() {
                _running = false;
              });
            } else {
              setState(() {
                _stream = Stream<double>.periodic(Duration(milliseconds: 1),
                        (x) => double.parse(((x) / 1000).toStringAsFixed(3)))
                    .takeWhile((_) => _running);
                _running = true;
              });
            }
          },
        ),
        appBar: AppBar(
          elevation: 0,
          title: Text('Cube Timer'),
        ),
        body: GestureDetector(
          onLongPressStart: (_) {
            setState(() {
              _centerTextColor = Colors.green;
            });
          },
          onLongPressEnd: (_) {
            setState(() {
              _centerTextColor = Colors.white;
            });
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'R2 F2 R2 D2 F2 R2 F R B R L R L R L R R2 R2 R2',
                    style: Theme.of(context).primaryTextTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                StreamBuilder(
                    stream: _stream,
                    initialData: 0.0,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return Text(
                          (snapshot.data as double).toStringAsFixed(3),
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline2
                              ?.copyWith(
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .headline6
                                    ?.color,
                              ),
                          textAlign: TextAlign.left,
                        );
                      }

                      return Container();
                    }),
                Text(
                  'Ready',
                  style: Theme.of(context).primaryTextTheme.headline2?.copyWith(
                        color: _centerTextColor ??
                            Theme.of(context).primaryTextTheme.headline6?.color,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
