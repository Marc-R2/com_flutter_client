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

  late final BeamerDelegate routerDelegate = _routerDelegate;

  BeamerDelegate get _routerDelegate {
    const internalPages = <String, DynamicPage>{
      //'settings': Settings(),
    };

    return BeamerDelegate(
      /*initialPath: '/$initLang',
      notFoundPage: BeamPage(
        key: const ValueKey('404'),
        child: errorPage ??
            const Scaffold(body: Center(child: Text('404 - Not Found'))),
      ),
      routeListener: (context, state) {
        Message.trace(
          title: 'Switch Page',
          text: 'New location is {path}',
          log: true,
          templateValues: {'path': context.location ?? 'unknown'},
        );
      },*/
      locationBuilder: RoutesLocationBuilder(
        routes: {
          '/': (context, state, data) => homePage,
        },// homePage.buildRoutes(internalPages),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
