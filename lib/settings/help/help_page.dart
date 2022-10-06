part of '../../com_flutter_client.dart';

class HelpPage extends SettingsChildPage {
  const HelpPage({super.key});

  @override
  Map<String, DynamicPage> get pages => {};

  @override
  Icon get overviewIcon => const Icon(Icons.help);

  @override
  Widget? get overviewSubtitle => null;

  @override
  Widget get overviewTitle => const Text('Help');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Help'),
        ),
        body: const Center(
          child: Text('Help'),
        ),
      );
}
