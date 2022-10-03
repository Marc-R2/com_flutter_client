part of '../../com_flutter_client.dart';

class AboutPage extends SettingsPage {
  const AboutPage({super.key});

  @override
  Map<String, DynamicPage> get pages => {};

  @override
  Icon get overviewIcon => const Icon(Icons.info);

  @override
  Widget? get overviewSubtitle => null;

  @override
  Widget get overviewTitle => const Text('About');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('About'),
        ),
        body: const Center(
          child: Text('About'),
        ),
      );
}
