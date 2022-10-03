part of '../../com_flutter_client.dart';

class AppearancePage extends SettingsPage {
  const AppearancePage({super.key});

  @override
  Map<String, DynamicPage> get pages => {};

  @override
  Icon get overviewIcon => const Icon(Icons.color_lens);

  @override
  Widget? get overviewSubtitle => null;

  @override
  Widget get overviewTitle => const Text('Appearance');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Appearance'),
        ),
        body: const Center(
          child: Text('Appearance'),
        ),
      );
}
