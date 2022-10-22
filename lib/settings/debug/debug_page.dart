part of '../../../com_flutter_client.dart';

class DebugPage extends SettingsChildPage {
  const DebugPage({super.key});

  @override
  Map<String, DynamicPage> get pages => {
        'console': const InteractiveConsolePage(),
        'server': const ServerDebugPage(),
      };

  @override
  Icon get overviewIcon => const Icon(Icons.code);

  @override
  Widget? get overviewSubtitle => const Text(
        'Warning: This one might be a bit nerdy', // Please be careful!
      );

  @override
  Widget get overviewTitle => const Text('Debug');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Console'),
            subtitle: const Text('Sure you want to see this?!'),
            leading: const Icon(Icons.code),
            onTap: () => context.beamToChild('console'),
          ),
          /*SwitchListTile(
            value: DebugPathInfo.disableDebug,
            onChanged: (value) {
              DebugPathInfo.disableDebug = value;
            },
          ),*/
          ListTile(
            title: const Text('Server'),
            // subtitle: const Text(''),
            leading: const Icon(Icons.network_check),
            onTap: () => context.beamToChild('server'),
          ),
        ],
      ),
    );
  }
}
