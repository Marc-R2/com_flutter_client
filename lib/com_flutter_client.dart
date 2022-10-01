library com_flutter_client;

export 'package:com_client/com_client.dart';
export 'package:beamer/beamer.dart';

import 'package:com_flutter_client/com_flutter_client.dart';
import 'package:com_flutter_client/util/pill_select.dart';
import 'package:flutter/material.dart';

part 'console/log_console.dart';

part 'console/log_message.dart';

part 'console/interactive_console.dart';

part 'local/local_text.dart';

part 'pages/dynamic_page.dart';

part 'settings/settings.dart';

part 'settings/settings_button.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class COMApp extends StatelessWidget {
  const COMApp({
    super.key,
    required this.homePage,
    this.errorPage,
    this.initLang = 'en',
  });

  final DynamicPage homePage;

  final Widget? errorPage;

  final String initLang;

  BeamerDelegate get routerDelegate {
    final pages = <String, DynamicPage>{
      'settings': const Settings(),
    };

    print('Home Page: $homePage');
    print('Home Page Pages: $pages');

    return BeamerDelegate(
      initialPath: '/$initLang',
      notFoundPage: BeamPage(
        key: const ValueKey('404'),
        child: errorPage ??
            const Scaffold(body: Center(child: Text('404 - Not Found'))),
      ),
      locationBuilder: RoutesLocationBuilder(
        routes: homePage.buildRoutes(pages),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routerDelegate = this.routerDelegate;
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
