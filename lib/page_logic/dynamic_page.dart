part of '../com_flutter_client.dart';

typedef PageBuilder = DynamicPage Function(BuildContext, BeamState, Object?);

class DynamicPageWrapper extends DynamicPage {
  const DynamicPageWrapper({
    required super.key,
    required this.child,
  });

  final DynamicPage child;

  @override
  Map<String, DynamicPage> get pages => child.pages;

  @override
  Widget build(BuildContext context) => child;
}

abstract class DynamicPage extends StatelessWidget {
  const DynamicPage({super.key});

  Map<String, DynamicPage> get pages;

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
      print('Adding route: /:lang$key => $value');
      routes['/:lang$key'] = (context, state, data) => DynamicPageWrapper(
            key: ValueKey('$key-?@?-$time'),
            child: value,
          );
    });
    routes['/:lang'] = (context, state, data) => this;
    print('Routes: $routes');
    return routes;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DynamicPage { page_logic: $pages }';
  }
}
