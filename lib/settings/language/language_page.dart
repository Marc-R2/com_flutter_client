part of '../../com_flutter_client.dart';

class LanguagePage extends SettingsPage {
  const LanguagePage({super.key});

  @override
  Map<String, DynamicPage> get pages => {};

  @override
  Icon get overviewIcon => const Icon(Icons.language);

  @override
  Widget? get overviewSubtitle => null;

  @override
  Widget get overviewTitle => const Text('Language');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Language'),
        ),
        body: const Center(
          child: Text('Language'),
        ),
      );
}
