part of '../../../com_flutter_client.dart';

class ServerDebugPage extends DynamicPage {
  const ServerDebugPage({super.key});

  @override
  Map<String, DynamicPage> get pages => {};

  @override
  Widget build(BuildContext context) => const LogConsole();
}
