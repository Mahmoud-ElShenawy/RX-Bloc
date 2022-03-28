Future<void> delayMilliseconds(int milliseconds) =>
    Future.delayed(Duration(milliseconds: milliseconds));

Future<void> delaySeconds(int seconds) =>
    Future.delayed(Duration(seconds: seconds));
