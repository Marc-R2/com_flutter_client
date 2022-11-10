part of '../com_flutter_client.dart';

/// Extend the BuildContext class with language getter
extension BuildContextLanguage on BuildContext {
  /// Get the current uri
  Uri? get uri => beamState?.uri;

  /// Get the current beam state
  BeamState? get beamState {
    try {
      return Beamer.of(this).currentBeamLocation.state as BeamState?;
    } catch (e, trace) {
      Message.error(
        title: 'Error getting BeamState',
        text: '$e',
        stackTrace: trace,
      );
      return null;
    }
  }

  /// Get the current language
  String get lang {
    try {
      if (beamState != null && beamState!.pathParameters.containsKey('lang')) {
        return beamState!.pathParameters['lang']!;
      } else {
        Message.info(
          title: 'No language found',
          text: 'Using default (en)',
        );
      }
    } catch (e, trace) {
      Message.warning(
        title: 'Error getting language',
        text: '$e',
        stackTrace: trace,
      );
    }
    return 'en';
  }

  void _beamToRaw(String path) {
    try {
      Beamer.of(this).beamToNamed(path);
    } catch (e, trace) {
      Message.error(
        title: 'Error beaming to $path',
        text: '$e',
        stackTrace: trace,
      );
    }
  }

  /// Beam to a new page
  void beamTo(String path) => _beamToRaw('/$lang/$path');

  /// Beam to a child page
  void beamToChild(String path) {
    final newUri = '${beamState!.uri}/$path';
    _beamToRaw(newUri);
  }
}
