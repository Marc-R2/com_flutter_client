part of '../../../com_flutter_client.dart';

class DebugPage extends SettingsPage {
  const DebugPage({super.key});

  @override
  Map<String, DynamicPage> get pages => {
        'console': const InteractiveConsolePage(),
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
      body: const Center(
        child: Text('Debug'),
      ),
    );
  }
}
