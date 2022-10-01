part of '../com_flutter_client.dart';

class Settings extends DynamicPage {
  const Settings({super.key});

  @override
  Map<String, SettingsPage> get pages => {
        'console': const InteractiveConsolePage(),
      };

  void beamToChild(BuildContext context, String path) {
    final state = context.beamState;
    final newUri = '${state!.uri.toString()}/$path';
    context.beamToNamed(newUri);
  }

  @override
  Widget build(BuildContext context) {
    final pages = this.pages;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
            onTap: () => beamToChild(context, key),
          );
        },
      ),
    );
  }
}
