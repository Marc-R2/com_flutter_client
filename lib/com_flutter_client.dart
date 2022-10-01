library com_flutter_client;

export 'package:com_client/com_client.dart';
export 'package:beamer/beamer.dart';

import 'package:com_flutter_client/com_flutter_client.dart';
import 'package:com_flutter_client/settings/settings.dart';
import 'package:com_flutter_client/util/pill_select.dart';
import 'package:flutter/material.dart';

part 'console/log_console.dart';

part 'console/log_message.dart';

part 'console/interactive_console.dart';

part 'local/local_text.dart';

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
    initialPath: '/de',
    notFoundPage: BeamPage(
      key: const ValueKey('404'),
      child: errorPage ??
          const Scaffold(
            body: Center(
              child: Text('404 - Not Found'),
            ),
          ),
    ),
    locationBuilder: RoutesLocationBuilder(
      routes: {
        //'/': (context, state, data) => homePage,
        '/:lang': (context, state, data) => homePage,
        //'/settings': (context, state, data) => const Settings(key: ValueKey('/settings - langLess')),
        '/:lang/settings': (context, state, data) => const Settings(),
        //'/settings/console': (context, state, data) => const InteractiveConsole(key: ValueKey('/settings/console - langLess')),
        '/:lang/settings/console': (context, state, data) =>
            const InteractiveConsole(),
        //'/settings/console/log': (context, state, data) => const LogConsole(key: ValueKey('/settings/console/log - langLess')),
        '/:lang/settings/console/log': (context, state, data) =>
            const LogConsole(),
        //'/settings/console/log/:message': (context, state, data) => homePage,
        '/:lang/settings/console/:message': (context, state, data) =>
            const LogMessagePage(),
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routerDelegate,
        alwaysBeamBack: true,
      ),
    );
  }
}

// Extend the BuildContext class with language getter
extension BuildContextLanguage on BuildContext {
  BeamState? get beamState {
    try {
      return Beamer.of(this).currentBeamLocation.state as BeamState;
    } catch (e, trace) {
      Message.error(
        title: 'Error getting BeamState',
        text: '$e',
        stackTrace: trace,
      );
      return null;
    }
  }

  String get lang {
    try {
      if (beamState != null) return beamState!.pathParameters['lang']!;
    } catch (e, trace) {
      Message.warning(
        title: 'Error getting language',
        text: '$e',
        stackTrace: trace,
      );
    }
    return 'en';
  }
}
