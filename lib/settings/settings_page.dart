part of '../com_flutter_client.dart';

class SettingsPage extends DynamicPage {
  const SettingsPage({super.key});

  @override
  Map<String, SettingsChildPage> get pages => {
        'language': const LanguagePage(),
        'appearance': const AppearancePage(),
        'account': const AccountPage(),
        'notifications': const NotificationsPage(),
        'accessibility': const AccessibilityPage(),
        'privacy': const PrivacyPage(),
        'help': const HelpPage(),
        'feedback': const FeedbackPage(),
        'debug': const DebugPage(),
        'about': const AboutPage(),
      };

  void _beamToChild(BuildContext context, String path) {
    final state = context.beamState;
    final newUri = '${state!.uri}/$path';
    context.beamToNamed(newUri);
  }

  @override
  Widget build(BuildContext context) {
    final pages = this.pages;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: const [GoHomeIcon()],
      ),
      body: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final key = pages.keys.elementAt(index);
          final page = pages[key]!;
          return ListTile(
            title: page.overviewTitle,
            subtitle: page.overviewSubtitle,
            leading: page.overviewIcon,
            onTap: () => _beamToChild(context, key),
          );
        },
      ),
    );
  }
}
