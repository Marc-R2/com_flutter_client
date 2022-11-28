import 'package:com_flutter_client/com_flutter_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DebugPathInfo extends StatefulWidget {
  const DebugPathInfo({super.key, required this.child});

  final Widget child;

  static bool disableDebug = false;

  static bool showDebugPathInfo = true;

  @override
  State<DebugPathInfo> createState() => _DebugPathInfoState();
}

class _DebugPathInfoState extends State<DebugPathInfo> {
  void toggleDebugPathInfo() {
    setState(() {
      DebugPathInfo.showDebugPathInfo = !DebugPathInfo.showDebugPathInfo;
    });
  }

  static const BorderRadius _borderRadiusTop = BorderRadius.only(
    bottomLeft: Radius.circular(8),
    bottomRight: Radius.circular(8),
  );

  static const BorderRadius _borderRadiusBottom = BorderRadius.only(
    topLeft: Radius.circular(8),
    topRight: Radius.circular(8),
  );

  bool mouseInRegion = false;

  void _onHover(PointerHoverEvent event) {
    final size = MediaQuery.of(context).size;

    if (event.localPosition.dy < size.height * 0.2) {
      if (!mouseInRegion) setState(() => mouseInRegion = true);
    } else {
      if (mouseInRegion) setState(() => mouseInRegion = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode || DebugPathInfo.disableDebug) return widget.child;
    if (!DebugPathInfo.showDebugPathInfo) {
      return MouseRegion(
        onHover: _onHover,
        child: Stack(
          children: [
            widget.child,
            AnimatedOpacity(
              opacity: mouseInRegion ? 1 : 0,
              duration: const Duration(milliseconds: 256),
              child: Align(
                alignment: const Alignment(0.8, -1),
                child: Material(
                  elevation: 4,
                  borderRadius: _borderRadiusTop,
                  child: InkWell(
                    onTap: toggleDebugPathInfo,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: _borderRadiusTop,
                      ),
                      child: const Text(
                        'Show Debug',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            InkWell(
              onTap: toggleDebugPathInfo,
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: DebugUriNavigationBar(),
              ),
            ),
            Expanded(child: widget.child),
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
              .sublist(0, uri.pathSegments.indexOf(segment) + 1)
              .join('/');

          return TextButton(
            onPressed: () => context.beamToNamed('/$path'),
            child: Text('/$segment'),
          );
        }),
      ],
    );
  }
}
