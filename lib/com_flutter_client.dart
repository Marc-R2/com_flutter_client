library com_flutter_client;

export 'package:com_client/com_client.dart';

import 'package:com_flutter_client/com_flutter_client.dart';
import 'package:flutter/material.dart';

part 'console/log_console.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
