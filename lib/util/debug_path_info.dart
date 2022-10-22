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
            const Padding(
              padding: EdgeInsets.all(8),
              child: DebugUriNavigationBar(),
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class DebugUriNavigationBar extends StatelessWidget {
  const DebugUriNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uri = context.uri;
    if (uri == null) return const SizedBox();
    return Row(
      children: [
        ...uri.pathSegments.map((segment) {
          // Simple Button to beam to the path till the segment
          final path = uri.pathSegments
              .sublist(0, uri.pathSegments.indexOf(segment) + 1).join('/');
          print(path);
          return TextButton(
            onPressed: () => context.beamToNamed('/$path'),
            child: Text('/$segment'),
          );
        }),
      ],
    );
  }
}
