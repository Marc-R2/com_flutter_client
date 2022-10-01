part of '../com_flutter_client.dart';

class InteractiveConsolePage extends SettingsPage {
  const InteractiveConsolePage({super.key});

  @override
  Map<String, DynamicPage> get pages => {
        ':message': const LogMessagePage(),
      };

  @override
  Icon get overviewIcon => const Icon(Icons.code);

  @override
  Widget? get overviewSubtitle => null;

  @override
  Widget get overviewTitle => const Text('Interactive Console');

  @override
  Widget build(BuildContext context) => const InteractiveConsole();
}

class InteractiveConsole extends StatefulWidget {
  const InteractiveConsole({Key? key}) : super(key: key);

  @override
  State<InteractiveConsole> createState() => _InteractiveConsoleState();
}

class _InteractiveConsoleState extends State<InteractiveConsole> {
  bool showTrace = false;
  bool showDebug = false;
  bool showInfo = true;
  bool showWarning = true;
  bool showError = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Console'),
        actions: const [GoHomeIcon()],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  PillSelect(
                    selected: showTrace,
                    onChanged: (value) => setState(() => showTrace = value),
                    color: Colors.greenAccent,
                    icon: const Icon(Icons.bug_report),
                    child: const Text('Trace'),
                  ),
                  PillSelect(
                    selected: showDebug,
                    onChanged: (value) => setState(() => showDebug = value),
                    color: Colors.green,
                    icon: const Icon(Icons.info_outline),
                    child: const Text('Debug'),
                  ),
                  PillSelect(
                    selected: showInfo,
                    onChanged: (value) => setState(() => showInfo = value),
                    color: Colors.blue,
                    icon: const Icon(Icons.info_outline),
                    child: const Text('Info'),
                  ),
                  PillSelect(
                    selected: showWarning,
                    onChanged: (value) => setState(() => showWarning = value),
                    color: Colors.orange,
                    icon: const Icon(Icons.warning),
                    child: const Text('Warning'),
                  ),
                  PillSelect(
                    selected: showError,
                    onChanged: (value) => setState(() => showError = value),
                    color: Colors.red,
                    icon: const Icon(Icons.error_outline),
                    child: const Text('Error'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: LogConsole(
              showTrace: showTrace,
              showDebug: showDebug,
              showInfo: showInfo,
              showWarning: showWarning,
              showError: showError,
            ),
          )
        ],
      ),
    );
  }
}
