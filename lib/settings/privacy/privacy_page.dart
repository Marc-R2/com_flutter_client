part of '../../com_flutter_client.dart';

class PrivacyPage extends SettingsPage {
  const PrivacyPage({super.key});

  @override
  Map<String, DynamicPage> get pages => {};

  @override
  Icon get overviewIcon => const Icon(Icons.privacy_tip);

  @override
  Widget? get overviewSubtitle => null;

  @override
  Widget get overviewTitle => const Text('Privacy');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Privacy'),
        ),
        body: const Center(
          child: Text('Privacy'),
        ),
      );
}
