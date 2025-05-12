import 'dart:io' show Platform;

// on real IO platforms, forward to Platform.isWindows
final bool isWindows = Platform.isWindows;
