library com_flutter_client;

export 'package:com_client/com_client.dart';
export 'package:beamer/beamer.dart';

import 'package:com_flutter_client/com_flutter_client.dart';
import 'package:com_flutter_client/settings/settings.dart';
import 'package:com_flutter_client/util/pill_select.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

part 'console/log_console.dart';

part 'console/interactive_console.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class COMApp extends StatelessWidget {
  COMApp({
    super.key,
    required this.homePage,
    this.errorPage,
  });

  final Widget homePage;
  final Widget? errorPage;

  late final routerDelegate = BeamerDelegate(
    initialPath: '/',
    notFoundPage: BeamPage(
      key: const ValueKey('404'),
      child: errorPage ?? const Scaffold(
        body: Center(
          child: Text('404 - Not Found'),
        ),
      ),
    ),
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => homePage,
        '/settings': (context, state, data) => const Settings(),
        '/settings/console': (context, state, data) => const InteractiveConsole(),
        '/settings/console/log': (context, state, data) => const LogConsole(),
        '/settings/console/log/:message': (context, state, data) => homePage,
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
    );
  }
}
