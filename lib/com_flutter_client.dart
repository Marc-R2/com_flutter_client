library com_flutter_client;

import 'package:com_flutter_client/com_flutter_client.dart';
import 'package:com_flutter_client/util/pill_select.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

export 'package:beamer/beamer.dart';
export 'package:com_client/com_client.dart';

part 'com_app.dart';

part 'local/local_text.dart';

part 'page_logic/dynamic_page.dart';

part 'page_logic/leave_page.dart';

part 'page_logic/settings_page.dart';

part 'settings/about/about_page.dart';

part 'settings/accessibility/accessibility_page.dart';

part 'settings/account/account_page.dart';

part 'settings/appearance/appearance_page.dart';

part 'settings/feedback/feedback_page.dart';

part 'settings/help/help_page.dart';

part 'settings/language/language_page.dart';

part 'settings/notifications/notifications_page.dart';

part 'settings/privacy/privacy_page.dart';

part 'settings/debug/console/interactive_console.dart';

part 'settings/debug/console/log_console.dart';

part 'settings/debug/console/log_message.dart';

part 'settings/debug/debug_page.dart';

part 'settings/settings_page.dart';

part 'task/field_builder.dart';

part 'task/sized_field_builder.dart';

part 'task/task_not_found.dart';

part 'task/task_request_scope.dart';

part 'util/home_button.dart';

part 'util/settings_button.dart';

extension WidgetData on Widget {
  static Map<Widget, Map<String, dynamic>> _pageData = {};

  static Map<String, dynamic> _globalData = {};

  static dynamic getGlobalData(String key) => _globalData[key];

  static void setGlobalData(String key, dynamic value) =>
      _globalData[key] = value;

  Map<String, dynamic> get data => _pageData[this] ??= {};

  dynamic getData(String key) => data[key];
}

// Extend the BuildContext class with language getter
extension BuildContextLanguage on BuildContext {
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

  void beamTo(String path) => _beamToRaw('/$lang/$path');

  void beamToChild(String path) {
    final newUri = '${beamState!.uri}/$path';
    _beamToRaw(newUri);
  }
}
