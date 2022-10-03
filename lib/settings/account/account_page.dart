part of '../../com_flutter_client.dart';

class AccountPage extends SettingsPage {
  const AccountPage({super.key});

  @override
  Map<String, DynamicPage> get pages => {};

  @override
  Icon get overviewIcon => const Icon(Icons.account_circle);

  @override
  Widget? get overviewSubtitle => null;

  @override
  Widget get overviewTitle => const Text('Account');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('My Account'),
        ),
        body: const Center(
          child: Text('Account'),
        ),
      );
}
