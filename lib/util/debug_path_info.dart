import 'package:com_flutter_client/com_flutter_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DebugPathInfo extends StatelessWidget {
  const DebugPathInfo({super.key, required this.child});

  final Widget child;

  static bool disableDebug = false;

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode || disableDebug) return child;
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(context.uri.toString()),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
