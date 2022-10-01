part of '../com_flutter_client.dart';

typedef PageBuilder = DynamicPage Function(BuildContext, BeamState, Object?);

abstract class DynamicPage extends StatelessWidget {
  const DynamicPage({super.key});

  Map<String, DynamicPage> get pages;

  Map<String, PageBuilder> _buildRoutes([
    Map<String, DynamicPage> additional = const {},
  ]) {
    final routes = <String, PageBuilder>{};
    final pages = this.pages..addAll(additional);
    pages.forEach((key, value) {
      value._buildRoutes().forEach((path, value) {
        routes['/$key$path'] = value;
      });
      routes['/$key'] = (context, state, data) => value;
    });
    routes[''] = (context, state, data) => this;
    return routes;
  }

  Map<String, PageBuilder> buildRoutes([
    Map<String, DynamicPage> additional = const {},
  ]) {
    final routes = <String, PageBuilder>{};
    final newRoutes = _buildRoutes(additional);
    newRoutes.forEach((key, value) {
      print('Adding route: /:lang$key => $value');
      routes['/:lang$key'] = value;
    });
    routes['/:lang'] = (context, state, data) => this;
    print('Routes: $routes');
    return routes;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DynamicPage { pages: $pages }';
  }
}
