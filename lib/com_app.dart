part of 'com_flutter_client.dart';

class COMApp extends StatelessWidget {
  COMApp({
    super.key,
    required this.homePage,
    this.errorPage,
    this.initLang = 'en',
  });

  final DynamicPage homePage;

  final Widget? errorPage;

  final String initLang;

  late BeamerDelegate routerDelegate = _routerDelegate;

  BeamerDelegate get _routerDelegate {
    const internalPages = <String, DynamicPage>{
      'settings': Settings(),
    };

    return BeamerDelegate(
      initialPath: '/$initLang',
      notFoundPage: BeamPage(
        key: const ValueKey('404'),
        child: errorPage ?? const ErrorPage(),
      ),
      routeListener: (context, state) {
        Message.trace(
          title: 'Switch Page',
          text: 'New location is {path}',
          log: true,
          templateValues: {'path': context.location ?? 'unknown'},
        );
      },
      locationBuilder: RoutesLocationBuilder(
        routes: homePage.buildRoutes(internalPages),
        //{'/:lang': (context, state, data) => homePage}, //
        builder: (context, child) => child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If app is in debug mode
    if (kDebugMode) {
      Wakelock.enable();
      Message.warning(title: 'Wakelock enabled');
    }

    // routerDelegate = _routerDelegate;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routerDelegate,
        // alwaysBeamBack: true,
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('404'),
        actions: const [GoHomeIcon()],
      ),
      body: const Center(child: Text('404 - Not Found')),
    );
  }
}
