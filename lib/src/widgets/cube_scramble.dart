import 'package:flutter/material.dart';

class CubeScramble extends StatelessWidget {
  const CubeScramble({
    Key? key,
    required String scrambleString,
  })  : _scrambleString = scrambleString,
        super(key: key);

  final String _scrambleString;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Text(
        _scrambleString,
        style: Theme.of(context).primaryTextTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }
}
