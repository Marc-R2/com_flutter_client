part of '../com_flutter_client.dart';

abstract class SettingsPage extends DynamicPage {
  const SettingsPage({super.key});

  Widget get overviewTitle;

  Widget? get overviewSubtitle;

  Icon get overviewIcon;
}
