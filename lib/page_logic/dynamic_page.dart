part of '../com_flutter_client.dart';

typedef PageBuilder = BeamPage Function(BuildContext, BeamState, Object?);

abstract class DynamicPage extends StatelessWidget {
  const DynamicPage({super.key});

  Map<String, DynamicPage> get pages;

  BeamPageType get transition => BeamPageType.material;

  Future<bool> onPopMainPage(BuildContext context) async {
    context.beamToChild('leave');
    return false;
  }

  Map<String, DynamicPage> _buildRoutes([
    Map<String, DynamicPage> additional = const {},
  ]) {
    final routes = <String, DynamicPage>{};
    <String, DynamicPage>{...pages, ...additional}.forEach((key, value) {
      value._buildRoutes().forEach((path, value) {
        routes['/$key$path'] = value;
      });
      routes['/$key'] = value;
    });
    routes[''] = this;
    return routes;
  }

  Map<String, PageBuilder> buildRoutes([
    Map<String, DynamicPage> additional = const {},
  ]) {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final routes = <String, PageBuilder>{};
    _buildRoutes(additional).forEach((key, value) {
      // print('Adding route: /:lang$key => $value');
      final page = BeamPage(
        key: ValueKey('$key-?@?-$time'),
        type: value.transition,
        child: DebugPathInfo(child: value),
      );
      routes['/:lang$key'] = (context, state, data) => page;
    });
    routes['/:lang'] = (context, state, data) => BeamPage(
          key: ValueKey('/-?@?-$time'),
          type: transition,
          child: WillPopScope(
            onWillPop: () => onPopMainPage(context),
            child: DebugPathInfo(child: this),
          ),
        );
    // print('Routes: $routes');
    return routes;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DynamicPage { page_logic: $pages }';
  }
}
