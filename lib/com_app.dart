part of 'com_flutter_client.dart';

/// The startpoint for any COM-Application.
class COMApp extends StatelessWidget {
  /// The startpoint for any COM-Application.
  COMApp({
    super.key,
    required this.homePage,
    this.errorPage,
    this.initLang = 'en',
    this.themeMode = ThemeMode.system,
    required String appName,
    required String appVersion,
    List<Developer>? appDevelopers,
    this.wakelock = false,
    this.theme,
  }) {
    COMApp.appName = appName;
    COMApp.appVersion = appVersion;
    if (appDevelopers != null) COMApp.appDevelopers.addAll(appDevelopers);
  }

  /// The default [ThemeMode] for the app.
  final ThemeMode themeMode;

  /// Whether to keep the device awake by default.
  final bool wakelock;

  /// The first page to show.
  final DynamicPage homePage;

  /// The page to show if an error occurs.
  final Widget? errorPage;

  /// The initial language to use.
  final String initLang;

  /// The theme of the app.
  final ThemeData? theme;

  /// The router responsible for routing the pages.
  late BeamerDelegate routerDelegate = _routerDelegate;

  /// The name of the app.
  static String appName = 'ComFlutterClient';

  /// The version of the app.
  static String appVersion = '-1';

  /// The developers of the app.
  static List<Developer> appDevelopers = [const Developer.MarcRenken()];

  /// The uri in a [GlobalData] object.
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
    if ((kDebugMode || wakelock) && !kIsWeb) {
      Wakelock.enable();
      Message.warning(title: 'Wakelock enabled');
    }

    // routerDelegate = _routerDelegate;
    return MaterialApp.router(
      themeMode: themeMode,
      theme: theme,
      darkTheme: ThemeData.dark(),
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
