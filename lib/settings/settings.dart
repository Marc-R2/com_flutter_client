part of '../com_flutter_client.dart';

class Settings extends DynamicPage {
  const Settings({super.key});

  @override
  Map<String, DynamicPage> get pages => {
        'console': const InteractiveConsolePage(),
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Settings - Coming Soon'),
      ),
    );
  }
}
