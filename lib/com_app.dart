part of 'com_flutter_client.dart';

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
    const internalPages = <String, DynamicPage>{
      'settings': Settings(),
    };

    return BeamerDelegate(
      initialPath: '/$initLang',
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
      },
      locationBuilder: RoutesLocationBuilder(
        routes: homePage.buildRoutes(internalPages),
      ),
    );
  }

  Future<bool> leaveAppDialog(BuildContext context) async {
    final state = context.beamState;
    if (state != null && state.uri.pathSegments.length > 1) {
      routerDelegate.beamBack();
      return false;
    }

    var willLeave = false;

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Leave App'),
            content: const Text('Are you sure you want to leave the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  willLeave = true;
                  Navigator.of(context).pop();
                },
                child: const Text('Leave'),
              ),
            ],
          );
        });

    return willLeave;
  }

  @override
  Widget build(BuildContext context) {
    final routerDelegate = this.routerDelegate;
    return WillPopScope(
      onWillPop: () => leaveAppDialog(context),
      child: MaterialApp.router(
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
        backButtonDispatcher: BeamerBackButtonDispatcher(
          delegate: routerDelegate,
          alwaysBeamBack: true,
        ),
      ),
    );
  }
}
