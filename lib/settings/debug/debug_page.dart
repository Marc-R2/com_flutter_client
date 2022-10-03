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
  Widget? get overviewSubtitle => null;

  @override
  Widget get overviewTitle => const Text('Interactive Console');

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Debug'),
      ),
    );
  }
}
