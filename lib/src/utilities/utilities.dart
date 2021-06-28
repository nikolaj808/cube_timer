import 'dart:math';

class Utilities {
  static List<String> get _options => [
        'F',
        'B',
        'L',
        'R',
        'U',
        'D',
      ];

  static String _getRandomOption() {
    final random = Random();

    final options = _options;

    final randomNumber = random.nextInt(options.length);

    return options.elementAt(randomNumber);
  }

  static String _getRandomExtension() {
    final random = Random();

    final randomNumber = random.nextInt(3);

    if (randomNumber == 0)
      return '';
    else if (randomNumber == 1)
      return '2';
    else
      return '\'';
  }

  static String generateRandomScrambleString({int amount = 25}) {
    String _scrambleString = '';

    for (var i = 0; i < 25; i++) {
      _scrambleString += '${_getRandomOption()}${_getRandomExtension()} ';
    }

    return _scrambleString;
  }
}
