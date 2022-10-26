part of 'com_flutter_client.dart';

class COMApp extends StatelessWidget {
  COMApp({
    super.key,
    required this.homePage,
    this.errorPage,
    this.initLang = 'en',
    required String appName,
    required String appVersion,
    List<Developer>? appDevelopers,
  }) {
    COMApp.appName = appName;
    COMApp.appVersion = appVersion;
    if (appDevelopers != null) COMApp.appDevelopers.addAll(appDevelopers);
  }

  final DynamicPage homePage;

  final Widget? errorPage;

  final String initLang;

  late BeamerDelegate routerDelegate = _routerDelegate;

  static String appName = 'ComFlutterClient';

  static String appVersion = '-1';

  static List<Developer> appDevelopers = [Developer.MarcRenken()];

  static final uri = GlobalData.nullable<String>();

  BeamerDelegate get _routerDelegate {
    final internalPages = <String, DynamicPage>{
      'settings': const SettingsPage(),
      'leave': LeavePage(child: homePage),
    };

    return BeamerDelegate(
      initialPath: '/$initLang',
      notFoundPage: BeamPage(
        key: const ValueKey('404'),
        child: DebugPathInfo(child: errorPage ?? const ErrorPage()),
      ),
      routeListener: (context, state) {
        uri.value = context.location;
        Message.trace(
          title: 'Switch Page',
          text: 'New location is {path}',
          log: true,
          templateValues: {'path': uri.value ?? 'unknown'},
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
