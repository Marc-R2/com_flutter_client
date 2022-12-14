part of '../../com_flutter_client.dart';

class AccessibilityPage extends SettingsChildPage {
  const AccessibilityPage({super.key});

  @override
  Map<String, DynamicPage> get pages => {};

  @override
  Icon get overviewIcon => const Icon(Icons.accessibility);

  @override
  Widget? get overviewSubtitle => null;

  @override
  Widget get overviewTitle => const Text('Accessibility');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Accessibility'),
        ),
        body: const Center(
          child: Text('Accessibility'),
        ),
      );
}
