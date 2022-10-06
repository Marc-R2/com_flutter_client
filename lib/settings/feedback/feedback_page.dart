part of '../../com_flutter_client.dart';

class FeedbackPage extends SettingsChildPage {
  const FeedbackPage({super.key});

  @override
  Map<String, DynamicPage> get pages => {};

  @override
  Icon get overviewIcon => const Icon(Icons.feedback);

  @override
  Widget? get overviewSubtitle => null;

  @override
  Widget get overviewTitle => const Text('Feedback');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Feedback'),
        ),
        body: const Center(
          child: Text('Feedback'),
        ),
      );
}
