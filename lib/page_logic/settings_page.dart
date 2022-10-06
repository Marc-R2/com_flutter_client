part of '../com_flutter_client.dart';

abstract class SettingsChildPage extends DynamicPage {
  const SettingsChildPage({super.key});

  Widget get overviewTitle;

  Widget? get overviewSubtitle;

  Icon get overviewIcon;
}
